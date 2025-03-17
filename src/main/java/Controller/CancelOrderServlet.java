package Controller;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/CancelOrder"})
public class CancelOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect("error.jsp?msg=Invalid Order ID");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        // Gọi DAO để cập nhật trạng thái hủy đơn hàng
        OrderDAO orderDAO = new OrderDAO();
        orderDAO.cancelOrder(orderId);

        // Quay lại ViewOrderServlet để load lại danh sách đơn hàng
        response.sendRedirect("ViewOrder");
    }

}
