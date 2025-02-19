/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.User;
import model.Product;
import DAO.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author CE182250
 */
@WebServlet(name="HomeServlet", urlPatterns={"/Home"})
public class HomeServlet extends HttpServlet {
  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<String> brands = productDAO.getAllBrands(); 
        
        List<List<Product>> brandProducts = new ArrayList<>();
        for (String brand : brands) {
            List<Product> products = productDAO.getProductsByBrand(brand);
            brandProducts.add(products);
        }

        request.setAttribute("brands", brands);
        request.setAttribute("brandProducts", brandProducts);
        request.getRequestDispatcher("views/User/Home.jsp").forward(request, response);
    }
}

