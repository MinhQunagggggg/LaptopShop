package DAOAdmin;

import DB.DBContext;
import modelAdmin.ProductVariant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductVariantDAO {
    public boolean addProductVariant(ProductVariant variant) {
        String sql = "INSERT INTO ProductVariants (product_id, price, stock) VALUES (?, ?, ?)";
        try ( Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, variant.getProductId());
            ps.setDouble(2, variant.getPrice());
            ps.setInt(3, variant.getStock());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public ProductVariant getVariantByProductId(int productId) {
        String query = "SELECT * FROM ProductVariants WHERE product_id = ?";
        try ( Connection conn = new DBContext().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new ProductVariant(
                    rs.getInt("product_id"),
                    rs.getDouble("price"),
                    rs.getInt("stock")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateVariant(ProductVariant variant) {
        String query = "UPDATE ProductVariants SET price=?, stock=? WHERE product_id=?";
      try ( Connection conn = new DBContext().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, variant.getPrice());
            stmt.setInt(2, variant.getStock());
            stmt.setInt(3, variant.getProductId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
