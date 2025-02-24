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

@WebServlet("/updateProduct")
public class UpdateProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");

        // Kiểm tra nếu productId không hợp lệ
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
        ProductVariant variant = variantDAO.getVariantByProductId(productId);

        request.setAttribute("specification", specification);
        request.setAttribute("variant", variant);
        request.setAttribute("productId", productId);
        request.getRequestDispatcher("views/Admin/update_laptop.jsp").forward(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");

    String productIdStr = request.getParameter("productId");

    // Kiểm tra nếu productIdStr null hoặc rỗng
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
        request.getParameter("ram"),
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
    specDAO.updateSpecification(specification);

    // Cập nhật biến thể sản phẩm
    ProductVariant variant = new ProductVariant(
        productId,
        Double.parseDouble(request.getParameter("price")),
        Integer.parseInt(request.getParameter("stock"))
    );
    variantDAO.updateVariant(variant);

    response.sendRedirect("list-products?success=productUpdated");
}

}
