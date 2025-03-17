package DAOAdmin;

import DB.DBContext;
import modelAdmin.Stat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public List<Stat> getCustomerStats(Integer year, Integer month) {
        List<Stat> stats = new ArrayList<>();
        String sql = "SELECT MONTH(created_at) AS month, YEAR(created_at) AS year, COUNT(user_id) AS count " +
                     "FROM [dbo].[Users] WHERE role_id = 1 AND created_at IS NOT NULL " +
                     (year != null ? "AND YEAR(created_at) = ? " : "") +
                     (month != null ? "AND MONTH(created_at) = ? " : "") +
                     "GROUP BY MONTH(created_at), YEAR(created_at) ORDER BY year, month";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (year != null) stmt.setInt(paramIndex++, year);
            if (month != null) stmt.setInt(paramIndex++, month);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    stats.add(new Stat(rs.getInt("month"), rs.getInt("year"), rs.getInt("count")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
}