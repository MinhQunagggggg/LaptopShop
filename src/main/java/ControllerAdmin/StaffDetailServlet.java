package ControllerAdmin;

import DAOAdmin.UserDAO;
import modelAdmin.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/staff-detail")
public class StaffDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        UserDAO dao = new UserDAO();
        User staff = dao.getStaffById(userId);

        if (staff != null) {
            request.setAttribute("staff", staff);
            request.getRequestDispatcher("views/Admin/staffDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("staff-list");
        }
    }
}
