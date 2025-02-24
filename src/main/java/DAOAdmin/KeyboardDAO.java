package DAOAdmin;

import DB.DBContext;
import modelAdmin.Keyboard;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class KeyboardDAO {

    public boolean addKeyboard(Keyboard keyboard) {
        String sql = "INSERT INTO keyboard (product_id, brand, connection_type, mechanical, switch_type, rgb, layout, dimensions, weight, warranty_months) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, keyboard.getProductId());
            ps.setString(2, keyboard.getBrand());
            ps.setString(3, keyboard.getConnectionType());
            ps.setBoolean(4, keyboard.isMechanical());
            ps.setString(5, keyboard.getSwitchType());
            ps.setBoolean(6, keyboard.isRgb());
            ps.setString(7, keyboard.getLayout());
            ps.setString(8, keyboard.getDimensions());
            ps.setDouble(9, keyboard.getWeight());
            ps.setInt(10, keyboard.getWarrantyMonths());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
