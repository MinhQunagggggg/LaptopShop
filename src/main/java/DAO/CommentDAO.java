/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import DB.DBContext;
import model.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author CE182250
 */

public class CommentDAO {
     public List<Comment> getProductComments(int productId) {
        String query = "SELECT u.name AS username, COALESCE(u.avatar_url, 'default-avatar.png') AS avatar_url, " +
                       "c.comment_text AS content, c.created_at " +
                       "FROM Comments c " +
                       "JOIN Users u ON c.user_id = u.user_id " +
                       "WHERE c.product_id = ? " +
                       "ORDER BY c.created_at DESC";

        List<Comment> comments = new ArrayList<>();
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("created_at"); // Lấy timestamp
                Date createdAt = (timestamp != null) ? new Date(timestamp.getTime()) : null; // Chuyển thành java.util.Date

                comments.add(new Comment(
                    rs.getString("username"),
                    rs.getString("avatar_url"),
                    rs.getString("content"),
                    createdAt
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public void saveComment(int userId, int productId, String commentText) {
        String query = "INSERT INTO Comments (user_id, product_id, comment_text, created_at) VALUES (?, ?, ?, GETDATE())";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setString(3, commentText);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
