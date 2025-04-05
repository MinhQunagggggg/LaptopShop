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
    // 🔹 Lấy danh sách bình luận cha (không có parent_comment_id)

    public List<Comment> getParentComments(int productId) {
        String query = "SELECT c.comment_id, c.user_id, c.product_id, u.name AS username, "
                + "u.avatar_data, "
                + "c.content, c.created_at "
                + "FROM Comments c "
                + "JOIN Users u ON c.user_id = u.user_id "
                + "WHERE c.product_id = ? AND c.parent_comment_id IS NULL AND c.is_deleted = 0 "
                + "ORDER BY c.created_at DESC";

        List<Comment> comments = new ArrayList<>();
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                comments.add(new Comment(
                        rs.getInt("comment_id"),
                        rs.getInt("user_id"),
                        rs.getInt("product_id"),
                        rs.getString("username"),
                        rs.getBytes("avatar_data"),
                        rs.getString("content"),
                        rs.getTimestamp("created_at"),
                        null,
                        false
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    // 🔹 Lấy danh sách phản hồi (có parent_comment_id)
    public List<Comment> getReplies(int productId) {
        String query = "SELECT c.comment_id, c.user_id, c.product_id, u.name AS username, "
                + " u.avatar_data, "
                + "c.content, c.created_at, c.parent_comment_id "
                + "FROM Comments c "
                + "JOIN Users u ON c.user_id = u.user_id "
                + "WHERE c.product_id = ? AND c.parent_comment_id IS NOT NULL AND c.is_deleted = 0 "
                + "ORDER BY c.parent_comment_id, c.created_at";

        List<Comment> replies = new ArrayList<>();
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                replies.add(new Comment(
                        rs.getInt("comment_id"),
                        rs.getInt("user_id"),
                        rs.getInt("product_id"),
                        rs.getString("username"),
                        rs.getBytes("avatar_data"),
                        rs.getString("content"),
                        rs.getTimestamp("created_at"),
                        rs.getInt("parent_comment_id"),
                        false
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }
// 🔹 Thêm bình luận hoặc phản hồi

    public void saveComment(int userId, int productId, Integer parentCommentId, String commentText) {
        String query = "INSERT INTO Comments (user_id, product_id, parent_comment_id, content, created_at, is_deleted) "
                + "VALUES (?, ?, ?, ?, GETDATE(), 0)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setObject(3, parentCommentId); // ✅ NULL nếu là bình luận cha
            ps.setString(4, commentText);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 🔹 Chỉnh sửa bình luận
    public boolean editComment(int commentId, int userId, String newContent) {
        String query = "UPDATE Comments SET content = ?, created_at = GETDATE() WHERE comment_id = ? AND user_id = ? AND is_deleted = 0";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, newContent);
            ps.setInt(2, commentId);
            ps.setInt(3, userId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu sửa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteComment(int commentId, int userId) {
        String query = "UPDATE Comments SET is_deleted = 1 WHERE comment_id = ? AND user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, commentId);
            ps.setInt(2, userId);
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
