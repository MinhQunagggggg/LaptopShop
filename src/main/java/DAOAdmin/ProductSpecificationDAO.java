package DAOAdmin;

import DB.DBContext;
import modelAdmin.ProductSpecification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductSpecificationDAO {

    public boolean addProductSpecification(ProductSpecification spec) {
        String sql = "INSERT INTO ProductSpecifications (product_id, cpu, storage, resolution, graphics, ports, "
                + "wireless, camera, battery, dimensions, weight, keyboard, material, warranty, os, condition, "
                + "Refresh_rate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, spec.getProductId());
            ps.setString(2, spec.getCpu());
            ps.setString(3, spec.getStorage());
            ps.setString(4, spec.getResolution());
            ps.setString(5, spec.getGraphics());
            ps.setString(6, spec.getPorts());
            ps.setString(7, spec.getWireless());
            ps.setString(8, spec.getCamera());
            ps.setString(9, spec.getBattery());
            ps.setString(10, spec.getDimensions());
            ps.setString(11, spec.getWeight());
            ps.setString(12, spec.getKeyboard());
            ps.setString(13, spec.getMaterial());
            ps.setString(14, spec.getWarranty());
            ps.setString(15, spec.getOs());
            ps.setString(16, spec.getCondition());
            ps.setString(17, spec.getRefreshRate());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ProductSpecification getSpecificationByProductId(int productId) {
        String query = "SELECT * FROM ProductSpecifications WHERE product_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new ProductSpecification(
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSpecification(ProductSpecification spec) {
        String query = "UPDATE ProductSpecifications SET cpu=?, storage=?, resolution=?, graphics=?, "
                + "ports=?, wireless=?, camera=?, battery=?, dimensions=?, weight=?, keyboard=?, material=?, "
                + "warranty=?, os=?, condition=?, refresh_rate=? WHERE product_id=?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, spec.getCpu());
            stmt.setString(2, spec.getStorage());
            stmt.setString(3, spec.getResolution());
            stmt.setString(4, spec.getGraphics());
            stmt.setString(5, spec.getPorts());
            stmt.setString(6, spec.getWireless());
            stmt.setString(7, spec.getCamera());
            stmt.setString(8, spec.getBattery());
            stmt.setString(9, spec.getDimensions());
            stmt.setString(10, spec.getWeight());
            stmt.setString(11, spec.getKeyboard());
            stmt.setString(12, spec.getMaterial());
            stmt.setString(13, spec.getWarranty());
            stmt.setString(14, spec.getOs());
            stmt.setString(15, spec.getCondition());
            stmt.setString(16, spec.getRefreshRate());
            stmt.setInt(17, spec.getProductId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
