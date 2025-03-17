/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.WarrantyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import model.User;
import model.WarrantyItem;

/**
 *
 * @author YourName
 */
@WebServlet(name = "WarrantyInfoServlet", urlPatterns = {"/WarrantyInfo"})
public class WarrantyInfoServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        WarrantyDAO warrantyDAO = new WarrantyDAO();
        int userId = user.getId();

        String statusParam = request.getParameter("status");
        List<WarrantyItem> warrantyItems;

        // Xử lý theo trạng thái bảo hành
        if (statusParam == null || statusParam.isEmpty()) {
            // Lấy tất cả các mục bảo hành
            warrantyItems = warrantyDAO.getWarrantyItemsByUserId(userId);
            System.out.println("All Warranty Items for User ID " + userId + ": " + warrantyItems.size());
        } else if ("active".equals(statusParam)) {
            // Lấy các mục bảo hành còn hiệu lực
            warrantyItems = warrantyDAO.getActiveWarrantyItemsByUserId(userId);
            System.out.println("Active Warranty Items for User ID " + userId + ": " + warrantyItems.size());
        } else if ("expired".equals(statusParam)) {
            // Lấy các mục bảo hành đã hết hạn
            warrantyItems = warrantyDAO.getExpiredWarrantyItemsByUserId(userId);
            System.out.println("Expired Warranty Items for User ID " + userId + ": " + warrantyItems.size());
        } else {
            // Mặc định lấy tất cả nếu trạng thái không hợp lệ
            warrantyItems = warrantyDAO.getWarrantyItemsByUserId(userId);
            System.out.println("Default (All) Warranty Items for User ID " + userId + ": " + warrantyItems.size());
        }

        // Đặt dữ liệu vào request
        request.setAttribute("warrantyItems", warrantyItems);
        request.setAttribute("currentDate", new Date()); // Ngày hiện tại để so sánh trong JSP

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("views/User/warranty-info.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể để trống nếu không cần xử lý POST
    }
}