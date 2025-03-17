package DAOAdmin;

import DB.DBContext;
import modelAdmin.Monitor;
import java.sql.*;

public class MonitorDAO {
    public int addProduct(String productName, String description, byte[] imageData) throws SQLException {
        String query = "INSERT INTO Products (name, description, image_data, catalog_id) OUTPUT INSERTED.product_id VALUES (?, ?, ?, 2)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, productName);
            stmt.setString(2, description);
            stmt.setBytes(3, imageData);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }
       public void addVariant(int productId, double price, int stock) throws SQLException {
    String query = "INSERT INTO ProductVariants (product_id, price, stock, ram) VALUES (?, ?, ?, NULL)";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setInt(1, productId);
        stmt.setDouble(2, price);
        stmt.setInt(3, stock);
        stmt.executeUpdate();
    }
}

    public void addMonitor(Monitor monitor) throws SQLException {
        String query = "INSERT INTO Monitors (product_id, model, size, panel_type, resolution, bit_depth, color_gamut, brightness, refresh_rate, hdr, ports, audio_out, function_keys, weight, dimensions, color) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, monitor.getProductId());
            stmt.setString(2, monitor.getModel());
            stmt.setFloat(3, monitor.getSize());
            stmt.setString(4, monitor.getPanelType());
            stmt.setString(5, monitor.getResolution());
            stmt.setString(6, monitor.getBitDepth());
            stmt.setString(7, monitor.getColorGamut());
            stmt.setInt(8, monitor.getBrightness());
            stmt.setInt(9, monitor.getRefreshRate());
            stmt.setString(10, monitor.getHdr());
            stmt.setString(11, monitor.getPorts());
            stmt.setBoolean(12, monitor.isAudioOut());
            stmt.setString(13, monitor.getFunctionKeys());
            stmt.setFloat(14, monitor.getWeight());
            stmt.setString(15, monitor.getDimensions());
            stmt.setString(16, monitor.getColor());
            stmt.executeUpdate();
        }
    }
    public Monitor getMonitorByProductId(int productId) {
        String query = "SELECT * FROM Monitors WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Monitor(
                    rs.getInt("monitor_id"),
                    rs.getInt("product_id"),
                    rs.getString("model"),
                    rs.getFloat("size"),
                    rs.getString("panel_type"),
                    rs.getString("resolution"),
                    rs.getString("bit_depth"),
                    rs.getString("color_gamut"),
                    rs.getInt("brightness"),
                    rs.getInt("refresh_rate"),
                    rs.getString("hdr"),
                    rs.getString("ports"),
                    rs.getBoolean("audio_out"),
                    rs.getString("function_keys"),
                    rs.getFloat("weight"), // Chuyển decimal thành float
                    rs.getString("dimensions"),
                    rs.getString("color"),
                    null, // productName không có trong bảng
                    null, // description không có trong bảng
                    null  // image không có trong bảng
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateMonitor(Monitor monitor) {
        String query = "UPDATE Monitors SET model=?, size=?, panel_type=?, resolution=?, bit_depth=?, color_gamut=?, " +
                       "brightness=?, refresh_rate=?, hdr=?, ports=?, audio_out=?, function_keys=?, weight=?, " +
                       "dimensions=?, color=? WHERE product_id=?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, monitor.getModel());
            stmt.setFloat(2, monitor.getSize());
            stmt.setString(3, monitor.getPanelType());
            stmt.setString(4, monitor.getResolution());
            stmt.setString(5, monitor.getBitDepth());
            stmt.setString(6, monitor.getColorGamut());
            stmt.setInt(7, monitor.getBrightness());
            stmt.setInt(8, monitor.getRefreshRate());
            stmt.setString(9, monitor.getHdr());
            stmt.setString(10, monitor.getPorts());
            stmt.setBoolean(11, monitor.isAudioOut());
            stmt.setString(12, monitor.getFunctionKeys());
            stmt.setFloat(13, monitor.getWeight());
            stmt.setString(14, monitor.getDimensions());
            stmt.setString(15, monitor.getColor());
            stmt.setInt(16, monitor.getProductId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
