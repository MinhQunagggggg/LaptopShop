package DAO_Staff;

import DB.DBContext;
import Model_Staff.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private Connection conn;

    public CommentDAO() {
        this.conn = new DBContext().getConnection();
    }

    // 📌 1️⃣ Lấy danh sách bình luận theo sản phẩm (bao gồm phản hồi)
public List<Comment> getCommentsByProduct(int productId) {
    List<Comment> comments = new ArrayList<>();
    String sql = "SELECT c.comment_id, c.parent_comment_id, c.content, c.created_at, u.name " +
                 "FROM Comments c " +
                 "JOIN Users u ON c.user_id = u.user_id " +
                 "WHERE c.product_id = ? AND c.is_deleted = 0 " +
                 "ORDER BY COALESCE(c.parent_comment_id, 0) ASC, c.created_at ASC";

    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, productId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Integer parentCommentId = (Integer) rs.getObject("parent_comment_id"); // NULL-safe retrieval

                comments.add(new Comment(
                        rs.getInt("comment_id"),
                        parentCommentId, // parent_comment_id có thể là NULL
                        rs.getString("content"),
                        rs.getTimestamp("created_at"),
                        rs.getString("name")
                ));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return comments;
}


    // 📌 2️⃣ Thêm bình luận hoặc phản hồi
    public void addComment(int productId, int userId, String content, Integer parentCommentId) {
        String sql = "INSERT INTO Comments (product_id, user_id, parent_comment_id, content) VALUES (?, ?, ?, ?)";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, userId);

            // Xử lý trường hợp parentCommentId là null
            if (parentCommentId == null) {
                stmt.setNull(3, java.sql.Types.INTEGER); // Nếu là phản hồi, sẽ là NULL
            } else {
                stmt.setInt(3, parentCommentId); // Nếu là bình luận gốc, set giá trị của parentCommentId
            }

            stmt.setString(4, content);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteComment(int commentId) {
        String sql = "UPDATE Comments SET is_deleted = 1 WHERE comment_id = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, commentId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
