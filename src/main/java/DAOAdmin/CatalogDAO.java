package DAOAdmin;

import DB.DBContext;
import modelAdmin.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelAdmin.Catalog;

public class CatalogDAO {
    public List<Catalog> getAllCatalogsMNgoc() {
        List<Catalog> catalogs = new ArrayList<>();
        String sql = "SELECT catalog_id, name FROM Catalog";
       try ( Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                catalogs.add(new Catalog(rs.getInt("catalog_id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return catalogs;
    }
}
