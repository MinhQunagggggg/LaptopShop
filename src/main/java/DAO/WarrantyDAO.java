/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.WarrantyItem;

/**
 *
 * @author LENOVO
 */
public class WarrantyDAO {

    public List<WarrantyItem> getWarrantyItemsByUserId(int userId) {
        List<WarrantyItem> warrantyItems = new ArrayList<>();
        String query = "SELECT v.variant_id, p.name AS product_name,v.ram, od.end_date , od.start_date, od.order_detail_id \n"
                + "                FROM Orders o \n"
                + "                JOIN OrderDetails od ON o.order_id = od.order_id \n"
                + "                JOIN ProductVariants v ON od.variant_id = v.variant_id \n"
                + "                JOIN Products p ON v.product_id = p.product_id \n"
                + "                WHERE o.user_id = ? AND o.status_id = 3 \n"
                + "                ORDER BY od.end_date DESC";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WarrantyItem item = new WarrantyItem(
                        rs.getInt("variant_id"),
                        rs.getInt("order_detail_id"),
                        rs.getString("product_name"),
                        rs.getString("ram"),
                        rs.getTimestamp("end_date"),
                        rs.getTimestamp("start_date")
                );
                warrantyItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warrantyItems;
    }

    // Lấy các mục bảo hành còn hiệu lực
    public List<WarrantyItem> getActiveWarrantyItemsByUserId(int userId) {
        List<WarrantyItem> warrantyItems = new ArrayList<>();
        String query = "SELECT v.variant_id, p.name AS product_name, od.price, od.quantity, v.ram, od.end_date,order_detail_id, od.start_date \n"
                + "               FROM Orders o \n"
                + "               JOIN OrderDetails od ON o.order_id = od.order_id \n"
                + "                JOIN ProductVariants v ON od.variant_id = v.variant_id \n"
                + "               JOIN Products p ON v.product_id = p.product_id \n"
                + "                WHERE o.user_id = ? AND od.end_date > CURRENT_TIMESTAMP AND o.status_id = 3 \n"
                + "                ORDER BY od.end_date DESC";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WarrantyItem item = new WarrantyItem(
                        rs.getInt("variant_id"),
                        rs.getInt("order_detail_id"),
                        rs.getString("product_name"),
                        rs.getString("ram"),
                        rs.getTimestamp("end_date"),
                        rs.getTimestamp("start_date")
                );
                warrantyItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warrantyItems;
    }

    // Lấy các mục bảo hành đã hết hạn
    public List<WarrantyItem> getExpiredWarrantyItemsByUserId(int userId) {
        List<WarrantyItem> warrantyItems = new ArrayList<>();
        String query = "SELECT v.variant_id, p.name AS product_name, od.price, od.quantity, v.ram, od.end_date ,order_detail_id, od.start_date \n"
                + "FROM Orders o \n"
                + "JOIN OrderDetails od ON o.order_id = od.order_id \n"
                + "JOIN ProductVariants v ON od.variant_id  = v.variant_id \n"
                + "JOIN Products p ON v.product_id = p.product_id \n"
                + "WHERE o.user_id = ? AND od.end_date <= CURRENT_TIMESTAMP AND o.status_id = 3 \n"
                + "ORDER BY od.end_date DESC";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WarrantyItem item = new WarrantyItem(
                        rs.getInt("variant_id"),
                        rs.getInt("order_detail_id"),
                        rs.getString("product_name"),
                        rs.getString("ram"),
                        rs.getTimestamp("end_date"),
                        rs.getTimestamp("start_date")
                );
                warrantyItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warrantyItems;
    }

    public WarrantyItem getWarrantyDetail(int orderDetailId) {
        WarrantyItem warrantyItem = null;
        String query = "SELECT Top 1 v.variant_id, p.name AS product_name, v.ram, od.start_date , od.end_date, od.order_detail_id , w.warranty_id , w.status_id\n"
                + "FROM Orders o \n"
                + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
                + "JOIN ProductVariants v ON od.variant_id = v.variant_id\n"
                + "JOIN Products p ON v.product_id = p.product_id\n"
                + "LEFT JOIN Warranty w ON w.order_detail_id = od.order_detail_id\n"
                + "WHERE od.order_detail_id = ?\n"
                + "Order By w.warranty_id DESC";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, orderDetailId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                warrantyItem = new WarrantyItem(
                        rs.getInt("variant_id"),
                        rs.getInt("order_detail_id"),
                        rs.getString("product_name"),
                        rs.getString("ram"),
                        rs.getTimestamp("end_date"),
                        rs.getTimestamp("start_date"),
                        rs.getInt("status_id"),
                        rs.getInt("warranty_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warrantyItem;
    }

    public boolean saveRepairRequest(String orderDetailId, String customerName, String phone, String address, String repairLocation, String repairReason, String warrantyDate) {
        String query = "INSERT INTO Warranty (order_detail_id, name, phone, address, service_center, notes ,date ,status_id)"
                + "VALUES (?, ?, ?, ?, ?, ?, ? , 1)";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, orderDetailId);
            ps.setString(2, customerName);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, repairLocation); // Sử dụng repairLocation làm service_center
            ps.setString(6, repairReason);   // Sử dụng repairReason làm notes
            ps.setString(7, warrantyDate); // Lưu thời gian vào DB  // Sử dụng repairReason làm notes

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getProductById(String orderDetailId) {
        String query = "SELECT pv.product_id "
                + "FROM OrderDetails od "
                + "JOIN ProductVariants pv ON pv.variant_id = od.variant_id "
                + "WHERE od.order_detail_id = ?";
        int productId = -1;  // Giá trị mặc định để kiểm tra lỗi
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, orderDetailId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    productId = rs.getInt("product_id");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productId;  // Trả về productId chính xác
    }

}
