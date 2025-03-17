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
        GoogleloginDAO GoogleloginDAO = new GoogleloginDAO();

        // Retrieve access token from authorization code
        String accessToken = GoogleloginDAO.getToken(code);
        if (accessToken == null) {
            response.getWriter().println("Failed to retrieve access token.");
            return;
        }

        // Fetch user account details from Google
        GoogleAccount acc = GoogleloginDAO.getUserInfo(accessToken);
        if (acc == null) {
            response.getWriter().println("Failed to retrieve Google account information.");
            return;
        }
        System.out.println(acc.getPicture());
        // Check if the email already exists in the database
        int userId = GoogleloginDAO.getUserIdByEmail(acc.getEmail());

        HttpSession session = request.getSession();
        if (userId != -1) {
            User user = GoogleloginDAO.getUserById(userId);
            session.setAttribute("user", user);

            // Xác định URL chuyển hướng
            String redirectURL;
            switch (user.getRole_id()) {
                case 1:
                    redirectURL = "/Home";
                    break;
                case 2:
                    redirectURL = "/list-products";
                    break;
                default:
                    redirectURL = "/Dashboard";
                    break;
            }

            // Chuyển hướng ngay lập tức và kết thúc hàm
            response.sendRedirect(request.getContextPath() + redirectURL);
            return; // 💡 QUAN TRỌNG: Dừng xử lý để tránh gọi forward()
        }

// Nếu user chưa có trong DB, chuyển đến trang đăng ký
        request.setAttribute("email", acc.getEmail());
        request.setAttribute("name", acc.getName());

// 💡 KHÔNG GỌI sendRedirect() sau khi forward
        request.getRequestDispatcher("views/User/register.jsp").forward(request, response);

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
