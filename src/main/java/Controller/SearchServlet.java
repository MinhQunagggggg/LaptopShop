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
        String txtSearch = request.getParameter("query");
        System.out.println("📩 Received search request: " + txtSearch); // ✅ Kiểm tra log

        if (txtSearch == null || txtSearch.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.searchProducts(txtSearch);

        System.out.println("🔎 Found " + products.size() + " results"); // ✅ Kiểm tra số lượng sản phẩm tìm thấy

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (products.isEmpty()) {
            out.println("<p class='text-center text-muted'>No products found.</p>");
        } else {
            for (Product product : products) {
                out.println("<div class='col-md-3 product-item'>");
                out.println("<a href='ProductDetail?id=" + product.getId() + "' class='text-decoration-none'>");
                out.println("<div class='card'>");
                out.println("<img class='card-img-top' src='assets/img/" + product.getImageUrl() + "' alt='" + product.getName() + "'>");
                out.println("<div class='card-body text-center'>");
                out.println("<h5>" + product.getName() + "</h5>");
                out.println("<p class='text-success fw-bold'>" + String.format("%,.2f", product.getPrice()) + " VND</p>");
                out.println("</div></div></a></div>");
            }
        }
    }
}

