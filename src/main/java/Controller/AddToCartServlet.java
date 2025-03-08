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
import model.ProductVariant;
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
            System.out.println("❌ User chưa đăng nhập.");
            response.sendRedirect("Login");
            return;
        }

        int userId = user.getId();
        int variantId = Integer.parseInt(request.getParameter("variantId"));
        String ram = request.getParameter("ram"); // 🔹 Lấy RAM từ form
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        CartDAO cartDAO = new CartDAO();
        ProductVariant variant = cartDAO.getVariantById(variantId);

        if (variant == null) {
            System.out.println("❌ Không tìm thấy sản phẩm.");
            response.sendRedirect("ProductDetail?id=" + variantId);
            return;
        }

        System.out.println("🛒 Thêm vào giỏ hàng: Variant ID = " + variantId + ", RAM = " + ram + ", Price = " + variant.getPrice());

        cartDAO.addToCart(userId, variantId, ram, variant.getPrice(), quantity); // 🔹 Gọi đúng phương thức mới

        int cartSize = cartDAO.getCartSize(userId);
        session.setAttribute("cartSize", cartSize);

        response.sendRedirect("Cart");
    }
}

