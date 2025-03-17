package ControllerAdmin;

import DAOAdmin.ProductDAO;
import modelAdmin.ProductAdmin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/imageServlet")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        ProductDAO productDAO = new ProductDAO();
        ProductAdmin product = productDAO.getProductById(productId);

        byte[] imageData = product.getImageData();
        if (imageData != null) {
            response.setContentType("image/jpeg");
            OutputStream out = response.getOutputStream();
            out.write(imageData);
            out.close();
        }
    }
}
