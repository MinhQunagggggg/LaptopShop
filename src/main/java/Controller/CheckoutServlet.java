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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        String[] selectedItems = request.getParameterValues("selectedItems");
        if (selectedItems == null || selectedItems.length == 0) {
            response.sendRedirect("Cart?error=No items selected");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        List<CartItem> checkoutItems = new ArrayList<>();
        double totalAmount = 0;

        for (String itemId : selectedItems) {
            int variantId = Integer.parseInt(itemId);
            int stock = cartDAO.getStockForVariant(variantId); // ✅ Kiểm tra số lượng tồn kho

            for (CartItem item : cartDAO.getCartItems(user.getId())) {
                if (item.getVariantId() == variantId) {
                    String quantityParam = request.getParameter("quantity_" + variantId);
                    if (quantityParam != null) {
                        int updatedQuantity = Integer.parseInt(quantityParam);

                        if (stock == 0) {
                            session.setAttribute("cartError", "❌ Product '" + item.getProductName() + "' out of stock!");
                            response.sendRedirect("Cart");
                            return;
                        }

                        if (updatedQuantity > stock) {
                            session.setAttribute("cartError", "❌ Product '" + item.getProductName() + "' only left " + stock + " product!");
                            response.sendRedirect("Cart");
                            return;
                        }

                        item.setQuantity(updatedQuantity);
                        item.setTotalPrice(updatedQuantity * item.getPrice());
                    }
                    checkoutItems.add(item);
                    totalAmount += item.getTotalPrice();
                    break;
                }
            }
        }

        session.setAttribute("checkoutItems", checkoutItems);
        session.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/views/User/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }
    }
}
