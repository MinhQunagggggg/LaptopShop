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
        String subBrandName = request.getParameter("subbrand");

        // ✅ Kiểm tra nếu brandName bị null, quay về trang chủ
        if (brandName == null || brandName.trim().isEmpty()) {
            response.sendRedirect("Home");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> products;

        if (subBrandName != null && !subBrandName.trim().isEmpty()) {
            // ✅ Nếu có SubBrand, lấy sản phẩm theo SubBrand
            products = productDAO.getProductsBySubBrand(subBrandName);
            request.setAttribute("pageTitle", "All Products of " + subBrandName);
        } else {
            // ✅ Nếu chỉ có Brand, lấy sản phẩm theo Brand
            products = productDAO.getProductsByBrand(brandName);
            request.setAttribute("pageTitle", "All Products of " + brandName);
        }

        // 🔹 Nếu brand là Lenovo, lấy danh sách SubBrands
        List<String> subBrandsOfLenovo = productDAO.getSubBrandsByBrand("Lenovo");

        // ✅ Gửi dữ liệu về JSP
        request.setAttribute("brandName", brandName);
        request.setAttribute("subBrandName", subBrandName);
        request.setAttribute("products", products);
        request.setAttribute("subBrandsOfLenovo", subBrandsOfLenovo); // ✅ Thêm danh sách SubBrands

        request.getRequestDispatcher("views/User/brand-products.jsp").forward(request, response);
    }
}
