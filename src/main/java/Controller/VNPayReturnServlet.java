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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "VNPayReturnServlet", urlPatterns = {"/VNPayReturn"})
public class VNPayReturnServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // ✅ Nhận kết quả thanh toán từ VNPay
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String orderId = request.getParameter("vnp_TxnRef");

        if ("00".equals(vnp_ResponseCode)) {
            System.out.println("✅ Thanh toán VNPay thành công! Order ID: " + orderId);
            session.setAttribute("paymentMessage", "Thanh toán VNPay thành công! Đơn hàng #" + orderId);
        } else {
            System.out.println("❌ Thanh toán VNPay thất bại! Order ID: " + orderId);
            session.setAttribute("paymentError", "Thanh toán VNPay thất bại! Vui lòng thử lại.");
        }

        response.sendRedirect(request.getContextPath() + "/views/User/order-confirmation.jsp");
    }
}
