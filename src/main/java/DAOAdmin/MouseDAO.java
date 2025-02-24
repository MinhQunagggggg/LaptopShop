package DAOAdmin;

import modelAdmin.Mouse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import DB.DBContext;

public class MouseDAO {

    public boolean addMouse(Mouse mouse) {
        String sql = "INSERT INTO Mouse (product_id, brand, warranty_months, connection_type, wired, dpi, switch_type, mouse_led, color, dimensions, weight) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, mouse.getProductId());
            ps.setString(2, mouse.getBrand());
            ps.setInt(3, mouse.getWarrantyMonths());
            ps.setString(4, mouse.getConnectionType());
            ps.setBoolean(5, mouse.isWired());
            ps.setInt(6, mouse.getDpi());
            ps.setString(7, mouse.getSwitchType());
            ps.setString(8, mouse.getMouseLed());
            ps.setString(9, mouse.getColor());
            ps.setString(10, mouse.getDimensions());
            ps.setObject(11, mouse.getWeight(), java.sql.Types.FLOAT);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
