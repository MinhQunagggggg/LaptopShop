package DAOAdmin;

import DB.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import modelAdmin.Monitor;

public class MonitorDAO {
    public boolean addMonitor(Monitor monitor) {
        String sql = "INSERT INTO Monitors (product_id, model, size, panel_type, resolution, bit_depth, color_gamut, " +
                     "brightness, refresh_rate, hdr, ports, audio_out, function_keys, weight, dimensions, color) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, monitor.getProductId());
            ps.setString(2, monitor.getModel());
            ps.setDouble(3, monitor.getSize());
            ps.setString(4, monitor.getPanelType());
            ps.setString(5, monitor.getResolution());
            ps.setString(6, monitor.getBitDepth());
            ps.setString(7, monitor.getColorGamut());
            ps.setInt(8, monitor.getBrightness());
            ps.setInt(9, monitor.getRefreshRate());
            ps.setString(10, monitor.getHdr());
            ps.setString(11, monitor.getPorts());
            ps.setBoolean(12, monitor.isAudioOut());
            ps.setString(13, monitor.getFunctionKeys());
            ps.setDouble(14, monitor.getWeight());
            ps.setString(15, monitor.getDimensions());
            ps.setString(16, monitor.getColor());

            return ps.executeUpdate() > 0; // ✅ Trả về `true` nếu thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
