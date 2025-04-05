package DAOAdmin;

import DB.DBContext;
import modelAdmin.RevenueStat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RevenueDAO {
    public List<RevenueStat> getRevenueStats(Integer year, Integer month) {
        List<RevenueStat> stats = new ArrayList<>();
        String sql = "SELECT MONTH(created_at) AS month, YEAR(created_at) AS year, SUM(total_price) AS totalRevenue " +
                     "FROM [dbo].[Orders] WHERE created_at IS NOT NULL " +
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
                    stats.add(new RevenueStat(rs.getInt("month"), rs.getInt("year"), rs.getDouble("totalRevenue")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
}