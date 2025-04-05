/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ControllerStaff;


import DAO_Staff.WarrantyDAO;
import Model_Staff.Warranty;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author PC
 */
@WebServlet(name = "ViewWarrantyServelet", urlPatterns = {"/ViewWarranty"})
public class ViewWarrantyServelet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Tạo đối tượng WarrantyDAO để lấy danh sách bảo hành
        WarrantyDAO warrantyDAO = new WarrantyDAO();
        List<Warranty> warranties = warrantyDAO.getAllWarranties();
        
        // Kiểm tra xem danh sách warranties có null không
        if (warranties == null) {
            System.out.println("No warranties found.");
        } else {
            System.out.println("Number of warranties: " + warranties.size());
        }

        // Đưa danh sách bảo hành vào request để truyền đến JSP
        request.setAttribute("warranties", warranties);

        // Chuyển hướng đến trang JSP để hiển thị
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Staff/viewWarrantyList.jsp");
        dispatcher.forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // ✅ Lấy từ khóa tìm kiếm từ form
        String keyword = request.getParameter("search");

        // Tạo đối tượng WarrantyDAO để tìm kiếm bảo hành
        WarrantyDAO warrantyDAO = new WarrantyDAO();
        List<Warranty> warranties;

        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                // ✅ Nếu có từ khóa → thực hiện tìm kiếm
                warranties = warrantyDAO.searchWarranty(keyword);
            } else {
                // ✅ Nếu không có từ khóa → lấy tất cả bảo hành
                warranties = warrantyDAO.getAllWarranties();
            }

            // Kiểm tra kết quả tìm kiếm
            if (warranties == null || warranties.isEmpty()) {
                request.setAttribute("error", "Không tìm thấy bảo hành nào.");
            } else {
                request.setAttribute("warranties", warranties);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình tìm kiếm.");
        }

        // ✅ Chuyển hướng đến JSP để hiển thị kết quả
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Staff/viewWarrantyList.jsp");
        dispatcher.forward(request, response);
    }

}


