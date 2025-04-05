/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO_Staff;

import DB.DBContext;
import Model_Staff.Headphone;
import Model_Staff.Keyboard;
import Model_Staff.Monitor;
import Model_Staff.Mouse;
import Model_Staff.ProductSpecification;
import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author MinhTN
 */
public class ProductDAO {

    public int getLowStockProducts() {
        String query = "SELECT COUNT(*) AS low_stock FROM ProductVariants WHERE stock < 10"; // Truy vấn chính xác từ bạn
        int lowStockProducts = 0;

        try ( Connection conn = new DBContext().getConnection(); // Sử dụng DBContext
                  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                lowStockProducts = rs.getInt("low_stock"); // Lấy giá trị từ cột "low_stock"
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi (có thể thay bằng logging)
        }

        return lowStockProducts;
    }

    public int getTotalProducts() {
        String query = "SELECT COUNT(*) AS total FROM Products"; // Truy vấn đếm tổng sản phẩm
        int totalProducts = 0;

        try ( Connection conn = new DBContext().getConnection(); // Sử dụng DBContext như trong getProductInfo
                  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalProducts = rs.getInt("total"); // Lấy giá trị từ cột "total"
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi (có thể thay bằng logging)
        }

        return totalProducts;
    }

 public Product getProductInfo(int productId) {
        String query = "SELECT \n"
                + "    p.product_id, \n"
                + "    p.name AS product_name, \n"
                + "    p.image_data, \n"
                + "    p.description, \n"
                + "    v.price, \n"
                + "    b.name AS brand_name, \n"
                + "    p.catalog_id\n"
                + "FROM Products p\n"
                + "LEFT JOIN ProductVariants v ON p.product_id = v.product_id\n"
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id\n"
                + "WHERE p.product_id = ?;";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("product_id"),
                            rs.getString("product_name"),
                            rs.getBytes("image_data"), // ✅ Đọc dữ liệu ảnh dạng `byte[]`
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("brand_name"),                          
                            rs.getInt("catalog_id")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Lấy tất cả sản phẩm từ database
    public List<Product> getAllProducts2() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.product_id, p.name, p.description, \n"
                + "       COALESCE(v.price, 0) AS price, p.image_data, p.catalog_id\n"
                + "FROM products p \n"
                + "LEFT JOIN ProductVariants v ON p.product_id = v.product_id\n"
                + "ORDER BY p.catalog_id ASC;";  // Dùng LEFT JOIN để tránh mất dữ liệu

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // ✅ Lấy dữ liệu ảnh dưới dạng byte[]
                byte[] imageBytes = rs.getBytes("image_data");
                String imageBase64 = null;

                // ✅ Chuyển đổi sang Base64 nếu ảnh không null
                if (imageBytes != null) {
                    imageBase64 = "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes);
                }

                // ✅ Thêm sản phẩm vào danh sách
                list.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        imageBytes, // ✅ Lưu trữ dưới dạng `byte[]` để tương thích với model Product
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("catalog_id")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ProductSpecification getProductSpecifications(int productId) {
        String sql = "SELECT \n"
                + "    ps.*, \n"
                + "    pv.ram\n"
                + "FROM LaptopSpecifications ps\n"
                + "JOIN ProductVariants pv ON ps.product_id = pv.product_id\n"
                + "WHERE ps.product_id = ?;";
        ProductSpecification spec = null; // ✅ Khởi tạo biến spec để tránh lỗi return

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId); // ✅ Đúng biến productId truyền vào

            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // ✅ Lấy dữ liệu từ ResultSet và tạo đối tượng ProductSpecification
                    spec = new ProductSpecification(
                            rs.getInt("spec_id"),
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
                            rs.getString("refresh_rate"),
                            rs.getString("ram")
                    );
                } else {
                    System.out.println("⚠️ Không tìm thấy thông số kỹ thuật cho sản phẩm ID: " + productId);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn thông số kỹ thuật: " + e.getMessage());
            e.printStackTrace(); // ✅ In chi tiết lỗi ra log
        }

        return spec; // ✅ Trả về spec (null nếu không có dữ liệu)
    }

    public Monitor getMonitor(int productId) {
        String sql = "SELECT product_id, model, size, panel_type, resolution, bit_depth, color_gamut, "
                + "brightness, refresh_rate, hdr, ports, audio_out, function_keys, weight, dimensions, color "
                + "FROM Monitors WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Monitor(
                            rs.getInt("product_id"),
                            rs.getString("model"),
                            rs.getDouble("size"),
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
                            rs.getDouble("weight"),
                            rs.getString("dimensions"),
                            rs.getString("color")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // ✅ Trả về `null` nếu không tìm thấy monitor
    }

    public Mouse getMouse(int productId) {
        String sql = "SELECT product_id, brand, warranty_months, connection_type, wired, dpi, switch_type, mouse_led, "
                + "color, dimensions, weight "
                + "FROM Mouse WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Mouse(
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
                            rs.getDouble("weight")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // ✅ Trả về `null` nếu không tìm thấy chuột
    }

    public Keyboard getKeyboard(int productId) {
        String sql = "SELECT product_id, brand, warranty_months, type, connection_type, wired, keycap_material, "
                + "switch_type, color, led_color, dimensions, weight, battery_capacity, keycap_profile "
                + "FROM Keyboards WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Keyboard(
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
                            rs.getObject("weight") != null ? rs.getDouble("weight") : null,
                            rs.getInt("battery_capacity"),
                            rs.getString("keycap_profile")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // ✅ Trả về `null` nếu không tìm thấy bàn phím
    }

    public Headphone getHeadphone(int productId) {
        String sql = "SELECT product_id, brand, warranty_months, connection_type, wired, color, led_color, "
                + "weight, frequency_range, material, driver_size "
                + "FROM Headphones WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Headphone(
                            rs.getInt("product_id"),
                            rs.getString("brand"),
                            rs.getInt("warranty_months"),
                            rs.getString("connection_type"),
                            rs.getBoolean("wired"),
                            rs.getString("color"),
                            rs.getString("led_color"), // ✅ Có thể NULL
                            rs.getDouble("weight"), // ✅ Có thể NULL, mặc định 0 nếu null
                            rs.getString("frequency_range"),
                            rs.getString("material"), // ✅ Có thể NULL
                            rs.getInt("driver_size")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // ✅ Trả về `null` nếu không tìm thấy tai nghe
    }

    public int getCatalogId(int productId) {
        String sql = "SELECT catalog_id FROM Products WHERE product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("catalog_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // ✅ Trả về -1 nếu không tìm thấy `catalog_id`
    }

}
