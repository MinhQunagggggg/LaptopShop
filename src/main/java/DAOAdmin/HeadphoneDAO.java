package DAOAdmin;


import modelAdmin.Headphone;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import DB.DBContext;

public class HeadphoneDAO {

    public int addProduct(String productName, String description, int accessoryBrandId, byte[] imageData) throws SQLException {
        String sql = "INSERT INTO Products (name, description, accessory_brand_id, image_data, catalog_id) VALUES (?, ?, ?, ?, 5)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, productName);
            stmt.setString(2, description);
            stmt.setInt(3, accessoryBrandId);
            stmt.setBytes(4, imageData);
            stmt.executeUpdate();

            try ( ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public void addVariant(int productId, double price, int stock) throws SQLException {
        String query = "INSERT INTO ProductVariants (product_id, price, stock, ram) VALUES (?, ?, ?, NULL)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            stmt.setDouble(2, price);
            stmt.setInt(3, stock);
            stmt.executeUpdate();
        }
    }

    public void addHeadphone(Headphone headphone) throws SQLException {
        String sql = "INSERT INTO Headphones (product_id, brand, warranty_months, connection_type, wired, color, led_color, weight, frequency_range, material, driver_size) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, headphone.getProductId());
            stmt.setString(2, headphone.getBrand());
            stmt.setInt(3, headphone.getWarrantyMonths());
            stmt.setString(4, headphone.getConnectionType());
            stmt.setBoolean(5, headphone.isWired());
            stmt.setString(6, headphone.getColor());
            stmt.setString(7, headphone.getLedColor());
            stmt.setFloat(8, headphone.getWeight());
            stmt.setString(9, headphone.getFrequencyRange());
            stmt.setString(10, headphone.getMaterial());
            stmt.setInt(11, headphone.getDriverSize());
            stmt.executeUpdate();
        }
    }
    public Headphone getHeadphoneByProductId(int productId) {
        String query = "SELECT * FROM [dbo].[Headphones] WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database");
            }
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Headphone(
                    rs.getInt("headphone_id"),
                    rs.getInt("product_id"),
                    rs.getString("brand"),
                    rs.getInt("warranty_months"),
                    rs.getString("connection_type"),
                    rs.getBoolean("wired"),
                    rs.getString("color"),
                    rs.getString("led_color"),
                    rs.getFloat("weight"), // Lưu ý: bảng dùng decimal(10,2), ánh xạ sang float
                    rs.getString("frequency_range"),
                    rs.getString("material"),
                    rs.getInt("driver_size"),
                    null, // productName
                    null, // description
                    0,    // accessoryBrandId không có trong bảng
                    null  // imageData
                );
            } else {
                System.out.println("Không tìm thấy tai nghe với productId: " + productId);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy dữ liệu tai nghe: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateHeadphone(Headphone headphone) {
        String query = "UPDATE [dbo].[Headphones] SET brand = ?, warranty_months = ?, connection_type = ?, " +
                       "wired = ?, color = ?, led_color = ?, weight = ?, frequency_range = ?, " +
                       "material = ?, driver_size = ? WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database");
            }
            stmt.setString(1, headphone.getBrand());
            stmt.setInt(2, headphone.getWarrantyMonths());
            stmt.setString(3, headphone.getConnectionType());
            stmt.setBoolean(4, headphone.isWired());
            stmt.setString(5, headphone.getColor());
            stmt.setString(6, headphone.getLedColor());
            stmt.setFloat(7, headphone.getWeight());
            stmt.setString(8, headphone.getFrequencyRange());
            stmt.setString(9, headphone.getMaterial());
            stmt.setInt(10, headphone.getDriverSize());
            stmt.setInt(11, headphone.getProductId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật tai nghe: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}
