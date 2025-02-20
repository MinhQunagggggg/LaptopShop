package Controller.User;

import DAO.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/User/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            // Kiểm tra role của user
            int role = user.getRole_id(); // Giả sử User có phương thức getRole()

            if (role == 1) {
                response.sendRedirect(request.getContextPath() + "/Home"); // Người dùng bình thường
            } else if (role == 2 || role == 3) {
                response.sendRedirect(request.getContextPath() + "/Dashboard"); // Quản trị viên
            } else {
                request.setAttribute("errorMessage", "Invalid role. Contact support!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/User/login.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Incorrect username or password!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/User/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
