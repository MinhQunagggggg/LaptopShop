package Controller;

import DAO.GoogleloginDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.GoogleAccount;
import model.User;

@WebServlet(name = "GoogleloginServlet", urlPatterns = {"/Googlelogin"})
public class GoogleloginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get authorization code from Google
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            response.getWriter().println("Authorization code is missing.");
            return;
        }

        // Initialize DAO
        GoogleloginDAO gg = new GoogleloginDAO();

        // Retrieve access token from authorization code
        String accessToken = gg.getToken(code);
        if (accessToken == null) {
            response.getWriter().println("Failed to retrieve access token.");
            return;
        }

        // Fetch user account details from Google
        GoogleAccount acc = gg.getUserInfo(accessToken);
        if (acc == null) {
            response.getWriter().println("Failed to retrieve Google account information.");
            return;
        }

        // Check if the email already exists in the database
        int userId = gg.getUserIdByEmail(acc.getEmail());

        HttpSession session = request.getSession();
        if (userId != -1) {
            User user = gg.getUserById(userId); // Lấy thông tin user từ DB
            session.setAttribute("user", user);
            response.sendRedirect("/Home");
            return; // 🔹 Dừng phương thức sau khi redirect
        }

        // Register new user
        User newUser = gg.registerUser(acc);
        if (newUser != null) {
            session.setAttribute("user", newUser);
            response.sendRedirect("/Home");
            return; // 🔹 Dừng phương thức sau khi redirect
        }

        // Nếu đăng ký thất bại
        response.getWriter().println("Failed to register a new account.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles Google login and user authentication.";
    }
}
