// DAO/ProductVariantDAO.java
package DAOAdmin;

import DB.DBContext;
import modelAdmin.ProductVariant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAOLT {
    public String addVariantLaptop(ProductVariant variant) {
        String sql = "INSERT INTO ProductVariants (product_id, price, stock, ram) VALUES (?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection()) {
            if (conn == null) {
                return "Failed to connect to database";
            }
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, variant.getProductId());
                ps.setDouble(2, variant.getPrice());
                ps.setInt(3, variant.getStock());
                ps.setString(4, variant.getRam());
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Rows affected: " + rowsAffected + " for RAM " + variant.getRam());
                    return null; // Thành công, không có lỗi
                } else {
                    return "No rows affected for RAM " + variant.getRam();
                }
            }
        } catch (SQLException e) {
            String error = "Database error: " + e.getMessage();
            System.err.println(error);
            e.printStackTrace();
            return error;
        }
    }

    
}