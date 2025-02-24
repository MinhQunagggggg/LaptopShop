package ControllerAdmin;

import DAOAdmin.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import modelAdmin.ProductAdmin;
import java.io.IOException;
import java.io.InputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;

@WebServlet("/EditProductServlet")
@MultipartConfig(maxFileSize = 16177215) // Giới hạn file upload (16MB)
public class EditProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");

        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr.trim());
                ProductAdmin product = productDAO.getProductById(productId);
                if (product != null) {
                    request.setAttribute("product", product);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("views/Admin/edit_product.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Invalid product ID format.");
            }
        } else {
            request.setAttribute("errorMessage", "Product ID is required.");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int subBrandId = Integer.parseInt(request.getParameter("subBrandId"));
            int catalogId = Integer.parseInt(request.getParameter("catalogId"));

            ProductAdmin existingProduct = productDAO.getProductById(productId);

            // Xử lý ảnh (nếu có upload ảnh mới, nếu không giữ ảnh cũ)
            Part filePart = request.getPart("imageData");
            byte[] imageData = null;
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileContent = filePart.getInputStream();
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[1024]; // Đọc từng phần nhỏ 1KB
                while ((nRead = fileContent.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                imageData = buffer.toByteArray();

            } else if (existingProduct != null) {
                imageData = existingProduct.getImageData();
            }

            ProductAdmin product = new ProductAdmin(productId, name, description, categoryId, brandId, subBrandId, catalogId, imageData);
            boolean success = productDAO.updateProduct(product);

            if (success) {
                response.sendRedirect("list-products");
            } else {
                response.sendRedirect("edit_product.jsp?productId=" + productId + "&updateError=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_product.jsp?updateError=true");
        }
    }
}
