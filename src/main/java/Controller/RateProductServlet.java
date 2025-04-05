/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.RatingDAO;
import java.io.IOException;
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
@WebServlet(name = "RateProductServlet", urlPatterns = {"/RateProduct"})
public class RateProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra nếu người dùng chưa đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("redirectAfterLogin", request.getHeader("referer"));
            response.sendRedirect("Login");
            return;
        }

        int userId = user.getId(); // ✅ Lấy userId từ session đúng cách

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));

            RatingDAO ratingDAO = new RatingDAO();

            // Kiểm tra xem user đã đánh giá sản phẩm này chưa
            if (ratingDAO.hasUserRated(productId, userId)) {
                request.setAttribute("errorMessage", "Bạn đã đánh giá sản phẩm này rồi!");
            } else {
                boolean success = ratingDAO.addRating(productId, userId, rating);
                if (!success) {
                    request.setAttribute("errorMessage", "Lỗi khi lưu đánh giá.");
                }
            }

            response.sendRedirect("ProductDetail?id=" + productId); // Quay lại trang chi tiết sản phẩm
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Chuyển hướng nếu có lỗi
        }
    }
}

