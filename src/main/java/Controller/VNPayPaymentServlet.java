/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "VNPayPaymentServlet", urlPatterns = {"/VNPayPayment"})
public class VNPayPaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String totalAmount = request.getParameter("amount");

        // ✅ Kiểm tra `orderId` và `totalAmount` có giá trị hợp lệ không
        if (orderId == null || totalAmount == null || orderId.isEmpty() || totalAmount.isEmpty()) {
            System.out.println("❌ Lỗi: orderId hoặc totalAmount bị null!");
            response.sendRedirect(request.getContextPath() + "/views/User/checkout.jsp?error=invalid-payment");
            return;
        }

        // ✅ VNPay Configuration
        String vnp_TmnCode = "YOUR_VNPAY_TMN_CODE"; // Mã terminal từ VNPay
        String vnp_HashSecret = "YOUR_VNPAY_HASH_SECRET"; // Chuỗi bí mật để ký dữ liệu
        String vnp_ReturnUrl = request.getRequestURL().toString().replace("VNPayPayment", "VNPayReturn");

        // ✅ Chuyển `totalAmount` về VND * 100 (yêu cầu của VNPay)
        int amountInVND = Integer.parseInt(totalAmount) * 100;

        // ✅ Tạo thông tin giao dịch
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amountInVND)); // ✅ Định dạng đúng
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", orderId);
        vnp_Params.put("vnp_OrderInfo", "Thanh toán đơn hàng #" + orderId);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", request.getRemoteAddr());

        // ✅ Tạo URL chuyển hướng đến VNPay
        StringBuilder queryUrl = new StringBuilder();
        for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
            if (queryUrl.length() > 0) {
                queryUrl.append("&");
            }
            queryUrl.append(entry.getKey()).append("=").append(entry.getValue());
        }

        String vnPayUrl = "https://sandbox.vnpayment.vn/payment/?" + queryUrl.toString();
        System.out.println("✅ Chuyển hướng đến VNPay: " + vnPayUrl);
        response.sendRedirect(vnPayUrl);
    }
}
