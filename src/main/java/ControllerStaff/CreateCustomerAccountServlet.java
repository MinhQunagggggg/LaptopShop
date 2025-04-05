package ControllerStaff;


import DAO_Staff.CustomerDAO;
import Model_Staff.User;
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
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/CreateCustomerAccountServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class CreateCustomerAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/Staff/createCustomerAccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra password có khớp nhau
        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/views/Staff/createCustomerAccount.jsp").forward(request, response);
            return;
        }

        // Xử lý file avatar (nếu có)
        Part filePart = request.getPart("avatar");
        byte[] avatarData = null;
        if (filePart != null && filePart.getSize() > 0) {
            avatarData = convertInputStreamToByteArray(filePart.getInputStream());
            System.out.println("Avatar uploaded, size: " + avatarData.length + " bytes");
        }

        // Hash password trước khi lưu (ví dụ dùng MD5)
        String hashedPassword = hashPassword(password);

        // Tạo đối tượng User
        User newUser = new User();
        newUser.setName(name);
        newUser.setPhone(phone);
        newUser.setEmail(email);
        newUser.setAddress(address);
        newUser.setUsername(username);
        newUser.setPassword(hashedPassword); // password đã được băm
        newUser.setAvatarUrl(avatarData);

        // Gọi DAO để xử lý
        CustomerDAO customerDAO = new CustomerDAO();
        CreateUserStatus status = customerDAO.createCustomer(newUser);

        // Dựa theo enum trả về, hiển thị kết quả
        switch (status) {
            case SUCCESS:
                // Tạo thành công => chuyển đến trang danh sách
                response.sendRedirect("CustomerList");
                break;
            case USERNAME_EXISTS:
                request.setAttribute("errorMessageusername", "Username already exists. Please choose another.");
                request.getRequestDispatcher("/views/Staff/createCustomerAccount.jsp").forward(request, response);
                break;
            case EMAIL_EXISTS:
                request.setAttribute("errorMessageemail", "Email already exists. Please use another.");
                request.getRequestDispatcher("/views/Staff/createCustomerAccount.jsp").forward(request, response);
                break;
            default: // FAIL
                request.setAttribute("errorMessage", "An error occurred while creating the account.");
                request.getRequestDispatcher("/views/Staff/createCustomerAccount.jsp").forward(request, response);
                break;
        }
    }

    // Hàm chuyển InputStream thành mảng byte
    private byte[] convertInputStreamToByteArray(InputStream inputStream) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            byteArrayOutputStream.write(buffer, 0, bytesRead);
        }
        return byteArrayOutputStream.toByteArray();
    }

    // Hàm hash password bằng MD5 (chỉ là ví dụ, bạn nên cân nhắc dùng các phương pháp an toàn hơn)
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            byte[] hashBytes = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
