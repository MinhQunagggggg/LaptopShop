/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ControllerStaff;

import DAO_Staff.CustomerDAO;
import DAO_Staff.OrderDAO;
import DAO_Staff.ProductDAO;
import DAO_Staff.WarrantyDAO;
import Model_Staff.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * @author PC
 */
@WebServlet(name = "DashboardSevlet", urlPatterns = {"/Dashboard"})
public class DashboardServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ DAO (bạn sẽ triển khai các phương thức này)
        ProductDAO productDAO = new ProductDAO();
        int totalProducts = productDAO.getTotalProducts();
        int lowStockProducts = productDAO.getLowStockProducts();
        CustomerDAO customerDAO = new CustomerDAO();
        int totalCustomers = customerDAO.getTotalCustomers();
        OrderDAO orderDAO = new OrderDAO();
        int todayOrders = orderDAO.getTodayOrders();
        double todayRevenue = orderDAO.getTodayRevenue();
        WarrantyDAO warrantyDAO = new WarrantyDAO();
        int pendingWarranty = warrantyDAO.getPendingWarranty();
        List<Order> listorder = orderDAO.getAllOrders();

        List<Map<String, Object>> weeklyOrders = orderDAO.getWeeklyOrders(); // Lấy số lượng đơn hàng
        List<Map<String, Object>> weeklyRevenue = orderDAO.getWeeklyRevenue(); // Lấy doanh thu
        System.out.println("Weekly Orders1: " + weeklyOrders);
        System.out.println("Weekly Revenue1: " + weeklyRevenue);

        // Đặt các thuộc tính vào request để JSP sử dụng
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("todayOrders", todayOrders);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("pendingWarranty", pendingWarranty);
        request.setAttribute("listorder", listorder);
        request.setAttribute("weeklyOrders", weeklyOrders);
        request.setAttribute("weeklyRevenue", weeklyRevenue);
        request.getRequestDispatcher("/views/Staff/dashBoard.jsp").forward(request, response);
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
        processRequest(request, response);
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

    private void processRequest(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
