package DAO;

import DB.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Brand;

public class BrandDAO {

    // Lấy danh sách hãng Laptop từ Database
    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        String query = "SELECT brand_id, name FROM Brands ORDER BY name ASC"; // Sắp xếp theo tên

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                brands.add(new Brand(rs.getInt("brand_id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brands;
    }

    // Lấy danh sách hãng Phụ kiện từ Database
    public List<Brand> getAccessoryBrands() {
        List<Brand> accessoryBrands = new ArrayList<>();
        String query = "SELECT accessory_brand_id AS brand_id, name FROM AccessoryBrands ORDER BY name ASC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                accessoryBrands.add(new Brand(rs.getInt("brand_id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accessoryBrands;
    }
}
