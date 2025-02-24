/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.TokenForgetDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.TokenForgetPassword;
import model.User;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPassword"})
public class ResetPasswordServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        String token = request.getParameter("token");
        TokenForgetDAO tokenDAO = new TokenForgetDAO();
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();

        if (token == null || token.isEmpty()) {
            request.setAttribute("errorMessage", "Token is required.");
            request.getRequestDispatcher("/views/User/request-password.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin token từ database
        TokenForgetPassword tokenForgetPassword = tokenDAO.getTokenPassword(token);

        if (tokenForgetPassword == null) {
            request.setAttribute("errorMessage", "Invalid token.");
            request.getRequestDispatcher("/views/User/request-password.jsp").forward(request, response);
            return;
        }

        // Kiểm tra token đã được sử dụng chưa
        if (tokenForgetPassword.isIsUsed()) {
            request.setAttribute("errorMessage", "Token is already used.");
            request.getRequestDispatcher("/views/User/request-password.jsp").forward(request, response);
            return;
        }

        // Kiểm tra token có hết hạn chưa
        if (userDAO.isExperiTime(tokenForgetPassword.getExpiryTime())) {
            request.setAttribute("errorMessage", "Token has expired.");
            request.getRequestDispatcher("/views/User/request-password.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin user từ token
        User user = userDAO.getUserById(tokenForgetPassword.getUserId());
        if (user == null) {
            request.setAttribute("errorMessage", "User not found.");
            request.getRequestDispatcher("/views/User/request-password.jsp").forward(request, response);
            return;
        }

        // Lưu thông tin vào session
        session.setAttribute("token", token);
        request.setAttribute("email", user.getEmail());

        // Kiểm tra username có tồn tại không
        if (user.getUsername() == null || user.getUsername().isEmpty()) {
            request.setAttribute("requireUsername", true); // Hiển thị ô nhập username
        } else {
            request.setAttribute("username", user.getUsername());
            request.setAttribute("requireUsername", false); // Không cần nhập username
        }

        // Chuyển hướng đến trang reset password
        request.getRequestDispatcher("/views/User/reset-password.jsp").forward(request, response);
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
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "confirm password must same password!");
            response.sendRedirect(request.getContextPath() + "/views/User/reset-password.jsp");
            return;
        }
        HttpSession session = request.getSession();
        UserDAO user = new UserDAO();
        TokenForgetPassword tokenForgetPassword = new TokenForgetPassword();
        tokenForgetPassword.setToken((String) session.getAttribute("token"));
        tokenForgetPassword.setIsUsed(true);
        user.updatePassword(email, password);
        if (username != null && !username.trim().isEmpty()) {
            user.updateUsername(email, username); // Cập nhật username nếu nó đang null
        }
        user.updateStatus(tokenForgetPassword);

        response.sendRedirect(request.getContextPath() + "/Login");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
