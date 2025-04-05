package ControllerAdmin;

import DAOAdmin.ProductDAO;

import DAOAdmin.ProductVariantDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelAdmin.ProductAdmin;
import modelAdmin.ProductVariant;

@WebServlet("/list-products")
public class ListProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private ProductVariantDAO variantDAO = new ProductVariantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy danh sách sản phẩm và variant
        List<ProductAdmin> productList = productDAO.getAllProductsMNgoc();
        List<ProductVariant> variantList = variantDAO.getAllVariants();

        // Đặt dữ liệu vào request attributes
        request.setAttribute("productList", productList);
        request.setAttribute("variantList", variantList);

        // Forward đến JSP
        request.getRequestDispatcher("views/Admin/list_products.jsp").forward(request, response);
    }
}

