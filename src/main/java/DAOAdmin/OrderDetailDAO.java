// DAO/OrderDetailDAO.java
package DAOAdmin;

import DB.DBContext;
import modelAdmin.OrderDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {
    public List<OrderDetail> getOrderStatsByDate() {
        List<OrderDetail> list = new ArrayList<>();
        String query = "SELECT order_id, SUM(quantity) as total_quantity, SUM(quantity * price) as total_amount " +
                      "FROM OrderDetails " +
                      "GROUP BY order_id";
        
          try ( Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setOrderId(rs.getInt("order_id"));
                od.setQuantity(rs.getInt("total_quantity"));
                od.setPrice(rs.getDouble("total_amount"));
                list.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}