package ControllerAdmin;

import DAOAdmin.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelAdmin.ProductAdmin;
import model.Product;

@WebServlet("/list-products")
public class ListProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<ProductAdmin> productList = productDAO.getAllProductsMNgoc();
        
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("views/Admin/list_products.jsp").forward(request, response);
    }
}
