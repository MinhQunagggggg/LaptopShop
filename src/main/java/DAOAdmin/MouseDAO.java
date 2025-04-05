package DAOAdmin;


import java.sql.*;
import DB.DBContext;
import modelAdmin.Mouse;

public class MouseDAO {

    // Thêm sản phẩm vào bảng Products trước
    public int addProduct(String productName, String description, int accessoryBrandId, byte[] imageData) throws SQLException {
        String sql = "INSERT INTO Products (name, description, accessory_brand_id, image_data, catalog_id) VALUES (?, ?, ?, ?,3)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, productName);
            stmt.setString(2, description);
            stmt.setInt(3, accessoryBrandId);
            stmt.setBytes(4, imageData);
            stmt.executeUpdate();
            try ( ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Lấy product_id vừa tạo
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

    // Thêm chuột vào bảng Mouse
    public void addMouse(Mouse mouse) throws SQLException {
        String sql = "INSERT INTO Mouse (product_id, brand, warranty_months, connection_type, wired, dpi, switch_type, mouse_led, color, dimensions, weight) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, mouse.getProductId());
            stmt.setString(2, mouse.getBrand());
            stmt.setInt(3, mouse.getWarrantyMonths());
            stmt.setString(4, mouse.getConnectionType());
            stmt.setBoolean(5, mouse.isWired());
            stmt.setInt(6, mouse.getDpi());
            stmt.setString(7, mouse.getSwitchType());
            stmt.setString(8, mouse.getMouseLed());
            stmt.setString(9, mouse.getColor());
            stmt.setString(10, mouse.getDimensions());
            stmt.setFloat(11, mouse.getWeight());
            stmt.executeUpdate();
        }
    }
    public Mouse getMouseByProductId(int productId) {
        String query = "SELECT * FROM [dbo].[Mouse] WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database");
            }
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Mouse(
                    rs.getInt("mouse_id"),
                    rs.getInt("product_id"),
                    rs.getString("brand"),
                    rs.getInt("warranty_months"),
                    rs.getString("connection_type"),
                    rs.getBoolean("wired"),
                    rs.getInt("dpi"),
                    rs.getString("switch_type"),
                    rs.getString("mouse_led"),
                    rs.getString("color"),
                    rs.getString("dimensions"),
                    rs.getFloat("weight"),
                    null, // productName không có trong bảng
                    null, // description không có trong bảng
                    0,    // accessory_brand_id không có trong bảng, đặt mặc định là 0
                    null  // imageData không có trong bảng
                );
            } else {
                System.out.println("Không tìm thấy chuột với productId: " + productId);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy dữ liệu chuột: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateMouse(Mouse mouse) {
        String query = "UPDATE [dbo].[Mouse] SET brand = ?, warranty_months = ?, connection_type = ?, " +
                       "wired = ?, dpi = ?, switch_type = ?, mouse_led = ?, color = ?, dimensions = ?, " +
                       "weight = ? WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database");
            }
            stmt.setString(1, mouse.getBrand());
            stmt.setInt(2, mouse.getWarrantyMonths());
            stmt.setString(3, mouse.getConnectionType());
            stmt.setBoolean(4, mouse.isWired());
            stmt.setInt(5, mouse.getDpi());
            stmt.setString(6, mouse.getSwitchType());
            stmt.setString(7, mouse.getMouseLed());
            stmt.setString(8, mouse.getColor());
            stmt.setString(9, mouse.getDimensions());
            stmt.setFloat(10, mouse.getWeight());
            stmt.setInt(11, mouse.getProductId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật chuột: " + e.getMessage());

            e.printStackTrace();
        }
        return false;
    }
}
