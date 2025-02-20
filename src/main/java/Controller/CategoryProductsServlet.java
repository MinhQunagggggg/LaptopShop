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
@WebServlet(name="CategoryProductsServlet", urlPatterns={"/CategoryProducts"})
public class CategoryProductsServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String categoryName = request.getParameter("category");

        // ✅ Kiểm tra nếu không có danh mục, quay về trang chủ
        if (categoryName == null || categoryName.trim().isEmpty()) {
            response.sendRedirect("Home");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getProductsByCategories(categoryName); // 🔹 Lấy dữ liệu từ DB

        // ✅ Debug kiểm tra dữ liệu
        System.out.println("Category: " + categoryName);
        System.out.println("Products found: " + products.size());

        // ✅ Gửi dữ liệu về JSP
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("products", products);

        request.getRequestDispatcher("views/User/category-products.jsp").forward(request, response);
    }
}
