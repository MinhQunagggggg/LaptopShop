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
        int warrantyId = Integer.parseInt(request.getParameter("warranty_id"));
        int statusId = Integer.parseInt(request.getParameter("status_id"));

        WarrantyDAO warrantyDAO = new WarrantyDAO();
        warrantyDAO.updateWarrantyStatus(statusId, warrantyId);
        
        response.sendRedirect("ViewWarrantyServelet");
    }
}

