package DAOAdmin;

import DB.DBContext;
import modelAdmin.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> getAllCategoriesMNgoc() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT category_id, name FROM Categories";
       try ( Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(rs.getInt("category_id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}
