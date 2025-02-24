package DAOAdmin;

import DB.DBContext;
import modelAdmin.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelAdmin.SubBrand;

public class SubBrandDAO {
    public List<SubBrand> getAllSubBrandsMNgoc() {
        List<SubBrand> subbrands = new ArrayList<>();
        String sql = "SELECT subbrand_id, name FROM SubBrands";
        try ( Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                subbrands.add(new SubBrand(rs.getInt("subbrand_id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subbrands;
    }
}
