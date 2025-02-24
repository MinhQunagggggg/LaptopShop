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
import java.util.ArrayList;
import java.util.List;
import model.CartItem;

/**
 *
 * @author CE182250
 */
public class CartDAO {

    // ✅ Lấy danh sách sản phẩm trong giỏ hàng
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT c.variant_id, p.name AS product_name, p.image_data, " +
                       "v.price, c.quantity, (v.price * c.quantity) AS total_price " +
                       "FROM Cart c " +
                       "JOIN ProductVariants v ON c.variant_id = v.variant_id " +
                       "JOIN Products p ON v.product_id = p.product_id " +
                       "WHERE c.user_id = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                cartItems.add(new CartItem(
                    rs.getInt("variant_id"),
                    rs.getString("product_name"),
                    rs.getBytes("image_data"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getDouble("total_price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }
public CartItem getCartItem(int userId, int variantId) {
    String query = "SELECT c.variant_id, p.name AS product_name, p.image_data, " +
                   "v.price, c.quantity, (v.price * c.quantity) AS total_price " +
                   "FROM Cart c " +
                   "JOIN ProductVariants v ON c.variant_id = v.variant_id " +
                   "JOIN Products p ON v.product_id = p.product_id " +
                   "WHERE c.user_id = ? AND c.variant_id = ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, userId);
        ps.setInt(2, variantId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new CartItem(
                rs.getInt("variant_id"),
                rs.getString("product_name"),
                rs.getBytes("image_data"),
                rs.getDouble("price"),
                rs.getInt("quantity"),
                rs.getDouble("total_price")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null; // Nếu không tìm thấy sản phẩm trong giỏ hàng
}

    // ✅ Thêm sản phẩm vào giỏ hàng (nếu có thì cập nhật số lượng)
    public void addToCart(int userId, int variantId, int quantity) {
        String checkQuery = "SELECT quantity FROM Cart WHERE user_id = ? AND variant_id = ?";
        String updateQuery = "UPDATE Cart SET quantity = quantity + ? WHERE user_id = ? AND variant_id = ?";
        String insertQuery = "INSERT INTO Cart (user_id, variant_id, quantity) VALUES (?, ?, ?)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement checkPs = conn.prepareStatement(checkQuery)) {
            checkPs.setInt(1, userId);
            checkPs.setInt(2, variantId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                try (PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                    updatePs.setInt(1, quantity);
                    updatePs.setInt(2, userId);
                    updatePs.setInt(3, variantId);
                    updatePs.executeUpdate();
                }
            } else {
                try (PreparedStatement insertPs = conn.prepareStatement(insertQuery)) {
                    insertPs.setInt(1, userId);
                    insertPs.setInt(2, variantId);
                    insertPs.setInt(3, quantity);
                    insertPs.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Lấy tổng số lượng sản phẩm trong giỏ hàng
    public int getCartSize(int userId) {
        String query = "SELECT SUM(quantity) FROM Cart WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về tổng số lượng sản phẩm
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Nếu giỏ hàng rỗng
    }

    // ✅ Cập nhật số lượng sản phẩm trong giỏ hàng
    public void updateCart(int userId, int variantId, int quantity) {
        String query = "UPDATE Cart SET quantity = ? WHERE user_id = ? AND variant_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, variantId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Xóa một sản phẩm khỏi giỏ hàng
    // ✅ Xóa một sản phẩm khỏi giỏ hàng
public void removeFromCart(int userId, int variantId) {
    String query = "DELETE FROM Cart WHERE user_id = ? AND variant_id = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, userId);
        ps.setInt(2, variantId);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    // ✅ Xóa toàn bộ giỏ hàng sau khi thanh toán
    public void clearCart(int userId) {
        String query = "DELETE FROM Cart WHERE user_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
