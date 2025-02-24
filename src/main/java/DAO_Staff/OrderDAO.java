package DAO_Staff;

import DB.DBContext;
import Model_Staff.Order;
import Model_Staff.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class OrderDAO {

    private Connection conn;

    public OrderDAO() {
        this.conn = new DBContext().getConnection();
    }

public List<Order> getAllOrders() {
    List<Order> orders = new ArrayList<>();
    String sql = "SELECT o.order_id, u.user_id, u.name, u.phone, os.status_name, o.created_at, " +
                 "(SELECT SUM(od.quantity * pv.price) " +
                 " FROM OrderDetails od " +
                 " JOIN ProductVariants pv ON od.variant_id = pv.variant_id " +
                 " WHERE od.order_id = o.order_id) AS total_price " +
                 "FROM Orders o " +
                 "JOIN Users u ON o.user_id = u.user_id " +
                 "JOIN OrderStatus os ON o.status_id = os.status_id";

    try (PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
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
    String sql = "SELECT p.image_data, p.name, p.description, pv.stock, od.quantity, pv.price " +
                 "FROM OrderDetails od " +
                 "JOIN ProductVariants pv ON od.variant_id = pv.variant_id " +
                 "JOIN Products p ON pv.product_id = p.product_id " +
                 "WHERE od.order_id = ?";

    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, orderId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                // ✅ Đọc dữ liệu ảnh đúng kiểu byte[]
                byte[] imageBytes = rs.getBytes("image_data");
                String imageBase64 = null;
                
                // ✅ Chuyển đổi sang Base64 nếu ảnh không null
                if (imageBytes != null) {
                    imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                    imageBase64 = "data:image/png;base64," + imageBase64;  // Thêm prefix cho đúng định dạng ảnh
                }

                // ✅ Xác định trạng thái sản phẩm
                String status = (rs.getInt("stock") > 0) ? "Còn hàng" : "Hết hàng";

                // ✅ Thêm dữ liệu vào danh sách
                orderDetails.add(new OrderDetail(
                    imageBase64,  // ✅ Thay vì image_data dạng byte[], dùng Base64
                    rs.getString("name"),
                    rs.getString("description"),
                    status,
                    rs.getInt("quantity"),
                    rs.getDouble("price")
                ));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return orderDetails;
}



    public void updateOrderStatus(int orderId, int statusId) {
        if (statusId < 1 || statusId > 3) {
            System.out.println("Trạng thái không hợp lệ!");
            return;
        }

        String sql = "UPDATE Orders SET status_id = ? WHERE order_id = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, statusId);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
