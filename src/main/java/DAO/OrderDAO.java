/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import model.Order;
import model.OrderDetail;

/**
 *
 * @author CE182250
 */
public class OrderDAO {
    




public Order getOrderById(int orderId) {
    String query = "SELECT o.order_id, o.created_at, o.total_price, s.status_name " +
                   "FROM Orders o " +
                   "JOIN OrderStatus s ON o.status_id = s.status_id " +
                   "WHERE o.order_id = ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new Order(
                rs.getInt("order_id"),
                rs.getTimestamp("created_at"),
                rs.getDouble("total_price"),
                rs.getString("status_name") // ✅ Lấy tên trạng thái từ OrderStatus
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
public void insertOrderDetails(List<OrderDetail> orderDetails) {
    String query = "INSERT INTO OrderDetails (order_id, variant_id, quantity, price) VALUES (?, ?, ?, ?)";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        for (OrderDetail detail : orderDetails) {
            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getVariantId());
            ps.setInt(3, detail.getQuantity());
            ps.setDouble(4, detail.getPrice());
            ps.executeUpdate();
            System.out.println("✅ Lưu OrderDetails: " + detail.getVariantId());
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

public int createOrder(int userId, String customerName, String shippingAddress, String phone, double totalPrice, String paymentMethod) {
    String query = "INSERT INTO Orders (user_id, customer_name, total_price, status_id, created_at, payment_method, shipping_address, phone, payment_status) "
                 + "VALUES (?, ?, ?, ?, GETDATE(), ?, ?, ?, ?)";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

        ps.setInt(1, userId);
        ps.setString(2, customerName);
        ps.setBigDecimal(3, new java.math.BigDecimal(totalPrice));  // 🔥 Dùng BigDecimal thay vì double
        ps.setInt(4, 1); // 1 = Pending Confirmation
        ps.setString(5, paymentMethod);
        ps.setString(6, shippingAddress);
        ps.setString(7, phone);
        ps.setInt(8, 0); // 0 = Chưa thanh toán

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



public void updateOrderStatus(int orderId, int statusId) {
    String query = "UPDATE Orders SET status_id = ? WHERE order_id = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, statusId);
        ps.setInt(2, orderId);
        ps.executeUpdate();
        System.out.println("✅ Cập nhật trạng thái đơn hàng thành công: Order ID = " + orderId + ", Status ID = " + statusId);
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


}