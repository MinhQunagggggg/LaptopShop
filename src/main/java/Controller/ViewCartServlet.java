/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.CartItem;
import model.User;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/Cart"})
public class ViewCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        int userId = user.getId();

        // ✅ Lấy danh sách sản phẩm trong giỏ hàng
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        request.setAttribute("cartItems", cartItems);

        // ✅ Cập nhật lại số lượng sản phẩm trong session
        int cartSize = cartDAO.getCartSize(userId);
        session.setAttribute("cartSize", cartSize);

        // ✅ Debug: Kiểm tra nếu danh sách giỏ hàng rỗng
        System.out.println("Cart Items for User ID " + userId + ": " + cartItems.size());

        request.getRequestDispatcher("views/User/cart.jsp").forward(request, response);
    }
}
