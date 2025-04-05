package DAOAdmin;

import DB.DBContext;
import modelAdmin.ProductVariant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAO {

    // SQL queries
    private static final String SELECT_ALL_VARIANTS = "SELECT * FROM ProductVariants";

    public boolean addProductVariant(ProductVariant variant) {
        String sql = "INSERT INTO ProductVariants (product_id, price, stock, ram) VALUES (?, ?, ?, ?)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, variant.getProductId());
            ps.setDouble(2, variant.getPrice());
            ps.setInt(3, variant.getStock());
            ps.setString(4, variant.getRam()); // Thêm RAM
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ProductVariant getVariantByProductId(int productId) {
        String query = "SELECT * FROM ProductVariants WHERE product_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new ProductVariant(
                        rs.getInt("product_id"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getString("ram")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateVariant(ProductVariant variant) {
        String query = "UPDATE ProductVariants SET price=?, stock=?, ram=? WHERE product_id=?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, variant.getPrice());
            stmt.setInt(2, variant.getStock());
            stmt.setString(3, variant.getRam());
            stmt.setInt(4, variant.getProductId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ProductVariant> getAllVariants() {
        List<ProductVariant> variants = new ArrayList<>();
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement preparedStatement = conn.prepareStatement(SELECT_ALL_VARIANTS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int variantId = rs.getInt("variant_id");
                int productId = rs.getInt("product_id");
                double price = rs.getDouble("price");
                int stock = rs.getInt("stock");
                String ram = rs.getString("ram");
                variants.add(new ProductVariant(productId, price, stock, ram));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> variants = new ArrayList<>();
        String query = "SELECT * FROM ProductVariants WHERE product_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                variants.add(new ProductVariant(
                        rs.getInt("product_id"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getString("ram")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

}
