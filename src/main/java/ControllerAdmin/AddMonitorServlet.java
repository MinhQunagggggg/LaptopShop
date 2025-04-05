package ControllerAdmin;

import DAOAdmin.MonitorDAO;
import modelAdmin.Monitor;
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

@WebServlet("/AddMonitor")
@MultipartConfig(maxFileSize = 16177215)
public class AddMonitorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/Admin/add_monitor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("product_name");
        String description = request.getParameter("description");

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

        MonitorDAO monitorDAO = new MonitorDAO();
        try {
            int productId = monitorDAO.addProduct(productName, description, imageData);
            if (productId == -1) {
                response.getWriter().write("Lỗi khi thêm sản phẩm!");
                return;
            }

            String model = request.getParameter("model");

            String sizeStr = request.getParameter("size");
            float size = (sizeStr != null && sizeStr.matches("\\d+(\\.\\d+)?")) ? Float.parseFloat(sizeStr) : 0;

            String panelType = request.getParameter("panel_type");
            String resolution = request.getParameter("resolution");
            String bitDepth = request.getParameter("bit_depth");
            String colorGamut = request.getParameter("color_gamut");

            String brightnessStr = request.getParameter("brightness");
            int brightness = (brightnessStr != null && brightnessStr.matches("\\d+")) ? Integer.parseInt(brightnessStr) : 0;

            String refreshRateStr = request.getParameter("refresh_rate");
            int refreshRate = (refreshRateStr != null && refreshRateStr.matches("\\d+")) ? Integer.parseInt(refreshRateStr) : 0;

            String hdr = request.getParameter("hdr");
            String ports = request.getParameter("ports");
            boolean audioOut = request.getParameter("audio_out") != null;
            String functionKeys = request.getParameter("function_keys");

            String weightStr = request.getParameter("weight");
            float weight = (weightStr != null && weightStr.matches("\\d+(\\.\\d+)?")) ? Float.parseFloat(weightStr) : 0;

            String dimensions = request.getParameter("dimensions");
            String color = request.getParameter("color");

            Monitor monitor = new Monitor(0, productId, model, size, panelType, resolution, bitDepth, colorGamut, brightness, refreshRate, hdr, ports, audioOut, functionKeys, weight, dimensions, color, productName, description, imageData);
            monitorDAO.addMonitor(monitor);

            // Lấy giá và số lượng từ request
            String priceStr = request.getParameter("price");
            double price = (priceStr != null && priceStr.matches("\\d+(\\.\\d+)?")) ? Double.parseDouble(priceStr) : 0.0;

            String stockStr = request.getParameter("stock");
            int stock = (stockStr != null && stockStr.matches("\\d+")) ? Integer.parseInt(stockStr) : 0;

// Gọi DAO để thêm variant với ram NULL
            monitorDAO.addVariant(productId, price, stock);

            response.sendRedirect("list-products");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
