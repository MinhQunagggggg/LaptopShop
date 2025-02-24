/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CommentDAO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "AddCommentServlet", urlPatterns = {"/AddComment"})
public class AddCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        int userId = user.getId();
        int productId = Integer.parseInt(request.getParameter("productId"));
        String parentCommentIdStr = request.getParameter("parentCommentId");
        Integer parentCommentId = (parentCommentIdStr == null || parentCommentIdStr.isEmpty()) ? null : Integer.parseInt(parentCommentIdStr);
        String commentText = request.getParameter("commentText").trim();

        if (!commentText.isEmpty()) {
            new CommentDAO().saveComment(userId, productId, parentCommentId, commentText);
        }

        response.sendRedirect("ProductDetail?id=" + productId);
    }
}

