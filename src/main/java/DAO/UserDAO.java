/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.User;
import java.sql.*;

/**
 *
 * @author CE182250
 */
public class UserDAO {

    // Lấy thông tin người dùng theo ID
    public User getUserById(int userId) {
        String query = "SELECT * FROM Users WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("name"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("phone")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật thông tin người dùng
    public boolean updateUserProfile(User user) {
        String query = "UPDATE Users SET name = ?, email = ?, phone = ? WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setInt(4, user.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đổi mật khẩu người dùng
    public boolean changePassword(int userId, String newPassword) {
        String query = "UPDATE Users SET password = ? WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
 public User getUser(String username, String password) {
        String query = "SELECT user_id, username, name, role_id, password FROM Users WHERE username = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password").trim();
                String hashedInputPassword = hashMD5(password).trim();

                if (storedPassword.equals(hashedInputPassword)) {
                    return new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("name"),rs.getInt("role_id"));
                } 
            } 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String hashMD5(String input) {

        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes(StandardCharsets.UTF_8));

            StringBuilder sb = new StringBuilder();
            for (byte b : messageDigest) {
                sb.append(String.format("%02x", b & 0xFF));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public boolean isUserExists(String username, String email) {
        String query = "SELECT COUNT(*) FROM Users WHERE username = ? OR email = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm người dùng mới vào database
    public boolean registerUser(String name, String email, String phone, String username, String password) {
        if (isUserExists(username, email)) {
            return false; // Không cho phép đăng ký nếu đã tồn tại
        }

        String query = "INSERT INTO Users (name, email, phone, username, password, role_id) VALUES (?, ?, ?, ?, ?, 1)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            String Pass = hashMD5(password); // Mã hóa mật khẩu

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, username);
            ps.setString(5, Pass); // Mã hóa mật khẩu

            int result = ps.executeUpdate();

            return result > 0;
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return false;
    }}
