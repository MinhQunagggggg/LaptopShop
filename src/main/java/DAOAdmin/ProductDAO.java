/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOAdmin;

import DAO.*;
import DB.DBContext;
import model.Product;
import modelAdmin.ProductAdmin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import modelAdmin.ProductSpecification;
import modelAdmin.ProductVariant;

/**
 *
 * @author CE182250
 */
public class ProductDAO {

    

    public int addProductMNgoc(ProductAdmin product) {
        String sql = "INSERT INTO Products (name, description, category_id, brand_id, subbrand_id, catalog_id, image_data) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int productId = -1;

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setInt(3, product.getCategoryId());
            ps.setInt(4, product.getBrandId());
            ps.setInt(5, product.getSubBrandId());
            ps.setInt(6, product.getCatalogId());
            ps.setBytes(7, product.getImageData());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try ( ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        productId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productId;
    }

    public List<ProductAdmin> getAllProductsMNgoc() {
        List<ProductAdmin> productList = new ArrayList<>();
        String sql = "SELECT product_id, name, description, category_id, brand_id, subbrand_id, catalog_id, accessory_brand_id, image_data FROM Products WHERE is_deleted = 0 OR is_deleted IS NULL";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductAdmin product = new ProductAdmin(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getInt("category_id"),
                        rs.getInt("brand_id"),
                        rs.getInt("subbrand_id"),
                        rs.getInt("catalog_id"),
                        rs.getBytes("image_data")
                );
                productList.add(product);
            }

            // 👉 In số lượng sản phẩm lấy được ra console
            System.out.println("🔎 Tổng số sản phẩm lấy được từ DB: " + productList.size());

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public ProductAdmin getProductById(int productId) {
        String sql = "SELECT * FROM Products WHERE product_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ProductAdmin(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getInt("category_id"),
                        rs.getInt("brand_id"),
                        rs.getInt("subbrand_id"),
                        rs.getInt("catalog_id"),
                        rs.getBytes("image_data")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProduct(ProductAdmin product) {
        String sql = "UPDATE Products SET name = ?, description = ?, category_id = ?, brand_id = ?, subbrand_id = ?, catalog_id = ?, image_data = ? WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setInt(3, product.getCategoryId());
            ps.setInt(4, product.getBrandId());
            ps.setInt(5, product.getSubBrandId());
            ps.setInt(6, product.getCatalogId());
            ps.setBytes(7, product.getImageData());
            ps.setInt(8, product.getProductId());

            return ps.executeUpdate() > 0; // Trả về `true` nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProductMNgoc(int productId) {
        String sql = "DELETE FROM Products WHERE product_id = ?";
        try ( Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static ProductSpecification getSpecificationById(String productId) {
        ProductSpecification spec = null;
        String query = "SELECT * FROM product_specifications WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                spec = new ProductSpecification(
                        rs.getInt("product_id"),
                        rs.getString("cpu"),
                        rs.getString("ram"),
                        rs.getString("storage"),
                        rs.getString("resolution"),
                        rs.getString("graphics"),
                        rs.getString("ports"),
                        rs.getString("wireless"),
                        rs.getString("camera"),
                        rs.getString("battery"),
                        rs.getString("dimensions"),
                        rs.getString("weight"),
                        rs.getString("keyboard"),
                        rs.getString("material"),
                        rs.getString("warranty"),
                        rs.getString("os"),
                        rs.getString("condition"),
                        rs.getString("refresh_rate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return spec;
    }

    public static ProductVariant getVariantById(String productId) {
        ProductVariant variant = null;
        String query = "SELECT * FROM product_variants WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                variant = new ProductVariant(
                        rs.getInt("productId"),
                        rs.getInt("price"),
                        rs.getInt("stock")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return variant;
    }
}
