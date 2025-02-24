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
@WebServlet(name = "FilterByPriceServlet", urlPatterns = {"/FilterByPrice"})
public class FilterByPriceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nhận giá trị minPrice và maxPrice từ request
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");

        double minPrice = (minPriceParam != null) ? Double.parseDouble(minPriceParam) : 20000000;
        double maxPrice = (maxPriceParam != null) ? Double.parseDouble(maxPriceParam) : 30000000;

        // Gọi DAO để lấy sản phẩm theo khoảng giá
        ProductDAO productDAO = new ProductDAO();
        List<Product> filteredProducts = productDAO.getProductsByPriceRange(minPrice, maxPrice);

        // Gửi danh sách sản phẩm đã lọc về JSP để hiển thị
        request.setAttribute("products", filteredProducts);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);

        request.getRequestDispatcher("views/User/filter-by-price.jsp").forward(request, response);
    }
}