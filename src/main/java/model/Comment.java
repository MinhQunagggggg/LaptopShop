/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author CE182250
 */
public class Comment {
    private String username;
    private String avatarUrl;
    private String content;
    private Date createdAt;

    public Comment(String username, String avatarUrl, String content, Date createdAt) {
        this.username = username;
        this.avatarUrl = (avatarUrl != null) ? avatarUrl : "default-avatar.png";
        this.content = content;
        this.createdAt = createdAt;
    }

    public String getUsername() { return username; }
    public String getAvatarUrl() { return avatarUrl; }
    public String getContent() { return content; }
    public Date getCreatedAt() { return createdAt; }
}
