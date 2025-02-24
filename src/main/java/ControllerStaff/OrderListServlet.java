package ControllerStaff;

import DAO_Staff.OrderDAO;
import Model_Staff.Order;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "OrderListServlet", urlPatterns = {"/OrderList"})
public class OrderListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getAllOrders();
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("views/Staff/orderList.jsp").forward(request, response);
    }
}
