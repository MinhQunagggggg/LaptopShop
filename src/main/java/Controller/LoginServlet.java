package Controller;

import DAO.CartDAO;
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
        CartDAO cartDao = new CartDAO();
        if (user != null) {
            switch (user.getRole_id()) {
                case 1: {
                    HttpSession session = request.getSession();
                    int cartSize = cartDao.getCartSize(user.getId());
                    session.setAttribute("cartSize", cartSize);
                    session.setAttribute("user", user);
                    response.sendRedirect(request.getContextPath() + "/Home");
                    break;
                }
                case 2: {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    response.sendRedirect(request.getContextPath() + "/statistics");
                    break;
                }
                default: {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    response.sendRedirect(request.getContextPath() + "/Dashboard");
                    break;
                }
            }

        } else {
            request.setAttribute("errorMessage", "Incorrect username or password!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/User/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
