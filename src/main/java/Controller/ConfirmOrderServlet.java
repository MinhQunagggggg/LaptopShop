/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CartDAO;
import DAO.OrderDAO;
import java.io.IOException;
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
@WebServlet(name = "ConfirmOrderServlet", urlPatterns = {"/ConfirmOrderServlet"})
public class ConfirmOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        String[] selectedItems = request.getParameterValues("selectedItems");

        if (selectedItems == null || selectedItems.length == 0) {
            response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp");
            return;
        }

        List<CartItem> checkoutItems = (List<CartItem>) session.getAttribute("checkoutItems");
        if (checkoutItems == null || checkoutItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/views/User/cart.jsp");
            return;
        }

        double totalAmount = (double) session.getAttribute("totalAmount");
        int userId = user.getId();
        OrderDAO orderDAO = new OrderDAO();
        CartDAO cartDAO = new CartDAO();

        try {
            // ✅ Tạo đơn hàng mới (GỌI ĐÚNG PHIÊN BẢN)
            int orderId = orderDAO.createOrder(userId, totalAmount, paymentMethod);
            if (orderId <= 0) {
                response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp?error=order-failed");
                return;
            }

            // ✅ Kiểm tra số lượng tồn kho
            for (CartItem item : checkoutItems) {
                int stock = cartDAO.getStockForVariant(item.getVariantId());
                int quantity = Integer.parseInt(request.getParameter("quantity_" + item.getVariantId()));

                if (quantity > stock) {
                    response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp?error=out-of-stock");
                    return;
                }
            }

            // ✅ Thêm vào OrderDetails và trừ hàng
            for (CartItem item : checkoutItems) {
                int quantity = Integer.parseInt(request.getParameter("quantity_" + item.getVariantId()));
                orderDAO.addOrderDetail(orderId, item.getVariantId(), quantity, item.getPrice());
                cartDAO.updateStockAfterPurchase(item.getVariantId(), quantity);
            }

            // ✅ Xóa giỏ hàng
            cartDAO.updateCartAfterCheckout(userId, checkoutItems);

            // ✅ VNPay
            if ("VNPay".equals(paymentMethod)) {
                String vnPayRedirectUrl = request.getContextPath() + "/VNPayPayment?orderId=" + orderId + "&amount=" + (int) totalAmount;
                response.sendRedirect(vnPayRedirectUrl);
                return;
            }

            // ✅ Chuyển sang trang xác nhận
            session.setAttribute("orderId", orderId);
            session.setAttribute("orderTotal", totalAmount);
            session.setAttribute("orderDetails", checkoutItems);
            session.removeAttribute("checkoutItems");
            session.removeAttribute("totalAmount");

            response.sendRedirect(request.getContextPath() + "/views/User/order-confirmation.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp?error=order-failed");
        }
    }
}
