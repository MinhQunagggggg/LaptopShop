package DAOAdmin;

import DB.DBContext;
import modelAdmin.Headphone;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class HeadphoneDAO {

    public boolean addHeadphone(Headphone headphone) {
        String sql = "INSERT INTO Headphones (product_id, brand, warranty_months, connection_type, wired, color, led_color, weight, frequency_range, material, driver_size) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, headphone.getProductId());
            ps.setString(2, headphone.getBrand());
            ps.setInt(3, headphone.getWarrantyMonths());
            ps.setString(4, headphone.getConnectionType());
            ps.setBoolean(5, headphone.isWired());
            ps.setString(6, headphone.getColor());

            // Kiểm tra nếu `ledColor` có giá trị null thì setNull
            if (headphone.getLedColor() != null) {
                ps.setString(7, headphone.getLedColor());
            } else {
                ps.setNull(7, java.sql.Types.NVARCHAR);
            }

            // Kiểm tra nếu `weight` có giá trị null thì setNull
            if (headphone.getWeight() != 0) {
                ps.setDouble(8, headphone.getWeight());
            } else {
                ps.setNull(8, java.sql.Types.DECIMAL);
            }

            ps.setString(9, headphone.getFrequencyRange());

            // Kiểm tra nếu `material` có giá trị null thì setNull
            if (headphone.getMaterial() != null) {
                ps.setString(10, headphone.getMaterial());
            } else {
                ps.setNull(10, java.sql.Types.NVARCHAR);
            }

            ps.setInt(11, headphone.getDriverSize());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
