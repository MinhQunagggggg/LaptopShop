package ControllerAdmin;

import DAOAdmin.ProductSpecificationDAO;
import DAOAdmin.ProductVariantDAO;
import modelAdmin.ProductSpecification;
import modelAdmin.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

@WebServlet("/updateProduct")
public class UpdateProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");

        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing or invalid.");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID must be a valid number.");
            return;
        }

        ProductSpecificationDAO specDAO = new ProductSpecificationDAO();
        ProductVariantDAO variantDAO = new ProductVariantDAO();

        ProductSpecification specification = specDAO.getSpecificationByProductId(productId);

        List<ProductVariant> variants = variantDAO.getVariantsByProductId(productId); // Giả sử có phương thức này

        if (specification == null) {
            request.setAttribute("error", "Không tìm thấy thông số kỹ thuật cho productId: " + productId);
            request.getRequestDispatcher("/views/Admin/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("specification", specification);
        request.setAttribute("variants", variants);
        request.setAttribute("productId", productId);
        request.getRequestDispatcher("/views/Admin/update_laptop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing or invalid.");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID.");
            return;
        }

        ProductSpecificationDAO specDAO = new ProductSpecificationDAO();
        ProductVariantDAO variantDAO = new ProductVariantDAO();

        // Cập nhật thông số kỹ thuật
        ProductSpecification specification = new ProductSpecification(
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
                request.getParameter("refreshRate")
        );
        boolean specUpdated = specDAO.updateSpecification(specification);

        // Cập nhật nhiều biến thể sản phẩm
        List<ProductVariant> variants = new ArrayList<>();
        String[] prices = request.getParameterValues("price");
        String[] stocks = request.getParameterValues("stock");
        String[] rams = request.getParameterValues("ram");

        if (prices != null && stocks != null && rams != null && prices.length == stocks.length && stocks.length == rams.length) {
            for (int i = 0; i < prices.length; i++) {
                try {
                    double price = Double.parseDouble(prices[i]);
                    int stock = Integer.parseInt(stocks[i]);
                    String ram = rams[i] != null && !rams[i].trim().isEmpty() ? rams[i] : "Unknown";

                    ProductVariant variant = new ProductVariant(productId, price, stock, ram);
                    variants.add(variant);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Giá hoặc số lượng tồn kho không hợp lệ ở biến thể thứ " + (i + 1));
                    request.setAttribute("specification", specification);
                    request.setAttribute("variants", variants);
                    request.getRequestDispatcher("/views/Admin/update_product.jsp").forward(request, response);
                    return;
                }
            }
        }

        boolean allVariantsUpdated = true;
        for (ProductVariant variant : variants) {
            if (!variantDAO.updateVariant(variant)) {
                allVariantsUpdated = false;
                break;
            }
        }

        if (specUpdated && allVariantsUpdated) {
            response.sendRedirect("list-products?success=productUpdated");
        } else {
            request.setAttribute("error", "Cập nhật thất bại!");
            request.setAttribute("specification", specification);
            request.setAttribute("variants", variants);
            request.getRequestDispatcher("/views/Admin/update_product.jsp").forward(request, response);
        }
    }
}
