package ControllerAdmin;

import DAOAdmin.HeadphoneDAO;
import modelAdmin.Headphone;
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

@WebServlet("/AddHeadphone")
@MultipartConfig(maxFileSize = 16177215)
public class AddHeadphoneServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/Admin/add_headphone.jsp").forward(request, response);
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

        HeadphoneDAO headphoneDAO = new HeadphoneDAO();
        try {
            int productId = headphoneDAO.addProduct(productName, description, accessoryBrandId, imageData);
            if (productId == -1) {
                response.getWriter().write("Lỗi khi thêm sản phẩm!");
                return;
            }

            String brand = request.getParameter("brand");

            String warrantyStr = request.getParameter("warranty_months");
            int warrantyMonths = (warrantyStr != null && warrantyStr.matches("\\d+")) ? Integer.parseInt(warrantyStr) : 0;

            String connectionType = request.getParameter("connection_type");
            boolean wired = request.getParameter("wired") != null;
            String color = request.getParameter("color");
            String ledColor = request.getParameter("led_color");

            String weightStr = request.getParameter("weight");
            float weight = (weightStr != null && weightStr.matches("\\d+(\\.\\d+)?")) ? Float.parseFloat(weightStr) : 0;

            String frequencyRange = request.getParameter("frequency_range");
            String material = request.getParameter("material");

            String driverSizeStr = request.getParameter("driver_size");
            int driverSize = (driverSizeStr != null && driverSizeStr.matches("\\d+")) ? Integer.parseInt(driverSizeStr) : 0;

            Headphone headphone = new Headphone(0, productId, brand, warrantyMonths, connectionType, wired, color, ledColor, weight, frequencyRange, material, driverSize, productName, description, accessoryBrandId, imageData);
            headphoneDAO.addHeadphone(headphone);

            String priceStr = request.getParameter("price");
            double price = (priceStr != null && priceStr.matches("\\d+(\\.\\d+)?")) ? Double.parseDouble(priceStr) : 0.0;

            String stockStr = request.getParameter("stock");
            int stock = (stockStr != null && stockStr.matches("\\d+")) ? Integer.parseInt(stockStr) : 0;

// Gọi DAO để thêm variant với ram NULL
            headphoneDAO.addVariant(productId, price, stock);

            response.sendRedirect("list-products");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
