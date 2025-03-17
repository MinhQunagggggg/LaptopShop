package ControllerAdmin;

import DAOAdmin.MouseDAO;
import DAOAdmin.ProductVariantDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelAdmin.Mouse;
import modelAdmin.ProductVariant;
import java.io.IOException;

@WebServlet("/updateMouse")
public class UpdateMouseServlet extends HttpServlet {

    private MouseDAO mouseDAO = new MouseDAO();
    private ProductVariantDAO variantDAO = new ProductVariantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            Mouse mouse = mouseDAO.getMouseByProductId(productId);
            ProductVariant variant = variantDAO.getVariantByProductId(productId);

            if (mouse == null || variant == null) {
                String errorMessage = mouse == null 
                    ? "Không tìm thấy chuột với productId: " + productId 
                    : "Không tìm thấy biến thể sản phẩm với productId: " + productId;
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("/views/Admin/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("mouse", mouse);
            request.setAttribute("variant", variant);
            request.getRequestDispatcher("/views/Admin/update_mouse.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID sản phẩm không hợp lệ: " + request.getParameter("productId"));
            request.getRequestDispatcher("/views/Admin/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi lấy dữ liệu sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/views/Admin/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            // Lấy dữ liệu từ form cho Mouse
            String brand = request.getParameter("brand");
            int warrantyMonths = Integer.parseInt(request.getParameter("warrantyMonths"));
            String connectionType = request.getParameter("connectionType");
            boolean wired = Boolean.parseBoolean(request.getParameter("wired"));
            int dpi = Integer.parseInt(request.getParameter("dpi"));
            String switchType = request.getParameter("switchType");
            String mouseLed = request.getParameter("mouseLed");
            String color = request.getParameter("color");
            String dimensions = request.getParameter("dimensions");
            float weight = Float.parseFloat(request.getParameter("weight"));

            // Lấy dữ liệu từ form cho ProductVariant
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            // Tạo đối tượng Mouse (không có accessoryBrandId vì không có trong bảng)
            Mouse mouse = new Mouse(0, productId, brand, warrantyMonths, connectionType, wired, dpi, 
                switchType, mouseLed, color, dimensions, weight, null, null, 0, null);

            // Tạo đối tượng ProductVariant
            ProductVariant existingVariant = variantDAO.getVariantByProductId(productId);
            ProductVariant variant = new ProductVariant(productId, price, stock, 
                existingVariant != null ? existingVariant.getRam() : null);

            // Cập nhật database
            boolean mouseUpdated = mouseDAO.updateMouse(mouse);
            boolean variantUpdated = variantDAO.updateVariant(variant);

            if (mouseUpdated && variantUpdated) {
                response.sendRedirect("list-products");
            } else {
                request.setAttribute("error", "Cập nhật thất bại!");
                request.setAttribute("mouse", mouse);
                request.setAttribute("variant", variant);
                request.getRequestDispatcher("/views/Admin/update_mouse.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/views/Admin/update_mouse.jsp").forward(request, response);
        }
    }
}