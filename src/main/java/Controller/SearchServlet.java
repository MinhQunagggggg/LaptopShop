/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 *
 * @author CE182250
 */

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy từ khóa tìm kiếm từ request
        String txtSearch = request.getParameter("query");

        // Kiểm tra nếu rỗng thì quay lại trang Home
        if (txtSearch == null || txtSearch.trim().isEmpty()) {
            response.sendRedirect("home.jsp");
            return;
        }

        // Truy vấn danh sách sản phẩm khớp với từ khóa
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.searchByName(txtSearch);

        // Gửi danh sách sản phẩm tìm thấy đến home.jsp
        request.setAttribute("products", products);
        request.setAttribute("searchQuery", txtSearch);
        request.getRequestDispatcher("views/User/Home.jsp").forward(request, response);
    }
}

