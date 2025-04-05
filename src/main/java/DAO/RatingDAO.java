/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import DB.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author CE182250
 */

public class RatingDAO {
     // 🔹 Kiểm tra nếu user đã đánh giá sản phẩm này chưa
    public boolean hasUserRated(int productId, int userId) {
        String query = "SELECT COUNT(*) FROM Ratings WHERE product_id = ? AND user_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 Thêm đánh giá vào cơ sở dữ liệu (trả về true nếu thành công)
    public boolean addRating(int productId, int userId, int rating) {
        String query = "INSERT INTO Ratings (product_id, user_id, rating) VALUES (?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.setInt(3, rating);
            return ps.executeUpdate() > 0; // ✅ Kiểm tra xem có bao nhiêu dòng được thêm
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 Lấy rating của user cho sản phẩm
    public int getUserRating(int productId, int userId) {
        String query = "SELECT rating FROM Ratings WHERE product_id = ? AND user_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("rating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 🔹 Lấy điểm trung bình đánh giá
    public double getAverageRating(int productId) {
        String query = "SELECT ROUND(AVG(CAST(rating AS FLOAT)), 1) AS average_rating FROM Ratings WHERE product_id = ?";
        double avgRating = 0;
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                avgRating = rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return avgRating;
    }
}