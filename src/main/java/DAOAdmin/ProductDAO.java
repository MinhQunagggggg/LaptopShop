/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOAdmin;

import DAO.*;
import DB.DBContext;

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

import modelAdmin.ProductStat;

import modelAdmin.ProductVariant;

/**
 *
 * @author CE182250
 */
public class ProductDAO {

    public int addProductMNgoc(ProductAdmin product) {
        String sql = "INSERT INTO Products (name, description, category_id, brand_id, subbrand_id, catalog_id, image_data) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = new DBContext().getConnection(); // Hàm lấy kết nối DB của bạn
                  PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setInt(3, product.getCategoryId());
            ps.setInt(4, product.getBrandId());
            if (product.getSubBrandId() != 0) {
                ps.setInt(5, product.getSubBrandId()); // Nếu subBrandId khác 0, lưu giá trị thật
            } else {
                ps.setNull(5, java.sql.Types.INTEGER); // Nếu subBrandId là 0, lưu NULL
            }
            ps.setInt(6, product.getCatalogId());
            ps.setBytes(7, product.getImageData());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                return -1;
            }
            try ( ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về product_id vừa thêm
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
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

        String sql = "UPDATE Products SET is_deleted = 1 WHERE product_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
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
                        rs.getInt("product_id"), // Sửa tên cột
                        rs.getDouble("price"), // Sửa kiểu dữ liệu từ getInt thành getDouble
                        rs.getInt("stock"),
                        rs.getString("ram") // Thêm dấu phẩy ở đây

                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return variant;
    }

    public List<ProductStat> getProductStats(Integer year, Integer month) {
        List<ProductStat> stats = new ArrayList<>();
        String sql = "SELECT MONTH(o.created_at) AS month, YEAR(o.created_at) AS year, 'Product' AS productName, SUM(od.quantity) AS totalQuantity "
                + "FROM [dbo].[Orders] o JOIN [dbo].[OrderDetails] od ON o.order_id = od.order_id "
                + "WHERE o.created_at IS NOT NULL "
                + (year != null ? "AND YEAR(o.created_at) = ? " : "")
                + (month != null ? "AND MONTH(o.created_at) = ? " : "")
                + "GROUP BY MONTH(o.created_at), YEAR(o.created_at) ORDER BY year, month";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (year != null) {
                stmt.setInt(paramIndex++, year);
            }
            if (month != null) {
                stmt.setInt(paramIndex++, month);
            }

            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    stats.add(new ProductStat(rs.getInt("month"), rs.getInt("year"), rs.getString("productName"), rs.getInt("totalQuantity")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

}
