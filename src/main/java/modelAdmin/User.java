package modelAdmin;

import java.util.Date;

public class User {
    private int userId;
    private String name;
    private String username;
    private String phone;
    private String email;
    private int roleId;
    private Date createdAt;
    private String avatarUrl;

    public User(int userId, String name, String username, String phone, String email, int roleId, Date createdAt, String avatarUrl) {
        this.userId = userId;
        this.name = name;
        this.username = username;
        this.phone = phone;
        this.email = email;
        this.roleId = roleId;
        this.createdAt = createdAt;
        this.avatarUrl = avatarUrl;
    }

    // **Thêm getter và setter đầy đủ**
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
}