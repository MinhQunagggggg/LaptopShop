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
import java.io.OutputStream;
import model.Product;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "ProductImageServlet", urlPatterns = {"/ProductImage"})
public class ProductImageServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    try {
        int productId = Integer.parseInt(request.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductInfo(productId);

        if (product != null && product.getImageData() != null) {
            byte[] imageData = product.getImageData();
            
            // ✅ In ra log để kiểm tra dữ liệu ảnh có tồn tại không
            System.out.println("Product ID: " + productId + " | Image Size: " + imageData.length + " bytes");

            response.setContentType("image/jpeg"); // Định dạng ảnh
            
            // ✅ Gửi dữ liệu ảnh về trình duyệt
            OutputStream out = response.getOutputStream();
            out.write(imageData);
            out.flush();
            out.close();
        } else {
            System.out.println("No image found for product ID: " + productId);
            response.sendRedirect(request.getContextPath() + "/assets/img/default-product.jpg");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/assets/img/default-product.jpg");
    }
}

}
