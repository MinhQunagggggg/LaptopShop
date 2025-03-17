/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.User;

/**
 *
 * @author LENOVOf
 */
@WebServlet(name = "ViewOrderServlet", urlPatterns = {"/ViewOrder"})
public class ViewOrderServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }
        OrderDAO orderDAO = new OrderDAO();
        int userId = user.getId();

        String statusParam = request.getParameter("status_id");
        Integer statusId = null;

        if (statusParam != null) {
            try {
                statusId = Integer.parseInt(statusParam);
            } catch (NumberFormatException e) {
                System.out.println("Invalid status_id: " + statusParam);
            }
        }

        if (statusId == null) {
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            request.setAttribute("orders", orders);
            // ✅ Debug: Check the retrieved orders
            System.out.println("Orders for User ID " + userId + ": " + orders.size());
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
        }
        if (statusId == 1) {
            List<Order> orders = orderDAO.getOrdersByUserIdAndStatus(userId, statusId);
            request.setAttribute("orders", orders);
            // ✅ Debug: Check the retrieved orders
            System.out.println("Orders for User ID " + userId + ": " + orders.size());
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
        }
        if (statusId == 2) {
            List<Order> orders = orderDAO.getOrdersByUserIdAndStatus(userId, statusId);
            request.setAttribute("orders", orders);
            // ✅ Debug: Check the retrieved orders
            System.out.println("Orders for User ID " + userId + ": " + orders.size());
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
        }
        if (statusId == 3) {
            List<Order> orders = orderDAO.getOrdersByUserIdAndStatus(userId, statusId);
            request.setAttribute("orders", orders);
            // ✅ Debug: Check the retrieved orders
            System.out.println("Orders for User ID " + userId + ": " + orders.size());
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
        }
        if (statusId == 4) {
            List<Order> orders = orderDAO.getOrdersByUserIdAndStatus(userId, statusId);
            request.setAttribute("orders", orders);
            // ✅ Debug: Check the retrieved orders
            System.out.println("Orders for User ID " + userId + ": " + orders.size());
            request.getRequestDispatcher("views/User/order-history.jsp").forward(request, response);
        }

        // ✅ Fetch list of orders for the logged-in user
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

    }

}
