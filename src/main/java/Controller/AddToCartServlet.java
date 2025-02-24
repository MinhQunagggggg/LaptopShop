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
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCart"})
public class AddToCartServlet extends HttpServlet {
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
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        CartDAO cartDAO = new CartDAO();
        cartDAO.addToCart(userId, variantId, quantity);

        // ✅ Cập nhật số lượng trong giỏ hàng
        int cartSize = cartDAO.getCartSize(userId);
        session.setAttribute("cartSize", cartSize);

        // ✅ **Lưu thông báo vào session**
        session.setAttribute("cartMessage", "🛒 Sản phẩm đã được thêm vào giỏ hàng!");

        // ✅ **Chuyển hướng trở lại trang sản phẩm**
        response.sendRedirect("ProductDetail?id=" + variantId);
    }
}





