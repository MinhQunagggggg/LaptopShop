package ControllerAdmin;

import DAOAdmin.KeyboardDAO;
import modelAdmin.Keyboard;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

@WebServlet("/AddKeyboard")
@MultipartConfig(maxFileSize = 16177215)
public class AddKeyboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/Admin/add_keyboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            int accessoryBrandId = Integer.parseInt(request.getParameter("accessoryBrandId"));

            Part imagePart = request.getPart("image");
            InputStream inputStream = imagePart.getInputStream();
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            int nRead;
            byte[] data = new byte[1024];
            while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }
            buffer.flush();
            byte[] imageData = buffer.toByteArray();

            KeyboardDAO keyboardDAO = new KeyboardDAO();
            int productId = keyboardDAO.addProduct(productName, description, accessoryBrandId, imageData);
            if (productId == -1) {
                response.getWriter().write("Lỗi khi thêm sản phẩm!");
                return;
            }

            String brand = request.getParameter("brand");
            int warrantyMonths = Integer.parseInt(request.getParameter("warrantyMonths"));
            String type = request.getParameter("type");
            String connectionType = request.getParameter("connectionType");
            boolean wired = request.getParameter("wired") != null;
            String keycapMaterial = request.getParameter("keycapMaterial");
            String switchType = request.getParameter("switchType");
            String color = request.getParameter("color");
            String ledColor = request.getParameter("ledColor");
            String dimensions = request.getParameter("dimensions");

            // Kiểm tra giá trị weight trước khi chuyển đổi
            float weight = 0;
            String weightParam = request.getParameter("weight");
            if (weightParam != null && !weightParam.trim().isEmpty()) {
                try {
                    weight = Float.parseFloat(weightParam);
                } catch (NumberFormatException e) {
                    response.getWriter().write("Lỗi: Giá trị weight không hợp lệ!");
                    return;
                }
            }

            // Kiểm tra giá trị batteryCapacity trước khi chuyển đổi
            int batteryCapacity = 0;
            String batteryParam = request.getParameter("batteryCapacity");
            if (batteryParam != null && !batteryParam.trim().isEmpty()) {
                try {
                    batteryCapacity = Integer.parseInt(batteryParam);
                } catch (NumberFormatException e) {
                    response.getWriter().write("Lỗi: Giá trị batteryCapacity không hợp lệ!");
                    return;
                }
            }

            String keycapProfile = request.getParameter("keycapProfile");

            Keyboard keyboard = new Keyboard(0, productId, brand, warrantyMonths, type, connectionType, wired, keycapMaterial, switchType, color, ledColor, dimensions, weight, batteryCapacity, keycapProfile, productName, description, accessoryBrandId, imageData);
            keyboardDAO.addKeyboard(keyboard);

            // Lấy giá và số lượng từ request
            String priceStr = request.getParameter("price");
            double price = (priceStr != null && priceStr.matches("\\d+(\\.\\d+)?")) ? Double.parseDouble(priceStr) : 0.0;

            String stockStr = request.getParameter("stock");
            int stock = (stockStr != null && stockStr.matches("\\d+")) ? Integer.parseInt(stockStr) : 0;

// Gọi DAO để thêm variant với ram NULL
            keyboardDAO.addVariant(productId, price, stock);

            response.sendRedirect("list-products");
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (NumberFormatException e) {
            response.getWriter().write("Lỗi: Dữ liệu nhập vào không hợp lệ!");
        }
    }
}
