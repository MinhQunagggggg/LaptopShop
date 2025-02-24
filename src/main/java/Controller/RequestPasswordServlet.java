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
import java.io.IOException;
import java.sql.SQLException;

import java.util.logging.Level;
import java.util.logging.Logger;
import model.TokenForgetPassword;
import model.User;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "RequestPasswordServlet", urlPatterns = {"/RequestPassword"})
public class RequestPasswordServlet extends HttpServlet {

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

        request.getRequestDispatcher("views/User/request-password.jsp").forward(request, response);
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
        try {
            UserDAO userDAO = new UserDAO();
            String email = request.getParameter("email");
            User user = userDAO.getUserByEmail(email);
            if (user == null) {
                request.setAttribute("errorMessage", "Email does not exist!");
                request.getRequestDispatcher("views/User/request-password.jsp").forward(request, response);
                return;
            }

            String link = userDAO.generateToken();
            String token = userDAO.generateToken();
            String linkReset = "http://localhost:8080/ResetPassword?token=" + token;
            TokenForgetPassword newTokenForgot = new TokenForgetPassword(
                    user.getId(), false, token, userDAO.expireDateTime());
            TokenForgetDAO tokenDAO = new TokenForgetDAO();

            boolean isInsert = tokenDAO.insertTokenForget(newTokenForgot);
            if (!isInsert) {
                request.setAttribute("errorMessage", "Have error in server!");
                request.getRequestDispatcher("views/User/request-password.jsp").forward(request, response);
                return;
            }
            boolean isSend = userDAO.sendEmail(email, linkReset, user.getUsername());
            if (!isSend) {
                request.setAttribute("errorMessage", "Send Fail!");
                request.getRequestDispatcher("views/User/request-password.jsp").forward(request, response);
                return;
            }
            request.setAttribute("successMessage", "Send request success");
            request.getRequestDispatcher("views/User/request-password.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(RequestPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

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
