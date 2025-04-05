package ControllerStaff;

import DAO_Staff.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateOrderStatusServlet", urlPatterns = {"/UpdateOrderStatus"})
public class UpdateOrderStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId =Integer.parseInt(request.getParameter("user_id"));
        int orderId = Integer.parseInt(request.getParameter("order_id"));
        int statusId = Integer.parseInt(request.getParameter("status_id"));

        OrderDAO orderDAO = new OrderDAO();
        orderDAO.updateOrderStatus(orderId, statusId, userId);
        
        response.sendRedirect("OrderList");
    }
}
