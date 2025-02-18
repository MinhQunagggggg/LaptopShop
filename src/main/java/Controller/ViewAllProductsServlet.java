/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.ProductDAO;
import java.io.IOException;

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
@WebServlet(name = "ViewAllProductsServlet", urlPatterns = {"/ViewAllProducts"})
public class ViewAllProductsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        String brand = request.getParameter("brand");

        if (brand == null || brand.isEmpty()) {
            response.sendRedirect("Home"); // Quay về trang chủ nếu thiếu thương hiệu
            return;
        }

        int page = 1;
        int pageSize = 8;  // Hiển thị 8 sản phẩm mỗi trang

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Product> products = productDAO.getProductsByBrandWithPagination(brand, page, pageSize);
        int totalProducts = productDAO.getTotalProductsByBrand(brand);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        request.getRequestDispatcher("views/viewAllProductsInBrand.jsp").forward(request, response);
    }
}

