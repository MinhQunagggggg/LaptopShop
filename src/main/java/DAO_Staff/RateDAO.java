package DAO_Staff;

import DB.DBContext;
import Model_Staff.Rate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RateDAO {

    // 📌 1️⃣ Lấy tổng số lượt đánh giá và điểm trung bình của sản phẩm
    public double getAverageRating(int productId) {
        String sql = "SELECT CAST(ROUND(AVG(CAST(rating AS DECIMAL(10, 5))), 1) AS FLOAT) AS avg_rating\n"
                + "FROM Ratings \n"
                + "WHERE product_id = ?;";
        double averageRating = 0.0;

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    averageRating = rs.getDouble("avg_rating");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Math.round(averageRating * 10.0) / 10.0; // ✅ Làm tròn 1 chữ số sau dấu phẩy
    }

    public int getTotalRatings(int productId) {
        String sql = "SELECT COUNT(*) AS total_ratings FROM Ratings  WHERE product_id = ?";
        int totalRatings = 0;

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalRatings = rs.getInt("total_ratings");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRatings;
    }

    // 📌 2️⃣ Lấy danh sách các đánh giá của sản phẩm (bao gồm ảnh đại diện)
    public List<Rate> getRatingsByProduct(int productId) {
        List<Rate> ratings = new ArrayList<>();
        String sql = "SELECT r.rating_id, r.user_id, r.product_id, r.rating, "
                + "u.name, u.phone, u.avatar_data AS image_user "
                + // ✅ Lấy ảnh từ VARBINARY
                "FROM Ratings r "
                + "JOIN Users u ON r.user_id = u.user_id "
                + "WHERE r.product_id = ? "
                + "ORDER BY r.rating_id DESC;";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ratings.add(new Rate(
                            rs.getInt("rating_id"),
                            rs.getInt("user_id"),
                            rs.getInt("product_id"),
                            rs.getInt("rating"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getBytes("image_user") // ✅ Lấy ảnh dưới dạng byte[]
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getRatingsByProduct: " + e.getMessage());
            e.printStackTrace();
        }
        return ratings;
    }

}
