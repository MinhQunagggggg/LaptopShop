package DAO;

import DB.DBContext;
import Model_Staff.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class OrderDAO {

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> order = new ArrayList<>();
        String query = "SELECT v.variant_id, o.status_id, o.order_id, p.name AS product_name, p.image_data, v.ram, "
                + "od.price, od.quantity, o.total_price, o.created_at "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN ProductVariants v ON od.variant_id = v.variant_id "
                + "JOIN Products p ON v.product_id = p.product_id "
                + "WHERE o.user_id = ? "
                + "ORDER BY o.created_at DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                order.add(new Order(
                        rs.getInt("variant_id"),
                        rs.getInt("status_id"),
                        rs.getInt("order_id"),
                        rs.getString("product_name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getDouble("total_price"),
                        rs.getTimestamp("created_at"),
                        rs.getString("ram")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public boolean cancelOrder(int orderId) {
        String query = "UPDATE Orders SET status_id = 4 WHERE order_id = ? AND status_id = 1";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("✅ Đơn hàng " + orderId + " đã được hủy thành công.");
                return true;
            } else {
                System.out.println("⚠ Không thể hủy đơn hàng " + orderId + ". Có thể đơn hàng không tồn tại hoặc không ở trạng thái chờ duyệt.");
            }

        } catch (SQLException e) {
            System.out.println("❌ Lỗi SQL khi hủy đơn hàng: " + e.getMessage());
        }
        return false;
    }

    public List<Order> getOrdersByUserIdAndStatus(int userId, int statusId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT v.variant_id, o.status_id, o.order_id, p.name AS product_name, p.image_data, v.ram, "
                + "od.price, od.quantity, o.total_price, o.created_at "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN ProductVariants v ON od.variant_id = v.variant_id "
                + "JOIN Products p ON v.product_id = p.product_id "
                + "WHERE o.user_id = ? AND o.status_id = ? "
                + "ORDER BY o.created_at DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, statusId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("variant_id"),
                        rs.getInt("status_id"),
                        rs.getInt("order_id"),
                        rs.getString("product_name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getDouble("total_price"),
                        rs.getTimestamp("created_at"),
                        rs.getString("ram")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrderDetailsByOrderId(int orderId) {  
        List<Order> orders = new ArrayList<>();
        String query = "SELECT pv.variant_id, o.status_id, od.order_id, o.user_id, \n" +
"                p.name AS product_name, p.image_data, od.price, od.quantity , pv.product_id , \n" +
"                o.total_price, p.description, o.created_at , pv.ram , u.name , u.phone,u.shipping_address\n" +
"                FROM OrderDetails od \n" +
"                JOIN Orders o ON o.order_id = od.order_id \n" +
"		 JOIN Users u ON u.user_id = o.user_id\n" +
"                LEFT JOIN ProductVariants pv ON pv.variant_id = od.variant_id \n" +
"                JOIN Products p ON p.product_id = pv.product_id \n" +
"                WHERE od.order_id =  ?\n" +
"                ORDER BY o.created_at DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order orderDetails = new Order(
                        rs.getInt("variant_id"),
                        rs.getInt("status_id"), 
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("product_name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getInt("product_id"),
                        rs.getDouble("total_price"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getString("ram"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("shipping_address")
                );
                orders.add(orderDetails);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int createOrder(int userId, double totalPrice, String paymentMethod) {
        String query = "INSERT INTO Orders (user_id, total_price, status_id, created_at, payment_method, payment_status) "
                + "VALUES (?, ?, ?, GETDATE(), ?, ?)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            ps.setBigDecimal(2, new java.math.BigDecimal(totalPrice));
            ps.setInt(3, 1); // Pending
            ps.setString(4, paymentMethod);
            ps.setInt(5, 0); // Chưa thanh toán

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("❌ Không có dòng nào được chèn vào bảng Orders!");
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    System.out.println("✅ Đã tạo đơn hàng: " + orderId);
                    return orderId;
                } else {
                    throw new SQLException("❌ Không thể lấy ID đơn hàng!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public void addOrderDetail(int orderId, int variantId, int quantity, double price) {
        String query = "INSERT INTO OrderDetails (order_id, variant_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ps.setInt(2, variantId);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                System.out.println("✅ Đã thêm vào OrderDetails: OrderID = " + orderId + ", VariantID = " + variantId);
            } else {
                System.out.println("❌ Lỗi: Không thêm được sản phẩm vào OrderDetails!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Order> getOrderItemsByOrderId(int orderId) {
        List<Order> orderItems = new ArrayList<>();
        String sql = "SELECT pv.variant_id , pv.ram , od.quantity , pv.price , pv.product_id "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON od.order_id = o.order_id "
                + "JOIN ProductVariants pv ON pv.variant_id = od.variant_id "
                + "WHERE o.order_id = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("variant_id"),
                        rs.getString("ram"),
                        rs.getInt("product_id"),
                        rs.getDouble("price"),
                        rs.getInt("quantity")
                );

                orderItems.add(order);
            }
        } catch (SQLException e) {
            System.out.println("❌ Error fetching order items: " + e.getMessage());
            e.printStackTrace();
        }

        return orderItems;
    }
}
