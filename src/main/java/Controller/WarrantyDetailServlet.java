/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.WarrantyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import model.WarrantyItem;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "WarrantyDetailServlet", urlPatterns = {"/WarrantyDetail"})
public class WarrantyDetailServlet extends HttpServlet {
private WarrantyDAO warrantyDAO;

    public void init() throws ServletException {
        warrantyDAO = new WarrantyDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get the order detail ID from the request
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("WarrantyInfo");
                return;
            }

            int orderDetailId = Integer.parseInt(idStr);
            
            // Get warranty details from DAO
            WarrantyItem warrantyDetail = warrantyDAO.getWarrantyDetail(orderDetailId);
            
            // Set attributes for JSP
            request.setAttribute("warrantyDetail", warrantyDetail);
            request.setAttribute("currentDate", new Date()); // For status comparison
            
            // Forward to JSP
            request.getRequestDispatcher("views/User/warranty_detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("WarrantyInfo");
        } catch (Exception e) {
            throw new ServletException("Error retrieving warranty details", e);
        }
    }
}
