package DAO_Staff;

import ControllerStaff.CreateUserStatus;
import DB.DBContext;
import Model_Staff.User;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    private Connection conn;

    public CustomerDAO() {
        DBContext dbContext = new DBContext();
        this.conn = dbContext.getConnection();
    }

    // Get all customers
    public List<User> getAllCustomers() {
        List<User> customers = new ArrayList<>();
        String query = "SELECT user_id, name, username, phone, email, avatar_data , shipping_address FROM Users WHERE role_id = 1";
        try {
            ResultSet rs = new DBContext().execSelectQuery(query);
            while (rs.next()) {
                User customer = new User();
                customer.setId(rs.getInt("user_id"));
                customer.setName(rs.getString("name"));
                customer.setUsername(rs.getString("username"));
                customer.setPhone(rs.getString("phone"));
                customer.setEmail(rs.getString("email"));
                
                // Retrieve avatar data as byte array
                byte[] avatarData = rs.getBytes("avatar_data");
                customer.setAvatarUrl(avatarData);  // Set the avatar as byte array
                customer.setAddress(rs.getString("shipping_address"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }




    // Get customer by ID
   public User getCustomerById(int userId) {
    String query = "SELECT user_id, name, username, phone, email, avatar_data, shipping_address FROM Users WHERE user_id = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        // Set parameters for the query
        ps.setInt(1, userId);

        // Execute the query and get the result set
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                User customer = new User();
                customer.setId(rs.getInt("user_id"));
                customer.setName(rs.getString("name"));
                customer.setUsername(rs.getString("username"));
                customer.setPhone(rs.getString("phone"));
                customer.setEmail(rs.getString("email"));
                
                // Retrieve avatar data as byte array
                byte[] avatarData = rs.getBytes("avatar_data");
                customer.setAvatarUrl(avatarData);  // Set avatar as byte array
                
                customer.setAddress(rs.getString("shipping_address"));
                return customer;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();  // Or use a logger for better error handling
    }
    return null;  // Return null if no customer is found or an error occurs
}


    // Update customer info
    public boolean updateCustomerInfo(int userId, String name, String phone, String email, String address, byte[] avatarData) {
        String query;
        if (avatarData != null && avatarData.length > 0) {
            query = "UPDATE Users SET name = ?, phone = ?, email = ?, shipping_address = ?, avatar_data = ? WHERE user_id = ?";
        } else {
            query = "UPDATE Users SET name = ?, phone = ?, email = ?, shipping_address = ? WHERE user_id = ?";
        }

        try {
            Object[] params = new Object[]{name, phone, email, address, userId};
            if (avatarData != null && avatarData.length > 0) {
                params = new Object[]{name, phone, email, address, avatarData, userId};
            }

            int rowsUpdated = new DBContext().execQuery(query, params);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

 private boolean isUsernameExist(String username) {
        String query = "SELECT COUNT(*) FROM Users WHERE username = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // Trả về true nếu đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức kiểm tra email đã tồn tại hay chưa
    private boolean isEmailExist(String email) {
        String query = "SELECT COUNT(*) FROM Users WHERE email = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // Trả về true nếu đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Phương thức tạo mới user, trả về CreateUserStatus để biết tình trạng:
     *  - USERNAME_EXISTS
     *  - EMAIL_EXISTS
     *  - SUCCESS
     *  - FAIL
     */
    public CreateUserStatus createCustomer(User customer) {
        // Kiểm tra username
        if (isUsernameExist(customer.getUsername())) {
            return CreateUserStatus.USERNAME_EXISTS;
        }

        // Kiểm tra email
        if (isEmailExist(customer.getEmail())) {
            return CreateUserStatus.EMAIL_EXISTS;
        }

        // Nếu qua 2 vòng kiểm tra => tiến hành INSERT
        String query = "INSERT INTO Users (name, phone, email, role_id, shipping_address, avatar_data, username, password) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            byte[] avatarData = customer.getAvatarUrl() != null ? customer.getAvatarUrl() : new byte[0];
            Object[] params = new Object[] {
                    customer.getName(),
                    customer.getPhone(),
                    customer.getEmail(),
                    1, // role_id mặc định
                    customer.getAddress(),
                    avatarData,
                    customer.getUsername(),
                    customer.getPassword()
            };

            int rowsInserted = new DBContext().execQuery(query, params);
            if (rowsInserted > 0) {
                return CreateUserStatus.SUCCESS;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return CreateUserStatus.FAIL;
    }

    // Delete customer by ID
    public boolean deleteCustomerById(int id) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try {
            Object[] params = new Object[]{id};
            int rowsAffected = new DBContext().execQuery(sql, params);
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int getTotalCustomers() {
        String query = "SELECT COUNT(*) AS total FROM Users where role_id = 1;"; // Truy vấn đếm tổng khách hàng
        int totalCustomers = 0;

        try (Connection conn = new DBContext().getConnection(); // Sử dụng DBContext
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalCustomers = rs.getInt("total"); // Lấy giá trị từ cột "total"
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi (có thể thay bằng logging)
        }

        return totalCustomers;
    }
    
    
}
