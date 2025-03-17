package Controller;

import DAO.UserDAO;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "UpdateImageServlet", urlPatterns = {"/UpdateImage"})
@MultipartConfig(maxFileSize = 16177215) // Giới hạn kích thước file (16MB)
public class UpdateImageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Debug: Bắt đầu xử lý request
            System.out.println("UpdateImageServlet: Bắt đầu xử lý yêu cầu cập nhật ảnh");

            // Lấy userId từ session hoặc request
            String userIdParam = request.getParameter("user_id");
            System.out.println("User ID nhận được: " + userIdParam);

            if (userIdParam == null || userIdParam.isEmpty()) {
                System.out.println("Lỗi: Thiếu user_id");
                response.sendRedirect("EditProfile?error=missing_user_id");
                return;
            }
            int userId = Integer.parseInt(userIdParam);

            // Xử lý file ảnh từ form
            Part filePart = request.getPart("avatar_data");
            if (filePart == null || filePart.getSize() == 0) {
                System.out.println("Lỗi: Không có file ảnh được tải lên");
                response.sendRedirect("EditProfile?error=no_image_uploaded");
                return;
            }

            System.out.println("Tên file: " + filePart.getSubmittedFileName());
            System.out.println("Kích thước file: " + filePart.getSize());

            InputStream inputStream = filePart.getInputStream();
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            byte[] data = new byte[1024];
            int nRead;
            while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }
            byte[] imageData = buffer.toByteArray();

            System.out.println("Kích thước dữ liệu ảnh sau khi đọc: " + imageData.length + " bytes");

            // Cập nhật avatar trong CSDL qua UserDAO
            UserDAO dao = new UserDAO();
            boolean isUpdated = dao.updateImage(userId, imageData);

            // Debug: Kết quả cập nhật
            if (isUpdated) {
                System.out.println("Cập nhật ảnh thành công cho user_id: " + userId);
                response.sendRedirect("EditProfile?success=true");
            } else {
                System.out.println("Lỗi: Cập nhật ảnh thất bại trong CSDL");
                response.sendRedirect("EditProfile?error=update_failed");
            }
        } catch (NumberFormatException e) {
            System.out.println("Lỗi: user_id không hợp lệ");
            e.printStackTrace();
            response.sendRedirect("EditProfile?error=invalid_user_id");
        } catch (Exception e) {
            System.out.println("Lỗi: Lỗi server khi cập nhật ảnh");
            e.printStackTrace();
            response.sendRedirect("EditProfile?error=server_error");
        }
    }
}
