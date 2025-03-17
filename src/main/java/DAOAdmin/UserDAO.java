package DAOAdmin;

import DB.DBContext;
import modelAdmin.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<User> getStaffList() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT user_id, name, username, phone, email, role_id, created_at, avatar_url FROM Users WHERE role_id = 3";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new User(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getInt("role_id"),
                        rs.getTimestamp("created_at"),
                        rs.getString("avatar_url")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getStaffById(int userId) {
        String sql = "SELECT user_id, name, username, phone, email, role_id, created_at, avatar_url FROM Users WHERE user_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("name"),
                            rs.getString("username"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getInt("role_id"),
                            rs.getTimestamp("created_at"),
                            rs.getString("avatar_url")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStaffById(User user) {
        String sql = "UPDATE Users SET name = ?, phone = ?, email = ?, avatar_url = ? WHERE user_id = ? AND role_id = 3";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAvatarUrl());
            ps.setInt(5, user.getUserId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteStaffById(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ? AND role_id = 3";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
