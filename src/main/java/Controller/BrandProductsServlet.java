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
@WebServlet(name = "BrandProductsServlet", urlPatterns = {"/BrandProducts"})
public class BrandProductsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String brandName = request.getParameter("brand");

        if (brandName == null || brandName.isEmpty()) {
            response.sendRedirect("Home");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getProductsByBrand(brandName);

        request.setAttribute("brandName", brandName);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/views/User/brand-products.jsp").forward(request, response);
    }
}