/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ControllerStaff;

import DAO_Staff.CustomerDAO;
import Model_Staff.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author PC
 */
@WebServlet("/CustomerList")
public class ViewProfileCustomerListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerDAO customerDAO = new CustomerDAO();
        List<User> customers = null;

        try {
            customers = customerDAO.getAllCustomers();
        } catch (Exception e) {
            // Xử lý lỗi nếu có vấn đề khi truy vấn cơ sở dữ liệu
            e.printStackTrace();
            request.setAttribute("error", "Không thể lấy danh sách khách hàng");
        }

        // Gửi danh sách khách hàng đến JSP
        if (customers != null && !customers.isEmpty()) {
            request.setAttribute("customers", customers);
        } else {
            request.setAttribute("error", "Không có dữ liệu khách hàng.");
        }

        request.getRequestDispatcher("views/Staff/viewProfileCustomerList.jsp").forward(request, response);
    }
}
