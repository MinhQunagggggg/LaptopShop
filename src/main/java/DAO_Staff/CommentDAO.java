package DAO_Staff;

import DB.DBContext;
import Model_Staff.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommentDAO {

    // Lấy danh sách bình luận theo sản phẩm và tổ chức thành cấu trúc cây
    public List<Comment> getCommentsByProduct(int productId) {
        List<Comment> allComments = new ArrayList<>();
        Map<Integer, Comment> commentMap = new HashMap<>(); // Lưu comment theo ID để dễ tìm

        String sql = "SELECT c.comment_id, c.parent_comment_id, c.content, c.created_at, "
                   + "u.user_id, u.name AS user_name, u.avatar_data AS image_user, u.role_id, c.is_deleted "
                   + "FROM Comments c "
                   + "JOIN Users u ON c.user_id = u.user_id "
                   + "WHERE c.product_id = ? "
                   + "ORDER BY c.created_at ASC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Integer parentCommentId = (Integer) rs.getObject("parent_comment_id");
                    Comment comment = new Comment(
                        rs.getInt("comment_id"),
                        parentCommentId,
                        productId,
                        rs.getInt("user_id"),
                        rs.getString("content"),
                        rs.getTimestamp("created_at"),
                        rs.getString("user_name"),
                        rs.getBytes("image_user"),
                        rs.getBoolean("is_deleted"),
                        rs.getInt("role_id")
                    );
                    allComments.add(comment);
                    commentMap.put(comment.getCommentId(), comment);
                }
            }

            // Xây dựng cấu trúc cây: gắn replies vào comment cha
            for (Comment comment : allComments) {
                if (comment.getParentCommentId() != null) {
                    Comment parent = commentMap.get(comment.getParentCommentId());
                    if (parent != null) {
                        parent.getReplies().add(comment);
                    }
                }
            }

            // Chỉ giữ lại các comment gốc (không có parent) để hiển thị
            List<Comment> rootComments = new ArrayList<>();
            for (Comment comment : allComments) {
                if (comment.getParentCommentId() == null && !comment.isDeleted()) {
                    rootComments.add(comment);
                }
            }

            return rootComments;

        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Thêm bình luận mới
    public void addComment(int productId, int userId, String content, Integer parentCommentId) {
        String sql = "INSERT INTO Comments (product_id, user_id, content, parent_comment_id, created_at, is_deleted) "
                   + "VALUES (?, ?, ?, ?, GETDATE(), 0)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            stmt.setInt(2, userId);
            stmt.setString(3, content);
            if (parentCommentId != null) {
                stmt.setInt(4, parentCommentId);
            } else {
                stmt.setNull(4, java.sql.Types.INTEGER);
            }
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa bình luận (soft delete) và các bình luận con trực tiếp
    public void deleteComment(int commentId) {
        // Đầu tiên, tìm tất cả các bình luận con trực tiếp của commentId
        List<Integer> commentsToDelete = new ArrayList<>();
        commentsToDelete.add(commentId); // Thêm chính bình luận cần xóa

        // Tìm các bình luận con đệ quy
        findChildComments(commentId, commentsToDelete);

        // Cập nhật is_deleted = 1 cho tất cả các bình luận trong danh sách
        String sql = "UPDATE Comments SET is_deleted = 1 WHERE comment_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (Integer id : commentsToDelete) {
                stmt.setInt(1, id);
                stmt.addBatch();
            }
            stmt.executeBatch();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Hàm đệ quy để tìm tất cả các bình luận con
    private void findChildComments(int commentId, List<Integer> commentsToDelete) {
        String sql = "SELECT comment_id FROM Comments WHERE parent_comment_id = ? AND is_deleted = 0";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, commentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int childId = rs.getInt("comment_id");
                    commentsToDelete.add(childId);
                    // Đệ quy để tìm các bình luận con của bình luận con
                    findChildComments(childId, commentsToDelete);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Đếm số lượng bình luận của sản phẩm
    public int countCommentsByProduct(int productId) {
        String sql = "SELECT COUNT(*) FROM Comments WHERE product_id = ? AND is_deleted = 0";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
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