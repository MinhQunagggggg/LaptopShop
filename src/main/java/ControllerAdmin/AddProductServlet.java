package ControllerAdmin;

import DAOAdmin.*;
import modelAdmin.*;
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

@WebServlet("/add-product")
@MultipartConfig(maxFileSize = 16177215)
public class AddProductServlet extends HttpServlet {

    private ProductVariantDAOLT variantDAO;

    @Override
    public void init() {
        variantDAO = new ProductVariantDAOLT();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Bỏ request.setAttribute("variants", variantDAO.getAllVariantsLaptop());
        request.getRequestDispatcher("views/Admin/add_laptop.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {

            String name = request.getParameter("name");
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            int brandId = Integer.parseInt(request.getParameter("brand_id"));

            String subBrandIdStr = request.getParameter("subbrand_id");
            int subBrandId;
            if (brandId == 1) {
                // Nếu brand_id = 1, cho phép nhập subbrand_id bình thường
                subBrandId = (subBrandIdStr != null && !subBrandIdStr.isEmpty()) ? Integer.parseInt(subBrandIdStr) : 0;
            } else {
                // Nếu brand_id khác 1, tự động gán subBrandId = 0 (sẽ ánh xạ thành NULL trong DAO)
                subBrandId = 0;
            }
            int catalogId = Integer.parseInt(request.getParameter("catalog_id"));

            // Xử lý ảnh sản phẩm
            byte[] imageData = null;
            Part filePart = request.getPart("image_data");
            if (filePart != null && filePart.getSize() > 0) {
                try ( InputStream inputStream = filePart.getInputStream();  ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {

                    byte[] data = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(data, 0, data.length)) != -1) {
                        buffer.write(data, 0, bytesRead);
                    }

                    imageData = buffer.toByteArray();
                }

            }

            // Thêm sản phẩm vào DB
            ProductAdmin product = new ProductAdmin(name, description, categoryId, brandId, subBrandId, catalogId, imageData);
            ProductDAO productDAO = new ProductDAO();
            int productId = productDAO.addProductMNgoc(product);

            if (productId == -1) {
                response.sendRedirect("error.jsp");
                return;
            }

            // Phần còn lại của mã giữ nguyên (thêm thông số kỹ thuật, biến thể RAM, v.v.)
            if (catalogId == 1) {
                ProductSpecification spec = new ProductSpecification(
                        productId,
                        request.getParameter("cpu"),
                        request.getParameter("storage"),
                        request.getParameter("resolution"),
                        request.getParameter("graphics"),
                        request.getParameter("ports"),
                        request.getParameter("wireless"),
                        request.getParameter("camera"),
                        request.getParameter("battery"),
                        request.getParameter("dimensions"),
                        request.getParameter("weight"),
                        request.getParameter("keyboard"),
                        request.getParameter("material"),
                        request.getParameter("warranty"),
                        request.getParameter("os"),
                        request.getParameter("condition"),
                        request.getParameter("refresh_rate")
                );
                new ProductSpecificationDAO().addProductSpecification(spec);
            }

            String[] ramValues = request.getParameterValues("ram");
            if (ramValues != null && ramValues.length > 0) {
                int addedCount = 0;
                StringBuilder errors = new StringBuilder();
                for (String ram : ramValues) {
                    String priceStr = request.getParameter("price_" + ram);
                    String stockStr = request.getParameter("stock_" + ram);
                    if (priceStr != null && stockStr != null && !priceStr.trim().isEmpty() && !stockStr.trim().isEmpty()) {
                        try {
                            double price = Double.parseDouble(priceStr);
                            int stock = Integer.parseInt(stockStr);
                            ProductVariant variant = new ProductVariant(productId, price, stock, ram);
                            String result = variantDAO.addVariantLaptop(variant);
                            if (result == null) {
                                addedCount++;
                            } else {
                                errors.append("Error adding ").append(ram).append(": ").append(result).append("<br>");
                            }
                        } catch (NumberFormatException e) {
                            errors.append("Invalid number format for ").append(ram).append(": ").append(e.getMessage()).append("<br>");
                        }
                    } else {
                        errors.append("Missing data for ").append(ram).append("<br>");
                    }
                }
                if (errors.length() > 0) {
                    request.setAttribute("error", errors.toString());
                    request.getRequestDispatcher("views/Admin/add_laptop.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("error", "Please select at least one RAM option.");
                request.getRequestDispatcher("views/Admin/add_laptop.jsp").forward(request, response);
                return;
            }

            response.sendRedirect("list-products");
        } catch (Exception e) {
            log("Unexpected error: " + e.getMessage(), e);
            response.sendRedirect("error.jsp?error=unknown");
        }
    }
}
