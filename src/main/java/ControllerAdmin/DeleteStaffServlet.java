package ControllerAdmin;

import DAOAdmin.UserDAO;
import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete-staff")
public class DeleteStaffServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int userId = Integer.parseInt(idParam);
                UserDAO userDAO = new UserDAO();
                boolean success = userDAO.deleteStaffById(userId);
                if (success) {
                    response.sendRedirect("staff-list?success=true");
                } else {
                    response.sendRedirect("staff-list?error=true");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("staff-list?error=invalid_id");
            }
        } else {
            response.sendRedirect("staff-list?error=missing_id");
        }
    }
}
