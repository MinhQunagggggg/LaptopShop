package Controller;

import DAO.WarrantyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.User;

@WebServlet(name = "SubmitRepairRequestServlet", urlPatterns = {"/SubmitRepairRequest"})
public class SubmitRepairRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("SubmitRepairRequestServlet: Received POST request.");

            // Lấy dữ liệu từ form
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                System.out.println("User not found in session.");
                request.setAttribute("errorMessage", "User not logged in.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            System.out.println("User ID: " + user.getId());

            String orderDetailId = request.getParameter("orderDetailId");
            String customerName = request.getParameter("customerName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String repairLocation = request.getParameter("repairLocation");
            String repairReason = request.getParameter("repairReason");

            // In ra giá trị các tham số để kiểm tra
            System.out.println("Received parameters:");
            System.out.println("orderDetailId: " + orderDetailId);
            System.out.println("customerName: " + customerName);
            System.out.println("phone: " + phone);
            System.out.println("address: " + address);
            System.out.println("repairLocation: " + repairLocation);
            System.out.println("repairReason: " + repairReason);

            // Kiểm tra dữ liệu không rỗng
            if (orderDetailId == null || customerName == null || phone == null || address == null
                    || repairLocation == null || repairReason == null
                    || orderDetailId.trim().isEmpty() || customerName.trim().isEmpty() || phone.trim().isEmpty()
                    || address.trim().isEmpty() || repairLocation.trim().isEmpty() || repairReason.trim().isEmpty()) {
                System.out.println("Validation failed: Some fields are empty.");
                request.setAttribute("errorMessage", "All fields are required.");
                request.getRequestDispatcher("/WarrantyDetail?id=" + orderDetailId).forward(request, response);
                return;
            }

            WarrantyDAO warrantyDAO = new WarrantyDAO();
            int userId = user.getId();

            // Lấy thời gian thực tại khi gửi yêu cầu
            LocalDateTime requestTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedTime = requestTime.format(formatter);

            System.out.println("Request Time: " + formattedTime);

// Truyền thêm thời gian vào hàm lưu yêu cầu sửa chữa
            boolean isSaved = warrantyDAO.saveRepairRequest(orderDetailId, customerName, phone, address, repairLocation, repairReason, formattedTime);
            System.out.println("Repair request save status: " + isSaved);

            if (isSaved) {
                System.out.println("Repair request submitted successfully.");
                request.setAttribute("successMessage", "Repair request submitted successfully!");
            } else {
                System.out.println("Failed to submit repair request.");
                request.setAttribute("errorMessage", "Failed to submit repair request. Please try again.");
            }

// Đặt thông báo vào session
            request.getSession().setAttribute("successMessage", "Update successful!");

// Chuyển hướng đến WarrantyDetail servlet
            response.sendRedirect("WarrantyDetail?id=" + orderDetailId);

        } catch (Exception e) {
            System.out.println("Exception occurred: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WarrantyInfo").forward(request, response);
        }
    }
}
