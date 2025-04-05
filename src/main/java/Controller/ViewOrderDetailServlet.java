/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.User;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ViewOrderDetailServlet", urlPatterns = {"/ViewOrderDetail"})
public class ViewOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }
        String orderIdParam = request.getParameter("order_id");
        System.out.println("Received order_id: " + orderIdParam);

        if (orderIdParam == null || orderIdParam.isEmpty()) {
            System.out.println("Lỗi: orderIdParam bị null hoặc rỗng.");
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            System.out.println("Đang lấy chi tiết đơn hàng cho orderId: " + orderId);

            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getOrderDetailsByOrderId(orderId);

            // Kiểm tra xem danh sách có dữ liệu không
            if (orders == null || orders.isEmpty()) {
                System.out.println("Lỗi: Không tìm thấy chi tiết đơn hàng cho orderId: " + orderId);
                request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
                return;
            }

            // In ra console danh sách đơn hàng
            System.out.println("Danh sách đơn hàng cho orderId " + orderId + ":");
            for (Order order : orders) {
                System.out.println(" - Product ID: " + order.getVariantId());
                System.out.println(" - Product Name: " + order.getProductName());
                System.out.println(" - Quantity: " + order.getQuantity());
                System.out.println(" - Price: " + order.getPrice());
            }

            // Gửi danh sách đơn hàng sang JSP
            request.setAttribute("orderDetails", orders);
            request.getRequestDispatcher("views/User/order-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("Lỗi: Không thể chuyển đổi orderId: " + orderIdParam + " thành số nguyên.");
            e.printStackTrace();
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi không xác định khi lấy chi tiết đơn hàng:");
            e.printStackTrace();
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
        }
    }
}
