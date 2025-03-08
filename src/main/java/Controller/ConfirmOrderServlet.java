/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CartDAO;
import DAO.OrderDAO;
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
@WebServlet(name = "ConfirmOrderServlet", urlPatterns = {"/ConfirmOrderServlet"})
public class ConfirmOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            System.out.println("❌ Người dùng chưa đăng nhập!");
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // Lấy dữ liệu từ form
        String customerName = request.getParameter("customerName");
        String shippingAddress = request.getParameter("shippingAddress");
        String phone = request.getParameter("phone");
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
            System.out.println("📌 Debug: Dữ liệu từ form checkout:");
            System.out.println("User ID: " + userId);
            System.out.println("Tên: " + customerName + ", Địa chỉ: " + shippingAddress + ", SĐT: " + phone);
            System.out.println("Phương thức thanh toán: " + paymentMethod);
            System.out.println("Tổng tiền: " + totalAmount);

            // ✅ Tạo đơn hàng mới
            int orderId = orderDAO.createOrder(userId, customerName, shippingAddress, phone, totalAmount, paymentMethod);
            if (orderId <= 0) {
                System.out.println("❌ Không tạo được đơn hàng!");
                response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp?error=order-failed");
                return;
            }
            System.out.println("✅ Đơn hàng đã tạo với ID: " + orderId);

            // ✅ Kiểm tra số lượng sản phẩm có vượt quá tồn kho không
            for (CartItem item : checkoutItems) {
                int stock = cartDAO.getStockForVariant(item.getVariantId());
                int quantity = Integer.parseInt(request.getParameter("quantity_" + item.getVariantId()));

                if (quantity > stock) {
                    System.out.println("❌ Lỗi: Số lượng vượt quá tồn kho! VariantID: " + item.getVariantId() + " | Stock: " + stock + " | Requested: " + quantity);
                    response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp?error=out-of-stock");
                    return;
                }
            }

            // ✅ Lưu tất cả sản phẩm vào bảng OrderDetails và trừ tồn kho
            for (CartItem item : checkoutItems) {
                int quantity = Integer.parseInt(request.getParameter("quantity_" + item.getVariantId()));
                orderDAO.addOrderDetail(orderId, item.getVariantId(), quantity, item.getPrice());
                cartDAO.updateStockAfterPurchase(item.getVariantId(), quantity);
                System.out.println("✅ Đã thêm vào OrderDetails: OrderID = " + orderId + ", VariantID = " + item.getVariantId() + ", Quantity = " + quantity);
            }

            // ✅ Xóa sản phẩm đã mua khỏi giỏ hàng
            cartDAO.updateCartAfterCheckout(userId, checkoutItems);

           if ("VNPay".equals(paymentMethod)) {
    System.out.println("✅ Chuyển hướng đến VNPay.");

    // ✅ Kiểm tra `orderId` và `totalAmount` có giá trị hợp lệ không
    if (orderId <= 0 || totalAmount <= 0) {
        System.out.println("❌ Lỗi: orderId hoặc totalAmount không hợp lệ!");
        session.setAttribute("paymentError", "Lỗi thanh toán: Thông tin đơn hàng không hợp lệ.");
        response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp");
        return;
    }

    // ✅ Chuyển hướng đến VNPay với đầy đủ dữ liệu
    String vnPayRedirectUrl = request.getContextPath() + "/VNPayPayment?orderId=" + orderId + "&amount=" + (int) totalAmount;
    System.out.println("✅ Chuyển hướng đến: " + vnPayRedirectUrl);
    response.sendRedirect(vnPayRedirectUrl);
    return; // 🔥 Dừng xử lý tiếp nếu dùng VNPay
}


  



            // ✅ Lưu thông tin đơn hàng vào session để hiển thị trên trang xác nhận
            session.setAttribute("orderId", orderId);
            session.setAttribute("orderTotal", totalAmount);
            session.setAttribute("orderDetails", checkoutItems);
            session.removeAttribute("checkoutItems");
            session.removeAttribute("totalAmount");

            // ✅ Chuyển hướng đến trang xác nhận đơn hàng
            System.out.println("✅ Đơn hàng đã đặt thành công!");
            response.sendRedirect(request.getContextPath() + "/views/User/order-confirmation.jsp");

        } catch (Exception e) {
            System.out.println("❌ LỖI TOÀN BỘ QUÁ TRÌNH:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp?error=order-failed");
        }
    }
}
