/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import model.User;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.UUID;
import model.TokenForgetPassword;

/**
 *
 * @author CE182250
 */
public class UserDAO {

    private final int LIMIT_MINUS = 10;
    private final String from = "minhplnce180439@fpt.edu.vn";
    private final String password = "ljbi dohx rnmg ionz";

    // Lấy thông tin người dùng theo ID
    public User getUserById(int userId) {
        String query = "SELECT user_id, name, username, email, phone ,shipping_address , avatar_data FROM Users WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("name"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getBytes("avatar_data"),
                            rs.getString("shipping_address")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by ID: " + e.getMessage());
        }
        return null;
    }

    // Cập nhật thông tin người dùng
    public boolean updateUserProfile(User user) {
        String query = "UPDATE Users SET name = ?, email = ?, phone = ?, shipping_address = ? WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setInt(5, user.getId());

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
        String query = "SELECT user_id,name,role_id, password ,avatar_data FROM Users WHERE username = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password").trim();
                String hashedInputPassword = hashMD5(password).trim();

                if (storedPassword.equals(hashedInputPassword)) {
                    return new User(rs.getInt("user_id"), rs.getString("name"), rs.getInt("role_id"), rs.getBytes("avatar_data"));
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
    public boolean registerUser(String name, String email, String phone, String username, String password, String address) {
        if (isUserExists(username, email)) {
            return false; // Không cho phép đăng ký nếu đã tồn tại
        }

        String query = "INSERT INTO Users (name, email, phone, username, shipping_address,password, role_id) VALUES (?, ?, ?, ?, ?, ?, 1)";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            String Pass = hashMD5(password);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, username);
            ps.setString(5, address);
            ps.setString(6, Pass);

            int result = ps.executeUpdate();

            return result > 0;
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email) {
        String query = "SELECT user_id, username, email, password FROM Users WHERE email = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String generateToken() {
        return UUID.randomUUID().toString();
    }

    public LocalDateTime expireDateTime() {
        return LocalDateTime.now().plusMinutes(10);
    }

    public boolean isExperiTime(LocalDateTime time) {
        return LocalDateTime.now().isAfter(time);
    }

    public boolean sendEmail(String to, String link, String name) {
        final Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Reset Your Password - TPF Shop", "UTF-8");

            // Nội dung email với HTML và CSS inline
            String content = "<!DOCTYPE html>"
                    + "<html lang='en'>"
                    + "<head>"
                    + "<meta charset='UTF-8'>"
                    + "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                    + "<title>Reset Password</title>"
                    + "</head>"
                    + "<body style='margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f5f7fa;'>"
                    + "<div style='max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); overflow: hidden;'>"
                    + "<div style='background-color: #4a00e0; padding: 20px; text-align: center;'>"
                    + "<h1 style='color: #ffffff; margin: 0; font-size: 28px;'>TPF Shop</h1>"
                    + "</div>"
                    + "<div style='padding: 30px;'>"
                    + "<h2 style='color: #4a00e0; font-size: 24px; margin-bottom: 20px;'>Hello " + name + ",</h2>"
                    + "<p style='color: #333; font-size: 16px; line-height: 1.6; margin-bottom: 20px;'>You have requested to reset your password. Click the button below to set a new password for your account:</p>"
                    + "<div style='text-align: center; margin: 30px 0;'>"
                    + "<a href='" + link + "' style='display: inline-block; padding: 12px 30px; background-color: #4a00e0; color: #ffffff; text-decoration: none; font-size: 16px; font-weight: bold; border-radius: 5px; transition: background-color 0.3s;'>Reset Password</a>"
                    + "</div>"
                    + "<p style='color: #333; font-size: 16px; line-height: 1.6; margin-bottom: 20px;'>If you did not request a password reset, please ignore this email or contact our support team.</p>"
                    + "<p style='color: #333; font-size: 16px; line-height: 1.6; margin-bottom: 0;'>Best regards,<br>The TPF Shop Team</p>"
                    + "</div>"
                    + "<div style='background-color: #f5f5f5; padding: 15px; text-align: center; font-size: 14px; color: #777;'>"
                    + "<p style='margin: 0;'>Need help? <a href='mailto:support@tpfshop.com' style='color: #4a00e0; text-decoration: none;'>Contact us</a></p>"
                    + "</div>"
                    + "</div>"
                    + "</body>"
                    + "</html>";

            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public void updatePassword(String mail, String passord) {

        String query = "UPDATE Users SET password = ? WHERE email = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, hashMD5(passord));
            ps.setString(2, mail);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateStatus(TokenForgetPassword token) {
        String query = "UPDATE tokenForgotPassword SET isUsed = ? WHERE token = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setBoolean(1, token.isIsUsed());
            ps.setString(2, token.getToken());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void updateUsername(String email, String username) {
        String query = "UPDATE Users SET username = ? WHERE email = ? AND username IS NULL";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateUserPassword(int id, String newPassword) {
        String query = "UPDATE Users SET password = ? WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, hashMD5(newPassword));
            ps.setInt(2, id);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean checkPassword(int userId, String inputPassword) {
        String query = "SELECT password FROM Users WHERE user_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password").trim();
                String hashedInputPassword = hashMD5(inputPassword).trim();
                return storedPassword.equals(hashedInputPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateImage(int userId, byte[] imageData) {
        String query = "UPDATE Users SET avatar_data = ? WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setBytes(1, imageData);
            ps.setInt(2, userId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
