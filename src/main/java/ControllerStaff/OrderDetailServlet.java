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
        // Lấy order_id từ tham số URL
        int orderId = Integer.parseInt(request.getParameter("order_id"));
        
        // Lấy chi tiết đơn hàng từ DAO
        OrderDAO orderDAO = new OrderDAO();
        List<OrderDetail> orderDetails = orderDAO.getOrderDetails(orderId);
        
        // Chuyển dữ liệu đến JSP để hiển thị
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("views/Staff/orderDetail.jsp").forward(request, response);
    }
}

