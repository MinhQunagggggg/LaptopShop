package DAOAdmin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelAdmin.Keyboard;
import DB.DBContext;

public class KeyboardDAO {
    public int addProduct(String productName, String description, int accessoryBrandId, byte[] imageData) throws SQLException {
        String sql = "INSERT INTO Products (name, description, accessory_brand_id, image_data, catalog_id) VALUES (?, ?, ?, ?, 4)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, productName);
            stmt.setString(2, description);
            stmt.setInt(3, accessoryBrandId);
            stmt.setBytes(4, imageData);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Lấy product_id vừa tạo
                }
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


    // Thêm bàn phím vào bảng Keyboards
    public void addKeyboard(Keyboard keyboard) throws SQLException {
        String sql = "INSERT INTO Keyboards (product_id, brand, warranty_months, type, connection_type, wired, keycap_material, switch_type, color, led_color, dimensions, weight, battery_capacity, keycap_profile) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, keyboard.getProductId());
            stmt.setString(2, keyboard.getBrand());
            stmt.setInt(3, keyboard.getWarrantyMonths());
            stmt.setString(4, keyboard.getType());
            stmt.setString(5, keyboard.getConnectionType());
            stmt.setBoolean(6, keyboard.isWired());
            stmt.setString(7, keyboard.getKeycapMaterial());
            stmt.setString(8, keyboard.getSwitchType());
            stmt.setString(9, keyboard.getColor());
            stmt.setString(10, keyboard.getLedColor());
            stmt.setString(11, keyboard.getDimensions());
            stmt.setFloat(12, keyboard.getWeight());
            stmt.setInt(13, keyboard.getBatteryCapacity());
            stmt.setString(14, keyboard.getKeycapProfile());
            stmt.executeUpdate();
        }
    }
    public Keyboard getKeyboardByProductId(int productId) {
        String query = "SELECT * FROM [dbo].[Keyboards] WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database");
            }
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Keyboard(
                    rs.getInt("keyboard_id"),
                    rs.getInt("product_id"),
                    rs.getString("brand"),
                    rs.getInt("warranty_months"),
                    rs.getString("type"),
                    rs.getString("connection_type"),
                    rs.getBoolean("wired"),
                    rs.getString("keycap_material"),
                    rs.getString("switch_type"),
                    rs.getString("color"),
                    rs.getString("led_color"),
                    rs.getString("dimensions"),
                    rs.getFloat("weight"),
                    rs.getInt("battery_capacity"),
                    rs.getString("keycap_profile"),
                    null, // productName
                    null, // description
                    0,    // accessoryBrandId không có trong bảng
                    null  // imageData
                );
            } else {
                System.out.println("Không tìm thấy bàn phím với productId: " + productId);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy dữ liệu bàn phím: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateKeyboard(Keyboard keyboard) {
        String query = "UPDATE [dbo].[Keyboards] SET brand = ?, warranty_months = ?, type = ?, " +
                       "connection_type = ?, wired = ?, keycap_material = ?, switch_type = ?, " +
                       "color = ?, led_color = ?, dimensions = ?, weight = ?, battery_capacity = ?, " +
                       "keycap_profile = ? WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database");
            }
            stmt.setString(1, keyboard.getBrand());
            stmt.setInt(2, keyboard.getWarrantyMonths());
            stmt.setString(3, keyboard.getType());
            stmt.setString(4, keyboard.getConnectionType());
            stmt.setBoolean(5, keyboard.isWired());
            stmt.setString(6, keyboard.getKeycapMaterial());
            stmt.setString(7, keyboard.getSwitchType());
            stmt.setString(8, keyboard.getColor());
            stmt.setString(9, keyboard.getLedColor());
            stmt.setString(10, keyboard.getDimensions());
            stmt.setFloat(11, keyboard.getWeight());
            stmt.setInt(12, keyboard.getBatteryCapacity());
            stmt.setString(13, keyboard.getKeycapProfile());
            stmt.setInt(14, keyboard.getProductId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật bàn phím: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}

