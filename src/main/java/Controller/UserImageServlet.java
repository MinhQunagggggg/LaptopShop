package Controller;

import DAO.UserDAO;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "UserImageServlet", urlPatterns = {"/UserImage"})
public class UserImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            System.out.println("[DEBUG] Received request for UserImage with ID: " + idParam);

            if (idParam == null || idParam.isEmpty()) {
                System.out.println("[ERROR] Missing or empty 'id' parameter.");
                response.sendRedirect(request.getContextPath() + "/assets/img/user.png");
                return;
            }

            int userId = Integer.parseInt(idParam);
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);

            if (user != null) {
                System.out.println("[DEBUG] User found: " + user.getUsername());

                byte[] imageData = user.getAvatarData();
                if (imageData != null && imageData.length > 0) {
                    System.out.println("[DEBUG] Sending image for user ID: " + userId + " | Image Size: " + imageData.length + " bytes");
                    
                    response.setContentType("image/jpeg");

                    OutputStream out = response.getOutputStream();
                    out.write(imageData);
                    out.flush();
                    out.close();
                    return;
                } else {
                    System.out.println("[WARNING] No avatar image found for user ID: " + userId);
                }
            } else {
                System.out.println("[WARNING] No user found for ID: " + userId);
            }

            // Nếu không tìm thấy hình ảnh, chuyển hướng đến ảnh mặc định
            response.sendRedirect(request.getContextPath() + "/assets/img/user.png");

        } catch (NumberFormatException e) {
            System.out.println("[ERROR] Invalid user ID format: " + request.getParameter("id"));
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/assets/img/user.png");
        } catch (Exception e) {
            System.out.println("[ERROR] Exception occurred while processing user image request.");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/assets/img/user.png");
        }
    }
}
