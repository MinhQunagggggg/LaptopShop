package Controller.User;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/Register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("remake_password");
        // Kiểm tra lỗi nhập liệu
        if (name == null || name.isEmpty() || 
            email == null || email.isEmpty() || 
            phone == null || phone.isEmpty() || 
            username == null || username.isEmpty() || 
            password == null || password.isEmpty() || 
            confirmPassword == null || confirmPassword.isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required!");
            sendBackToRegister(request, response, name, email, phone, username);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            sendBackToRegister(request, response, name, email, phone, username);
            return;
        }

        if (!phone.matches("\\d{10}")) {
            request.setAttribute("errorMessage", "Phone number must be 10 digits.");
            sendBackToRegister(request, response, name, email, phone, username);
            return;
        }

        // Kiểm tra tài khoản đã tồn tại chưa
        UserDAO userDAO = new UserDAO();
        if (userDAO.isUserExists(username, email)) {
            request.setAttribute("errorMessage", "Username or Email already exists!");
            sendBackToRegister(request, response, name, email, phone, username);
            return;
        }

        // Đăng ký tài khoản
        boolean success = userDAO.registerUser(name, email, phone, username, password);

        if (success) {
            response.sendRedirect("views/User/login.jsp?registerSuccess=true");
        } else {
            request.setAttribute("errorMessage", "Registration failed! Please try again.");
            sendBackToRegister(request, response, name, email, phone, username);
        }
    }

    // Trả về `register.jsp` và giữ lại dữ liệu đã nhập
    private void sendBackToRegister(HttpServletRequest request, HttpServletResponse response, 
                                    String name, String email, String phone, String username)
            throws ServletException, IOException {
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("username", username);
        request.getRequestDispatcher("views/User/register.jsp").forward(request, response);
    }
}
