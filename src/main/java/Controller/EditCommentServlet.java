package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import DAO.CommentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "EditCommentServlet", urlPatterns = {"/EditComment"})
public class EditCommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object userObj = request.getSession().getAttribute("user");
        if (userObj == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            int userId = ((User) userObj).getId();
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            String newContent = request.getParameter("newContent").trim();

            if (newContent.isEmpty()) {
                response.sendRedirect("ProductDetail?id=" + productId);
                return;
            }

            CommentDAO commentDAO = new CommentDAO();
            boolean success = commentDAO.editComment(commentId, userId, newContent);

            response.sendRedirect("ProductDetail?id=" + productId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
