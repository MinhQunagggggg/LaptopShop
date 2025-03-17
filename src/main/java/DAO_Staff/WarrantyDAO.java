package DAO_Staff;

import DB.DBContext;
import Model_Staff.Warranty;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WarrantyDAO {

    // Method to fetch all warranty records with user name and phone
    public List<Warranty> getAllWarranties() {
        String query = "SELECT w.warranty_id, w.order_detail_id,u.user_id, w.name, w.phone,w.address, w.status_id, w.service_center, w.notes, w.date "
                + "FROM Warranty w "
                + "JOIN OrderDetails od ON w.order_detail_id = od.order_detail_id "
                + "JOIN Orders o ON od.order_id = o.order_id "
                + "JOIN Users u ON o.user_id = u.user_id";

        List<Warranty> warranties = new ArrayList<>();

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            // Iterating through the result set
            while (rs.next()) {
                Warranty warranty = new Warranty(
                        rs.getInt("warranty_id"),
                        rs.getInt("order_detail_id"),
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("status_id"),
                        rs.getString("service_center"),
                        rs.getString("notes"),
                        rs.getTimestamp("date")
                );
                warranties.add(warranty);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return warranties;
    }
    public List<Warranty> searchWarranty(String keyword) {
    String query = "SELECT w.warranty_id, w.order_detail_id, u.user_id, w.name, w.phone, w.address, " +
                   "w.status_id, w.service_center, w.notes, w.date " +
                   "FROM Warranty w " +
                   "JOIN OrderDetails od ON w.order_detail_id = od.order_detail_id " +
                   "JOIN Orders o ON od.order_id = o.order_id " +
                   "JOIN Users u ON o.user_id = u.user_id " +
                   "WHERE w.name LIKE ? OR w.phone LIKE ? OR w.service_center LIKE ?";

    List<Warranty> warranties = new ArrayList<>();

    try (Connection conn = new DBContext().getConnection(); 
         PreparedStatement ps = conn.prepareStatement(query)) {

        // ✅ Dùng ký tự `%` để tìm kiếm gần giống
        String searchParam = "%" + keyword + "%";
        ps.setString(1, searchParam);
        ps.setString(2, searchParam);
        ps.setString(3, searchParam);

        try (ResultSet rs = ps.executeQuery()) {
            // ✅ Lặp qua kết quả và tạo đối tượng Warranty
            while (rs.next()) {
                Warranty warranty = new Warranty(
                        rs.getInt("warranty_id"),
                        rs.getInt("order_detail_id"),
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("status_id"),
                        rs.getString("service_center"),
                        rs.getString("notes"),
                        rs.getTimestamp("date")
                );
                warranties.add(warranty);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return warranties;
}


    public void updateWarrantyStatus(int statusId, int warrantyId) {
        String query = "UPDATE Warranty SET status_id = ? WHERE warranty_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            // Set the parameters for the prepared statement
            ps.setInt(1, statusId);  // Set status_id
            ps.setInt(2, warrantyId); // Set warranty_id

            // Execute the update
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
   public int getPendingWarranty() {
        String query = "SELECT COUNT(*) AS pending_warranty FROM Warranty WHERE status_id = '1'"; // Truy vấn chính xác từ bạn
        int pendingWarranty = 0;

        try (Connection conn = new DBContext().getConnection(); // Sử dụng DBContext
             PreparedStatement ps = conn.prepareStatement(query)) {

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pendingWarranty = rs.getInt("pending_warranty"); // Lấy giá trị từ cột "pending_warranty"
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi (có thể thay bằng logging)
        }

        return pendingWarranty;
    }
}
