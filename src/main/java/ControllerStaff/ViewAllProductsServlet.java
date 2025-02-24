package ControllerStaff;

import DAO_Staff.ProductDAO;
import java.io.IOException;
import java.util.*;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

/**
 *
 * @author PC
 */
@WebServlet(name="ViewAllProductsServlet", urlPatterns={"/ViewProducts"})
public class ViewAllProductsServlet extends HttpServlet {
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();

        // ✅ Lấy tất cả sản phẩm từ database
        List<Product> products = productDAO.getAllProducts2();

        // ✅ Chuyển đổi `byte[]` thành Base64 để gửi đến JSP
        List<Map<String, String>> productList = new ArrayList<>();
        for (Product product : products) {
            Map<String, String> productMap = new HashMap<>();
            productMap.put("id", String.valueOf(product.getId()));
            productMap.put("name", product.getName());
            productMap.put("description", product.getDescription());
            productMap.put("price", String.valueOf(product.getPrice()));

            // ✅ Chuyển đổi ảnh sang Base64 nếu có
            byte[] imageData = product.getImageData();
            if (imageData != null) {
                String base64Image = Base64.getEncoder().encodeToString(imageData);
                productMap.put("imageUrl", "data:image/png;base64," + base64Image);
            } else {
                productMap.put("imageUrl", request.getContextPath() + "/images/default-product.jpg");
            }

            productList.add(productMap);
        }

        // ✅ Gửi danh sách sản phẩm đã xử lý về JSP
        request.setAttribute("products", productList);
        request.setAttribute("pageTitle", "All Products");

        // ✅ Forward đến `viewProducts.jsp`
        request.getRequestDispatcher("views/Staff/viewProducts.jsp").forward(request, response);
    }
}
