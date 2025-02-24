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
import java.util.Arrays;
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

        CartDAO cartDAO = new CartDAO();

        // ✅ Lấy danh sách sản phẩm được chọn từ form
        String[] selectedItems = request.getParameterValues("selectedItems");

        if (selectedItems == null || selectedItems.length == 0) {
            response.sendRedirect("Cart?error=Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
            return;
        }

        // ✅ Lấy toàn bộ giỏ hàng của người dùng từ DAO
        List<CartItem> allCartItems = cartDAO.getCartItems(user.getId());

        // ✅ Lọc ra những sản phẩm được chọn để thanh toán
        List<CartItem> checkoutItems = new ArrayList<>();
        double totalAmount = 0;

        for (String selectedVariantId : selectedItems) {
            int variantId = Integer.parseInt(selectedVariantId);

            for (CartItem item : allCartItems) {
                if (item.getVariantId() == variantId) {
                    checkoutItems.add(item);
                    totalAmount += item.getTotalPrice();
                    break;
                }
            }
        }

        // ✅ Lưu danh sách sản phẩm cần thanh toán vào session
        session.setAttribute("checkoutItems", checkoutItems);
        session.setAttribute("totalAmount", totalAmount);

        response.sendRedirect("checkout.jsp");
    }
}