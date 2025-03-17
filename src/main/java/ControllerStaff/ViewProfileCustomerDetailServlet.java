package ControllerStaff;

import DAO_Staff.CustomerDAO;
import Model_Staff.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CustomerProfileDetail")
public class ViewProfileCustomerDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        
        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=User ID is required");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdParam);
            CustomerDAO customerDAO = new CustomerDAO();
            User customer = customerDAO.getCustomerById(userId);
            
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("views/Staff/viewProfileCustomerDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=Customer not found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid user ID format");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
            e.printStackTrace();
        }
    }
}
