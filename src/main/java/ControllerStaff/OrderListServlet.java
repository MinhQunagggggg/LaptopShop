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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getAllOrders();

        // Debug
        System.out.println("OrderListServlet (GET) - Orders: " + (orders != null ? orders.size() + " items" : "null"));

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/views/Staff/orderList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchKeyword = request.getParameter("search"); // Lấy từ khóa tìm kiếm từ form
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders;

        // Debug
        System.out.println("OrderListServlet (POST) - Search keyword: " + searchKeyword);

        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
            orders = orderDAO.getAllOrders(); // Nếu không có từ khóa, lấy tất cả đơn hàng
        } else {
            orders = orderDAO.searchOrders(searchKeyword); // Gọi hàm tìm kiếm trong OrderDAO
        }

        // Debug
        System.out.println("OrderListServlet (POST) - Orders found: " + (orders != null ? orders.size() + " items" : "null"));

        request.setAttribute("orders", orders); // Truyền danh sách đơn hàng vào request
        request.getRequestDispatcher("/views/Staff/orderList.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling order list and search";
    }
}