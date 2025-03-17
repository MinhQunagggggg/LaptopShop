package ControllerStaff;

import DAO_Staff.OrderDAO;
import Model_Staff.OrderDetail;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/OrderDetail"})
public class OrderDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("order_id"));
        OrderDAO orderDAO = new OrderDAO();

        // Lấy danh sách sản phẩm + thông tin đơn hàng từ DAO
        List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);

        // ✅ In log kiểm tra dữ liệu
        if (orderDetails == null || orderDetails.isEmpty()) {
            System.out.println("⚠️ Không tìm thấy dữ liệu đơn hàng cho order_id: " + orderId);
        } else {
            System.out.println("✅ Tìm thấy " + orderDetails.size() + " sản phẩm trong đơn hàng.");
            System.out.println("✅ Trạng thái đơn hàng: " + orderDetails.get(0).getOrderStatus());
        }

        // Gửi dữ liệu đến JSP
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("views/Staff/orderDetail.jsp").forward(request, response);
    }
}

