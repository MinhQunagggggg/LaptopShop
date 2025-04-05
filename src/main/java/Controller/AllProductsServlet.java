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
@WebServlet(name = "AllProductsServlet", urlPatterns = {"/AllProducts"})
public class AllProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();

        // ✅ Lấy tất cả sản phẩm từ database
        List<Product> allProducts = productDAO.getAllProducts();

        // ✅ Gửi danh sách sản phẩm về JSP
        request.setAttribute("allProducts", allProducts);
        request.setAttribute("pageTitle", "All Products");

        // ✅ Forward đến trang `all-products.jsp`
        request.getRequestDispatcher("views/User/all-products.jsp").forward(request, response);
    }
}