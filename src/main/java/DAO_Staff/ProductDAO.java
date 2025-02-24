/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO_Staff;

import DB.DBContext;
import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author CE182250
 */
public class ProductDAO {

    public Product getProductInfo(int productId) {
        String query = "SELECT p.product_id, p.name AS product_name, p.image_data, p.description, "
                + "v.price, b.name AS brand_name, c.name AS category_name, p.catalog_id "
                + "FROM Products p "
                + "LEFT JOIN ProductVariants v ON p.product_id = v.product_id "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id "
                + "WHERE p.product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("product_id"),
                            rs.getString("product_name"),
                            rs.getBytes("image_data"), // ✅ Đọc dữ liệu ảnh dạng `byte[]`
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("brand_name"),
                            rs.getString("category_name"),
                            rs.getInt("catalog_id")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }
    
    // ✅ Lấy tất cả sản phẩm từ database
    public List<Product> getAllProducts2() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.product_id, p.name, p.description, "
                     + "COALESCE(v.price, 0) AS price, p.image_data "  // Xử lý NULL giá trị price
                     + "FROM products p "
                     + "LEFT JOIN ProductVariants v ON p.product_id = v.product_id";  // Dùng LEFT JOIN để tránh mất dữ liệu

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // ✅ Lấy dữ liệu ảnh dưới dạng byte[]
                byte[] imageBytes = rs.getBytes("image_data");
                String imageBase64 = null;

                // ✅ Chuyển đổi sang Base64 nếu ảnh không null
                if (imageBytes != null) {
                    imageBase64 = "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes);
                }

                // ✅ Thêm sản phẩm vào danh sách
                list.add(new Product(
                    rs.getInt("product_id"),
                    rs.getString("name"),
                    imageBytes,  // ✅ Lưu trữ dưới dạng `byte[]` để tương thích với model Product
                    rs.getString("description"),
                    rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

