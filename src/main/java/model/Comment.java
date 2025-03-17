/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author CE182250
 */
public class Comment {

    private int commentId;
    private int userId;
    private int productId;
    private String username;
    private byte[] avatarData;
    private String content;
    private Timestamp createdAt;
    private Integer parentCommentId;
    private boolean isDeleted;
    private List<Comment> replies;

    // 🔹 Constructor đầy đủ
    public Comment(int commentId, int userId, int productId, String username, byte[] avatarData,
            String content, Timestamp createdAt, Integer parentCommentId, boolean isDeleted) {
        this.commentId = commentId;
        this.userId = userId;
        this.productId = productId;
        this.username = username;
        this.avatarData = avatarData;
        this.content = content;
        this.createdAt = createdAt;
        this.parentCommentId = parentCommentId;
        this.isDeleted = isDeleted;
        this.replies = new ArrayList<>();
    }

 

    // 🔹 Getter & Setter
    public int getCommentId() {
        return commentId;
    }

    public int getUserId() {
        return userId;
    }

    public int getProductId() {
        return productId;
    }

    public String getUsername() {
        return username;
    }


    public String getContent() {
        return content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Integer getParentCommentId() {
        return parentCommentId;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public List<Comment> getReplies() {
        return replies;
    }

    public void setReplies(List<Comment> replies) {
        this.replies = replies;
    }

    public void setDeleted(boolean deleted) {
        this.isDeleted = deleted;
    }
}
