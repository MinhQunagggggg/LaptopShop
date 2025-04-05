package ControllerAdmin;

import DAOAdmin.HeadphoneDAO;
import DAOAdmin.ProductVariantDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelAdmin.Headphone;
import modelAdmin.ProductVariant;
import java.io.IOException;

@WebServlet("/updateHeadphone")
public class UpdateHeadphoneServlet extends HttpServlet {

    private HeadphoneDAO headphoneDAO = new HeadphoneDAO();
    private ProductVariantDAO variantDAO = new ProductVariantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            Headphone headphone = headphoneDAO.getHeadphoneByProductId(productId);
            ProductVariant variant = variantDAO.getVariantByProductId(productId);

            if (headphone == null || variant == null) {
                String errorMessage = headphone == null 
                    ? "Không tìm thấy tai nghe với productId: " + productId 
                    : "Không tìm thấy biến thể sản phẩm với productId: " + productId;
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("/views/Admin/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("headphone", headphone);
            request.setAttribute("variant", variant);
            request.getRequestDispatcher("/views/Admin/update_headphone.jsp").forward(request, response);

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

            String brand = request.getParameter("brand");
            int warrantyMonths = Integer.parseInt(request.getParameter("warrantyMonths"));
            String connectionType = request.getParameter("connectionType");
            boolean wired = Boolean.parseBoolean(request.getParameter("wired"));
            String color = request.getParameter("color");
            String ledColor = request.getParameter("ledColor");
            float weight = Float.parseFloat(request.getParameter("weight"));
            String frequencyRange = request.getParameter("frequencyRange");
            String material = request.getParameter("material");
            int driverSize = Integer.parseInt(request.getParameter("driverSize"));

            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Headphone headphone = new Headphone(0, productId, brand, warrantyMonths, connectionType, wired, 
                color, ledColor, weight, frequencyRange, material, driverSize, null, null, 0, null);

            ProductVariant existingVariant = variantDAO.getVariantByProductId(productId);
            ProductVariant variant = new ProductVariant(productId, price, stock, 
                existingVariant != null ? existingVariant.getRam() : null);

            boolean headphoneUpdated = headphoneDAO.updateHeadphone(headphone);
            boolean variantUpdated = variantDAO.updateVariant(variant);

            if (headphoneUpdated && variantUpdated) {
                response.sendRedirect("list-products");
            } else {
                request.setAttribute("error", "Cập nhật thất bại!");
                request.setAttribute("headphone", headphone);
                request.setAttribute("variant", variant);
                request.getRequestDispatcher("/views/Admin/update_headphone.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/views/Admin/update_headphone.jsp").forward(request, response);
        }
    }
}