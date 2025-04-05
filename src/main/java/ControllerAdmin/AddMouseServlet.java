package ControllerAdmin;

import DAOAdmin.MouseDAO;
import modelAdmin.Mouse;
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

@WebServlet("/AddMouse")
@MultipartConfig(maxFileSize = 16177215)
public class AddMouseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/Admin/add_mouse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("product_name");
        String description = request.getParameter("description");
        int accessoryBrandId = Integer.parseInt(request.getParameter("accessory_brand_id"));

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

        MouseDAO mouseDAO = new MouseDAO();
        try {
            int productId = mouseDAO.addProduct(productName, description, accessoryBrandId, imageData);
            if (productId == -1) {
                response.getWriter().write("Lỗi khi thêm sản phẩm!");
                return;
            }

            String brand = request.getParameter("brand");
            int warrantyMonths = Integer.parseInt(request.getParameter("warranty_months"));
            String connectionType = request.getParameter("connection_type");
            boolean wired = request.getParameter("wired") != null;
            int dpi = Integer.parseInt(request.getParameter("dpi"));
            String switchType = request.getParameter("switch_type");
            String mouseLed = request.getParameter("mouse_led");
            String color = request.getParameter("color");
            String dimensions = request.getParameter("dimensions");
            float weight = Float.parseFloat(request.getParameter("weight"));

            Mouse mouse = new Mouse(0, productId, brand, warrantyMonths, connectionType, wired, dpi, switchType, mouseLed, color, dimensions, weight, productName, description, accessoryBrandId, imageData);
            mouseDAO.addMouse(mouse);

            // Lấy giá và số lượng từ request
            String priceStr = request.getParameter("price");
            double price = (priceStr != null && priceStr.matches("\\d+(\\.\\d+)?")) ? Double.parseDouble(priceStr) : 0.0;

            String stockStr = request.getParameter("stock");
            int stock = (stockStr != null && stockStr.matches("\\d+")) ? Integer.parseInt(stockStr) : 0;

// Gọi DAO để thêm variant với ram NULL
            mouseDAO.addVariant(productId, price, stock);

            response.sendRedirect("list-products");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
