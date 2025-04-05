package ControllerStaff;

import DAO_Staff.WarrantyDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateWarrantyStatusServlet", urlPatterns = {"/UpdateWarrantyStatus"})
public class UpdateWarrantyStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int warrantyId = Integer.parseInt(request.getParameter("warranty_id"));
            int statusId = Integer.parseInt(request.getParameter("status_id"));
            int staffId = Integer.parseInt(request.getParameter("staff_id")); // Lấy từ form

            WarrantyDAO warrantyDAO = new WarrantyDAO();
            warrantyDAO.updateWarrantyStatus(warrantyId, statusId, staffId);

            response.sendRedirect("ViewWarrantyServelet");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("ViewWarrantyServelet").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật trạng thái: " + e.getMessage());
            request.getRequestDispatcher("ViewWarrantyServelet").forward(request, response);
        }
    }
}