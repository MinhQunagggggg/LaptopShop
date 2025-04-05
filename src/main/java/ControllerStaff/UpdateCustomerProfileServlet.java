package ControllerStaff;

import DAO_Staff.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/UpdateCustomerProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateCustomerProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // Lấy ảnh đại diện từ form nếu có
        Part filePart = request.getPart("avatar"); // Nhận file từ form
        byte[] avatarData = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Chuyển file ảnh thành mảng byte (byte[])
            try (InputStream inputStream = filePart.getInputStream();
                 ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {
                
                byte[] buffer = new byte[1024];
                int bytesRead;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    byteArrayOutputStream.write(buffer, 0, bytesRead);
                }

                avatarData = byteArrayOutputStream.toByteArray();  // Lấy mảng byte chứa dữ liệu ảnh
                System.out.println("Avatar uploaded, size: " + avatarData.length + " bytes");
            } catch (IOException e) {
                // Xử lý lỗi khi đọc file
                System.err.println("Error reading avatar file: " + e.getMessage());
            }
        } else {
            System.out.println("No new avatar uploaded.");
        }

        // Tạo đối tượng CustomerDAO và thực hiện cập nhật thông tin
        CustomerDAO customerDAO = new CustomerDAO();
        boolean success = customerDAO.updateCustomerInfo(userId, name, phone, email, address, avatarData);

        // Kiểm tra kết quả cập nhật
        if (success) {
            response.sendRedirect("CustomerList"); // Điều hướng đến danh sách khách hàng
        } else {
            // Nếu cập nhật thất bại, trả về thông báo lỗi
            response.sendRedirect("error.jsp?message=Update failed");
        }
    }
}
