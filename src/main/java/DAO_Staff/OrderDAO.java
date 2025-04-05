package DAO_Staff;

import DB.DBContext;
import Model_Staff.Order;
import Model_Staff.OrderDetail;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Product;

public class OrderDAO {

    private Connection conn;

    public OrderDAO() {
        this.conn = new DBContext().getConnection();
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, u.user_id, u.name, u.phone, os.status_name, o.created_at,\n"
                + "       (SELECT SUM(od.quantity * pv.price) \n"
                + "        FROM OrderDetails od \n"
                + "        JOIN ProductVariants pv ON od.variant_id = pv.variant_id \n"
                + "        WHERE od.order_id = o.order_id) AS total_price\n"
                + "FROM Orders o\n"
                + "JOIN Users u ON o.user_id = u.user_id\n"
                + "JOIN OrderStatus os ON o.status_id = os.status_id\n"
                + "ORDER BY o.status_id ASC, o.created_at DESC;";

        try ( PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("status_name"),
                        rs.getTimestamp("created_at"),
                        rs.getDouble("total_price")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT \n"
                + "    o.order_id,\n"
                + "    u.user_id,\n"
                + "    u.name,\n"
                + "    u.phone,\n"
                + "	u.shipping_address,\n"
                + "    os.status_name AS order_status,\n"
                + "    o.created_at AS order_date,\n"
                + "    (\n"
                + "        SELECT SUM(od.quantity * pv.price)\n"
                + "        FROM OrderDetails od\n"
                + "        JOIN ProductVariants pv ON od.variant_id = pv.variant_id\n"
                + "        WHERE od.order_id = o.order_id\n"
                + "    ) AS total_price,\n"
                + "    p.image_data,\n"
                + "    p.name AS product_name,\n"
                + "    p.description AS product_description,\n"
                + "    pv.stock AS product_stock,\n"
                + "    od.quantity,\n"
                + "    pv.price AS product_price\n"
                + "FROM Orders o\n"
                + "JOIN Users u ON o.user_id = u.user_id\n"
                + "JOIN OrderStatus os ON o.status_id = os.status_id\n"
                + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
                + "JOIN ProductVariants pv ON od.variant_id = pv.variant_id\n"
                + "JOIN Products p ON pv.product_id = p.product_id\n"
                + "WHERE o.order_id = ?;";

        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    byte[] imageBytes = rs.getBytes("image_data");
                    String imageBase64 = null;
                    if (imageBytes != null) {
                        imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                        imageBase64 = "data:image/png;base64," + imageBase64;
                    }

                    String status = (rs.getInt("product_stock") > 0) ? "Còn hàng" : "Hết hàng";

                    orderDetails.add(new OrderDetail(
                            rs.getInt("order_id"),
                            rs.getInt("user_id"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getString("shipping_address"),
                            rs.getString("order_status"),
                            rs.getTimestamp("order_date"),
                            rs.getDouble("total_price"),
                            imageBase64,
                            rs.getString("product_name"),
                            rs.getString("product_description"),
                            status,
                            rs.getInt("quantity"),
                            rs.getDouble("product_price")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public void updateOrderStatus(int orderId, int statusId, int staffId) {
        if (statusId < 1 || statusId > 4) {
            System.out.println("Trạng thái không hợp lệ!");
            return;
        }

        DBContext db = new DBContext();
        Connection conn = db.getConnection();

        // SQL để lấy trạng thái hiện tại của đơn hàng
        String getCurrentStatusSql = "SELECT status_id FROM Orders WHERE order_id = ?";
        // SQL để cập nhật trạng thái trong bảng Orders
        String updateOrderSql = "UPDATE Orders SET status_id = ? WHERE order_id = ?";
        // SQL để ghi lịch sử vào bảng history_Staff_updateStatus
        String insertHistorySql = "INSERT INTO Staff_UpdateOrrder (order_id, status_id, user_id, created_at) VALUES (?, ?, ?, GETDATE())";

        try {
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            // 1. Lấy trạng thái hiện tại của đơn hàng
            Object[] getStatusParams = {orderId};
            ResultSet rs = db.execSelectQuery(getCurrentStatusSql, getStatusParams);
            int currentStatusId = 0;
            if (rs.next()) {
                currentStatusId = rs.getInt("status_id");
            } else {
                throw new SQLException("Không tìm thấy đơn hàng với order_id: " + orderId);
            }
            rs.close();

            // 2. Kiểm tra trạng thái hiện tại để đảm bảo không đảo ngược
            if (currentStatusId >= statusId) {
                throw new SQLException("Không thể đảo ngược trạng thái từ " + currentStatusId + " về " + statusId);
            }
            // Kiểm tra trạng thái cuối (Completed hoặc Canceled)
            if (currentStatusId == 3 || currentStatusId == 4) {
                throw new SQLException("Đơn hàng đã ở trạng thái cuối (Completed hoặc Canceled), không thể cập nhật!");
            }

            // 3. Cập nhật trạng thái trong bảng Orders
            Object[] updateParams = {statusId, orderId};
            int rowsUpdated = db.execQuery(updateOrderSql, updateParams);

            if (rowsUpdated == 0) {
                throw new SQLException("Không tìm thấy đơn hàng với order_id: " + orderId);
            }

            // 4. Ghi lịch sử cập nhật vào bảng history_Staff_updateStatus
            Object[] historyParams = {orderId, statusId, staffId};
            db.execQuery(insertHistorySql, historyParams);

            // Commit transaction
            conn.commit();
            System.out.println("Cập nhật trạng thái đơn hàng thành công và đã ghi lịch sử!");

        } catch (SQLException e) {
            // Rollback nếu có lỗi
            try {
                conn.rollback();
                System.out.println("Đã rollback transaction do lỗi: " + e.getMessage());
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Khôi phục chế độ auto-commit và đóng kết nối
            try {
                conn.setAutoCommit(true);
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public int getTodayOrders() {
        String query = "SELECT COUNT(*) AS today_orders FROM Orders WHERE CAST(created_at AS DATE) = ?"; // Truy vấn cho SQL Server
        int todayOrders = 0;

        try ( Connection conn = new DBContext().getConnection(); // Sử dụng DBContext
                  PreparedStatement ps = conn.prepareStatement(query)) {

            // Lấy ngày hiện tại
            LocalDate today = LocalDate.now();
            ps.setDate(1, Date.valueOf(today)); // Gán ngày hiện tại vào tham số ?

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    todayOrders = rs.getInt("today_orders"); // Lấy giá trị từ cột "today_orders"
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi (có thể thay bằng logging)
        }

        return todayOrders;
    }

    public double getTodayRevenue() {
        String query = "SELECT SUM(total_price) AS today_revenue FROM Orders WHERE CAST(created_at AS DATE) = ? and status_id != 4;"; // Truy vấn sửa lại
        double todayRevenue = 0.0;

        try ( Connection conn = new DBContext().getConnection(); // Sử dụng DBContext
                  PreparedStatement ps = conn.prepareStatement(query)) {

            // Lấy ngày hiện tại
            LocalDate today = LocalDate.now();
            ps.setDate(1, Date.valueOf(today)); // Gán ngày hiện tại vào tham số ?

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    todayRevenue = rs.getDouble("today_revenue"); // Lấy giá trị từ cột "today_revenue"
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi (có thể thay bằng logging)
        }

        return todayRevenue;
    }

    public List<Map<String, Object>> getWeeklyOrders() {
        String query
                = "WITH Days AS ( "
                + "    SELECT CAST(GETDATE() AS DATE) AS day "
                + "    UNION ALL "
                + "    SELECT DATEADD(DAY, -1, day) "
                + "    FROM Days "
                + "    WHERE DATEADD(DAY, -1, day) >= DATEADD(DAY, -6, CAST(GETDATE() AS DATE)) "
                + ") "
                + "SELECT "
                + "    DATENAME(WEEKDAY, d.day) AS day_of_week, "
                + "    ISNULL(COUNT(o.order_id), 0) AS order_count "
                + "FROM "
                + "    Days d "
                + "    LEFT JOIN Orders o ON CAST(o.created_at AS DATE) = d.day "
                + "GROUP BY "
                + "    d.day "
                + "ORDER BY "
                + "    d.day;";

        List<Map<String, Object>> weeklyOrders = new ArrayList<>();

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> orderData = new HashMap<>();
                orderData.put("day_of_week", rs.getString("day_of_week"));
                orderData.put("order_count", rs.getInt("order_count"));
                weeklyOrders.add(orderData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return weeklyOrders;
    }

    public List<Map<String, Object>> getWeeklyRevenue() {
        String query
                = "WITH Days AS ( "
                + "    SELECT CAST(GETDATE() AS DATE) AS day "
                + "    UNION ALL "
                + "    SELECT DATEADD(DAY, -1, day) "
                + "    FROM Days "
                + "    WHERE DATEADD(DAY, -1, day) >= DATEADD(DAY, -6, CAST(GETDATE() AS DATE)) "
                + ") "
                + "SELECT "
                + "    DATENAME(WEEKDAY, d.day) AS day_of_week, "
                + "    ISNULL(SUM(od.quantity * pv.price), 0) AS total_revenue "
                + "FROM "
                + "    Days d "
                + "    LEFT JOIN Orders o ON CAST(o.created_at AS DATE) = d.day AND o.status_id != 4 "
                + "    LEFT JOIN OrderDetails od ON o.order_id = od.order_id "
                + "    LEFT JOIN ProductVariants pv ON od.variant_id = pv.variant_id "
                + "GROUP BY "
                + "    d.day "
                + "ORDER BY "
                + "    d.day;";

        List<Map<String, Object>> weeklyRevenue = new ArrayList<>();

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> revenueData = new HashMap<>();
                revenueData.put("day_of_week", rs.getString("day_of_week"));
                revenueData.put("total_revenue", rs.getDouble("total_revenue"));
                weeklyRevenue.add(revenueData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return weeklyRevenue;
    }

}
