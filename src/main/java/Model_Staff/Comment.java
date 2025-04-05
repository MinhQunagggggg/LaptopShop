package Model_Staff;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Comment {
    private int commentId;
    private Integer parentCommentId;
    private int productId;
    private int userId;
    private String content;
    private Timestamp createdAt;
    private String userName;
    private byte[] imageUser;
    private boolean isDeleted;
    private int role_id;
    private List<Comment> replies;

    public Comment(int commentId, Integer parentCommentId, int productId, int userId, String content,
                   Timestamp createdAt, String userName, byte[] imageUser, boolean isDeleted, int role_id) {
        this.commentId = commentId;
        this.parentCommentId = parentCommentId;
        this.productId = productId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
        this.userName = userName;
        this.imageUser = imageUser;
        this.isDeleted = isDeleted;
        this.role_id = role_id;
        this.replies = new ArrayList<>();
    }

    // Getters and setters
    public int getCommentId() { return commentId; }
    public void setCommentId(int commentId) { this.commentId = commentId; }

    public Integer getParentCommentId() { return parentCommentId; }
    public void setParentCommentId(Integer parentCommentId) { this.parentCommentId = parentCommentId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public byte[] getImageUser() { return imageUser; }
    public void setImageUser(byte[] imageUser) { this.imageUser = imageUser; }

    public boolean isDeleted() { return isDeleted; }
    public void setDeleted(boolean deleted) { isDeleted = deleted; }

    public int getRole_id() { return role_id; }
    public void setRole_id(int role_id) { this.role_id = role_id; }

    public List<Comment> getReplies() { return replies; }
    public void setReplies(List<Comment> replies) { this.replies = replies; }
}