package ControllerStaff;

import DAO_Staff.CustomerDAO;
import Model_Staff.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CustomerProfileDetail")
public class ViewProfileCustomerDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Xử lý POST từ form hoặc yêu cầu gửi userId
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userIdParam = request.getParameter("userId");

        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=User ID is required");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdParam);
            // Lưu userId vào session thay vì truyền qua URL
            session.setAttribute("selectedUserId", userId);
            // Chuyển hướng đến doGet để xử lý logic hiển thị
            response.sendRedirect("CustomerProfileDetail");
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid user ID format");
        }
    }

    // Xử lý GET để hiển thị trang chi tiết
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("selectedUserId");

        // Kiểm tra xem userId có trong session không
        if (userId == null) {
            response.sendRedirect("error.jsp?message=User ID is missing in session");
            return;
        }

        try {
            CustomerDAO customerDAO = new CustomerDAO();
            User customer = customerDAO.getCustomerById(userId);

            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("views/Staff/viewProfileCustomerDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=Customer not found");
            }
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
            e.printStackTrace();
        }
    }
}