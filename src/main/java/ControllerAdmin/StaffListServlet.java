package ControllerAdmin;

import DAOAdmin.UserDAO;
import modelAdmin.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/staff-list")
public class StaffListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        List<User> staffList = dao.getStaffList();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("views/Admin/staffList.jsp").forward(request, response);
    }
}
