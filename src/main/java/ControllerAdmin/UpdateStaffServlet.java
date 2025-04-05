package ControllerAdmin;

import DAOAdmin.UserDAO;
import modelAdmin.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet xử lý cập nhật thông tin nhân viên
 */
@WebServlet("/update-staff")
public class UpdateStaffServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId;
        try {
            userId = Integer.parseInt(request.getParameter("id")); // Lấy "id" từ URL
        } catch (NumberFormatException e) {
            response.sendRedirect("views/Admin/staff-list.jsp");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getStaffById(userId);

        if (user == null) {
            response.sendRedirect("views/Admin/staff-list.jsp");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("views/Admin/update-staff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String avatarUrl = request.getParameter("avatar_url");

            // Kiểm tra dữ liệu không rỗng
            if (name == null || name.isEmpty() || phone == null || phone.isEmpty() || email == null || email.isEmpty()) {
                response.sendRedirect("update-staff.jsp?userId=" + userId + "&error=missing_fields");
                return;
            }

            User user = new User(userId, name, null, phone, email, 3, null, avatarUrl);
            boolean isUpdated = userDAO.updateStaffById(user);

            if (isUpdated) {
                response.sendRedirect("staff-list?update=success");
            } else {
                response.sendRedirect("update-staff.jsp?userId=" + userId + "&error=update_failed");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("update-staff.jsp?error=invalid_number");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
