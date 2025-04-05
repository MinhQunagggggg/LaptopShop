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
import model.User;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "RemoveFromCartServlet", urlPatterns = {"/RemoveFromCart"})
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        int userId = user.getId();
        int variantId = Integer.parseInt(request.getParameter("variantId"));

        CartDAO cartDAO = new CartDAO();
        
        // ✅ Xóa sản phẩm khỏi giỏ hàng
        cartDAO.removeFromCart(userId, variantId);

        // ✅ Cập nhật lại số lượng sản phẩm trong session
        int cartSize = cartDAO.getCartSize(userId);
        session.setAttribute("cartSize", cartSize);

        // ✅ Thêm thông báo sản phẩm đã bị xóa
        session.setAttribute("cartMessage", "Product has been removed from cart!");

        response.sendRedirect("Cart");
    }
}
