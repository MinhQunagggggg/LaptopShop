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
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.User;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/Checkout"})
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        // Lấy danh sách sản phẩm được chọn từ form
        String[] selectedItems = request.getParameterValues("selectedItems");

        if (selectedItems == null || selectedItems.length == 0) {
            response.sendRedirect("Cart");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        List<CartItem> checkoutItems = new ArrayList<>();
        double totalAmount = 0;

        for (String variantIdStr : selectedItems) {
            int variantId = Integer.parseInt(variantIdStr);
            CartItem item = cartDAO.getCartItem(user.getId(), variantId);
            if (item != null) {
                checkoutItems.add(item);
                totalAmount += item.getTotalPrice();
            }
        }

        // Đưa danh sách sản phẩm thanh toán vào request
        request.setAttribute("checkoutItems", checkoutItems);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("views/User/checkout.jsp").forward(request, response);
    }
}
