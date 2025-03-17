/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOAdmin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import DB.DBContext;

public class AccessoryBrandDAO {
   public List<String> getAllAccessoryBrands() throws SQLException {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT accessory_brand_id, name FROM AccessoryBrands";
       try (Connection conn = new DBContext().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                brands.add(rs.getInt("accessory_brand_id") + ": " + rs.getString("name"));
            }
        }
        return brands;
    }
}