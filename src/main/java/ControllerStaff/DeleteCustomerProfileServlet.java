/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package ControllerStaff;

import DAO_Staff.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet("/DeleteCustomerProfile")
public class DeleteCustomerProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        
        if (userId != null && !userId.isEmpty()) {
            try {
                int id = Integer.parseInt(userId);
                CustomerDAO customerDAO = new CustomerDAO();
                boolean isDeleted = customerDAO.deleteCustomerById(id);
                
                HttpSession session = request.getSession();
                if (isDeleted) {
                    session.setAttribute("message", "Hồ sơ khách hàng đã được xóa thành công.");
                } else {
                    session.setAttribute("error", "Không thể xóa hồ sơ khách hàng. Vui lòng thử lại sau.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "ID khách hàng không hợp lệ.");
            }
        } else {
            request.getSession().setAttribute("error", "Thiếu ID khách hàng.");
        }
        
        response.sendRedirect("CustomerList");
    }
}
