package ControllerAdmin;

import DAOAdmin.KeyboardDAO;
import DAOAdmin.ProductVariantDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelAdmin.Keyboard;
import modelAdmin.ProductVariant;
import java.io.IOException;

@WebServlet("/updateKeyboard")
public class UpdateKeyboardServlet extends HttpServlet {

    private KeyboardDAO keyboardDAO = new KeyboardDAO();
    private ProductVariantDAO variantDAO = new ProductVariantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            Keyboard keyboard = keyboardDAO.getKeyboardByProductId(productId);
            ProductVariant variant = variantDAO.getVariantByProductId(productId);

            if (keyboard == null || variant == null) {
                String errorMessage = keyboard == null 
                    ? "Không tìm thấy bàn phím với productId: " + productId 
                    : "Không tìm thấy biến thể sản phẩm với productId: " + productId;
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("/views/Admin/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("keyboard", keyboard);
            request.setAttribute("variant", variant);
            request.getRequestDispatcher("/views/Admin/update_keyboard.jsp").forward(request, response);

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
            String type = request.getParameter("type");
            String connectionType = request.getParameter("connectionType");
            boolean wired = Boolean.parseBoolean(request.getParameter("wired"));
            String keycapMaterial = request.getParameter("keycapMaterial");
            String switchType = request.getParameter("switchType");
            String color = request.getParameter("color");
            String ledColor = request.getParameter("ledColor");
            String dimensions = request.getParameter("dimensions");
            float weight = Float.parseFloat(request.getParameter("weight"));
            int batteryCapacity = Integer.parseInt(request.getParameter("batteryCapacity"));
            String keycapProfile = request.getParameter("keycapProfile");

            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Keyboard keyboard = new Keyboard(0, productId, brand, warrantyMonths, type, connectionType, wired, 
                keycapMaterial, switchType, color, ledColor, dimensions, weight, batteryCapacity, 
                keycapProfile, null, null, 0, null);

            ProductVariant existingVariant = variantDAO.getVariantByProductId(productId);
            ProductVariant variant = new ProductVariant(productId, price, stock, 
                existingVariant != null ? existingVariant.getRam() : null);

            boolean keyboardUpdated = keyboardDAO.updateKeyboard(keyboard);
            boolean variantUpdated = variantDAO.updateVariant(variant);

            if (keyboardUpdated && variantUpdated) {
                response.sendRedirect("list-products");
            } else {
                request.setAttribute("error", "Cập nhật thất bại!");
                request.setAttribute("keyboard", keyboard);
                request.setAttribute("variant", variant);
                request.getRequestDispatcher("/views/Admin/update_keyboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/views/Admin/update_keyboard.jsp").forward(request, response);
        }
    }
}