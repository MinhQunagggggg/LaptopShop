package DAO_Staff;

import DB.DBContext;
import Model_Staff.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    // 📌 1️⃣ Lấy danh sách bình luận theo sản phẩm (bao gồm phản hồi)
    public List<Comment> getCommentsByProduct(int productId) {
    List<Comment> comments = new ArrayList<>();
    String sql = "SELECT c.comment_id, c.parent_comment_id, c.content, c.created_at, "
               + "u.user_id, u.name AS user_name, u.avatar_data AS image_user, u.role_id "
               + "FROM Comments c "
               + "JOIN Users u ON c.user_id = u.user_id "
               + "WHERE c.product_id = ? AND c.is_deleted = 0 "
               + "ORDER BY COALESCE(c.parent_comment_id, c.comment_id), c.created_at ASC";

    try (Connection conn = new DBContext().getConnection(); 
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, productId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Integer parentCommentId = (Integer) rs.getObject("parent_comment_id"); // NULL-safe retrieval

                comments.add(new Comment(
                    rs.getInt("comment_id"),
                    parentCommentId, // parent_comment_id có thể là NULL
                    productId,
                    rs.getInt("user_id"), // Lấy user_id từ DB
                    rs.getString("content"),
                    rs.getTimestamp("created_at"),
                    rs.getString("user_name"),
                    rs.getBytes("image_user"), // ✅ Lấy ảnh user từ DB dưới dạng byte[]
                    false, // Mặc định là không bị xóa
                    rs.getInt("role_id")
                ));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return comments;
}


    // 📌 2️⃣ Thêm bình luận hoặc phản hồi
    public void addComment(int productId, int userId, String content, Integer parentCommentId) {
        String sql = "INSERT INTO Comments (product_id, user_id, parent_comment_id, content, created_at, is_deleted) "
                + "VALUES (?, ?, ?, ?, GETDATE(), 0)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            stmt.setInt(2, userId);

            // Xử lý trường hợp parentCommentId là null
            if (parentCommentId == null) {
                stmt.setNull(3, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(3, parentCommentId);
            }

            stmt.setString(4, content);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 📌 3️⃣ Xóa bình luận (cập nhật is_deleted = 1)
    public void deleteComment(int commentId) {
        String sql = "UPDATE Comments SET is_deleted = 1 WHERE comment_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, commentId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 📌 4️⃣ Đếm số lượng bình luận theo sản phẩm
    public int countCommentsByProduct(int productId) {
        String sql = "SELECT COUNT(*) FROM Comments WHERE product_id = ? AND is_deleted = 0";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
