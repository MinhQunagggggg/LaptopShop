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
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Product;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/ProductList"})
public class ProductListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String catalogName = request.getParameter("catalog");

        ProductDAO productDAO = new ProductDAO();
        Map<String, List<Product>> brandProducts = new LinkedHashMap<>();
        List<Product> allProducts = new ArrayList<>();

        boolean hasBrands = productDAO.doesCatalogHaveBrands(catalogName);

        if (catalogName != null && !catalogName.isEmpty()) {
            if (hasBrands) {
                List<String> brands = productDAO.getBrandsByCatalog(catalogName);
                for (String brand : brands) {
                    List<Product> products = productDAO.getProductsByCatalogAndBrand(catalogName, brand);
                    if (!products.isEmpty()) {
                        brandProducts.put(brand, products);
                    }
                }
            } else {
                // Nếu danh mục không có brand, lấy tất cả sản phẩm trong danh mục
                allProducts = productDAO.getProductsByCatalog(catalogName);
            }
        }

        request.setAttribute("catalogName", catalogName);
        request.setAttribute("brandProducts", brandProducts);
        request.setAttribute("allProducts", allProducts); // Gửi danh sách sản phẩm không có brand
        request.setAttribute("hasBrands", hasBrands); // Để kiểm tra hiển thị trong JSP
        request.getRequestDispatcher("/views/User/product-list.jsp").forward(request, response);
    }
}
