package Model_Staff;

import java.sql.Timestamp;

public class Comment {
    private int commentId;
    private Integer parentCommentId; // Có thể là NULL nếu là bình luận gốc
    private int productId;
    private int userId;
    private String content;
    private Timestamp createdAt;
    private String userName; // Tên người bình luận (để hiển thị trên giao diện)
    private boolean isDeleted;

    // ✅ Constructor đầy đủ
    public Comment(int commentId, Integer parentCommentId, int productId, int userId, String content, Timestamp createdAt, String userName, boolean isDeleted) {
        this.commentId = commentId;
        this.parentCommentId = parentCommentId;
        this.productId = productId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
        this.userName = userName;
        this.isDeleted = isDeleted;
    }

    // ✅ Constructor đơn giản cho phản hồi không cần productId/userId
    public Comment(int commentId, Integer parentCommentId, String content, Timestamp createdAt, String userName) {
        this.commentId = commentId;
        this.parentCommentId = parentCommentId;
        this.content = content;
        this.createdAt = createdAt;
        this.userName = userName;
    }

    // 🔹 Getter và Setter
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public Integer getParentCommentId() {
        return parentCommentId;
    }

    public void setParentCommentId(Integer parentCommentId) {
        this.parentCommentId = parentCommentId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
}
