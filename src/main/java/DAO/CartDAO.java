
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
import model.ProductVariant;

/**
 *
 * @author CE182250
 */
public class CartDAO {

    public void updateCart(int userId, int variantId, int newQuantity) {
        String query = "UPDATE Cart SET quantity = ? WHERE user_id = ? AND variant_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, userId);
            ps.setInt(3, variantId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getStockForVariant(int variantId) {
        String query = "SELECT stock FROM ProductVariants WHERE variant_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("stock");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // 🔥 Nếu lỗi, trả về 0 để không cho phép đặt hàng
    }
    public String getProductNameByVariantId(int variantId) {
    String query = "SELECT p.name FROM Products p JOIN ProductVariants v ON p.product_id = v.product_id WHERE v.variant_id = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, variantId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getString("name"); // ✅ Lấy tên sản phẩm
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return "Sản phẩm"; // 🔥 Nếu lỗi, trả về tên mặc định
}

public void updateStockAfterPurchase(int variantId, int quantityPurchased) {
    String query = "UPDATE ProductVariants SET stock = stock - ? WHERE variant_id = ? AND stock >= ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, quantityPurchased);
        ps.setInt(2, variantId);
        ps.setInt(3, quantityPurchased); // ✅ Chỉ trừ nếu đủ hàng tồn kho
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("✅ Đã trừ số lượng sản phẩm VariantID: " + variantId + " | Số lượng đã mua: " + quantityPurchased);
        } else {
            System.out.println("❌ Không thể cập nhật tồn kho cho VariantID: " + variantId);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    public ProductVariant getVariantById(int variantId) {
        String query = "SELECT variant_id, ram, price FROM ProductVariants WHERE variant_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ProductVariant(
                        rs.getInt("variant_id"),
                        rs.getString("ram"),
                        rs.getDouble("price")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<CartItem> getCartItems(int userId) {
    List<CartItem> cartItems = new ArrayList<>();
    String query = "SELECT c.variant_id, v.product_id, p.name AS product_name, p.image_data, "
                 + "c.price, c.quantity, (c.price * c.quantity) AS total_price, c.ram, v.stock " 
                 + "FROM Cart c "
                 + "JOIN ProductVariants v ON c.variant_id = v.variant_id "
                 + "JOIN Products p ON v.product_id = p.product_id "
                 + "WHERE c.user_id = ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            cartItems.add(new CartItem(
                    rs.getInt("variant_id"),
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getBytes("image_data"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getDouble("total_price"),
                    rs.getString("ram"),
                    rs.getInt("stock") // ✅ Lấy stock
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return cartItems;
}


    public void addToCart(int userId, int variantId, String ram, double price, int quantity) {
        String getProductQuery = "SELECT product_id FROM ProductVariants WHERE variant_id = ?";
        String checkQuery = "SELECT quantity FROM Cart WHERE user_id = ? AND variant_id = ?";
        String updateQuery = "UPDATE Cart SET quantity = quantity + ? WHERE user_id = ? AND variant_id = ?";
        String insertQuery = "INSERT INTO Cart (user_id, variant_id, product_id, ram, price, quantity) VALUES (?, ?, ?, ?, ?, ?)";

        int productId = -1;

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement getProductPs = conn.prepareStatement(getProductQuery)) {
            getProductPs.setInt(1, variantId);
            ResultSet rs = getProductPs.executeQuery();
            if (rs.next()) {
                productId = rs.getInt("product_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (productId == -1) {
            System.out.println("❌ Lỗi: Không tìm thấy product_id cho variantId: " + variantId);
            return;
        }

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement checkPs = conn.prepareStatement(checkQuery)) {
            checkPs.setInt(1, userId);
            checkPs.setInt(2, variantId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // ✅ Nếu sản phẩm đã có trong giỏ hàng, cập nhật số lượng
                try ( PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                    updatePs.setInt(1, quantity);
                    updatePs.setInt(2, userId);
                    updatePs.setInt(3, variantId);
                    updatePs.executeUpdate();
                }
            } else {
                // ✅ Nếu sản phẩm chưa có trong giỏ hàng, thêm mới
                try ( PreparedStatement insertPs = conn.prepareStatement(insertQuery)) {
                    insertPs.setInt(1, userId);
                    insertPs.setInt(2, variantId);
                    insertPs.setInt(3, productId);
                    insertPs.setString(4, ram);
                    insertPs.setDouble(5, price);
                    insertPs.setInt(6, quantity);
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
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Tổng số lượng sản phẩm
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void removeFromCart(int userId, int variantId) {
        String query = "DELETE FROM Cart WHERE user_id = ? AND variant_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, variantId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCartAfterCheckout(int userId, List<CartItem> purchasedItems) {
        String checkQuery = "SELECT quantity FROM Cart WHERE user_id = ? AND variant_id = ?";
        String updateQuery = "UPDATE Cart SET quantity = quantity - ? WHERE user_id = ? AND variant_id = ?";
        String deleteQuery = "DELETE FROM Cart WHERE user_id = ? AND variant_id = ?";

        try ( Connection conn = new DBContext().getConnection()) {
            for (CartItem item : purchasedItems) {
                try ( PreparedStatement checkPs = conn.prepareStatement(checkQuery)) {
                    checkPs.setInt(1, userId);
                    checkPs.setInt(2, item.getVariantId());
                    ResultSet rs = checkPs.executeQuery();

                    if (rs.next()) {
                        int currentQuantity = rs.getInt("quantity");

                        if (item.getQuantity() >= currentQuantity) {
                            try ( PreparedStatement deletePs = conn.prepareStatement(deleteQuery)) {
                                deletePs.setInt(1, userId);
                                deletePs.setInt(2, item.getVariantId());
                                deletePs.executeUpdate();
                                System.out.println("🗑 Xóa sản phẩm VariantID " + item.getVariantId() + " khỏi giỏ hàng");
                            }
                        } else {
                            try ( PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                                updatePs.setInt(1, item.getQuantity());
                                updatePs.setInt(2, userId);
                                updatePs.setInt(3, item.getVariantId());
                                updatePs.executeUpdate();
                                System.out.println("🔄 Cập nhật số lượng sản phẩm VariantID " + item.getVariantId()
                                        + " còn lại trong giỏ hàng: " + (currentQuantity - item.getQuantity()));
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
