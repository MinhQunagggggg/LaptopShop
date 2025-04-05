package ControllerAdmin;

import DAOAdmin.MonitorDAO;
import DAOAdmin.ProductVariantDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelAdmin.Monitor;
import modelAdmin.ProductVariant;
import java.io.IOException;

@WebServlet("/updateMonitor")
public class UpdateMonitorServlet extends HttpServlet {

    private MonitorDAO monitorDAO = new MonitorDAO();
    private ProductVariantDAO variantDAO = new ProductVariantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            Monitor monitor = monitorDAO.getMonitorByProductId(productId);
            ProductVariant variant = variantDAO.getVariantByProductId(productId);

            if (monitor == null || variant == null) {
                String errorMessage = monitor == null 
                    ? "Không tìm thấy màn hình với productId: " + productId 
                    : "Không tìm thấy biến thể sản phẩm với productId: " + productId;
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("views/Admin/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("monitor", monitor);
            request.setAttribute("variant", variant);
            request.getRequestDispatcher("views/Admin/update_monitor.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID sản phẩm không hợp lệ: " + request.getParameter("productId"));
            request.getRequestDispatcher("views/Admin/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi lấy dữ liệu sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("views/Admin/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            // Lấy dữ liệu từ form cho Monitor
            String model = request.getParameter("model");
            float size = Float.parseFloat(request.getParameter("size"));
            String panelType = request.getParameter("panelType");
            String resolution = request.getParameter("resolution");
            String bitDepth = request.getParameter("bitDepth");
            String colorGamut = request.getParameter("colorGamut");
            int brightness = Integer.parseInt(request.getParameter("brightness"));
            int refreshRate = Integer.parseInt(request.getParameter("refreshRate"));
            String hdr = request.getParameter("hdr");
            String ports = request.getParameter("ports");
            boolean audioOut = Boolean.parseBoolean(request.getParameter("audioOut"));
            String functionKeys = request.getParameter("functionKeys");
            float weight = Float.parseFloat(request.getParameter("weight"));
            String dimensions = request.getParameter("dimensions");
            String color = request.getParameter("color");

            // Lấy dữ liệu từ form cho ProductVariant (không bao gồm ram)
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            // Tạo đối tượng Monitor
            Monitor monitor = new Monitor(0, productId, model, size, panelType, resolution, bitDepth, 
                colorGamut, brightness, refreshRate, hdr, ports, audioOut, functionKeys, weight, 
                dimensions, color, null, null, null); // Không có productName, description, image

            // Tạo đối tượng ProductVariant (không cập nhật ram, giữ nguyên giá trị cũ)
            ProductVariant existingVariant = variantDAO.getVariantByProductId(productId);
            ProductVariant variant = new ProductVariant(productId, price, stock, existingVariant != null ? existingVariant.getRam() : null);

            // Cập nhật database
            boolean monitorUpdated = monitorDAO.updateMonitor(monitor);
            boolean variantUpdated = variantDAO.updateVariant(variant);

            if (monitorUpdated && variantUpdated) {
                response.sendRedirect("list-products");
            } else {
                request.setAttribute("error", "Cập nhật thất bại!");
                request.setAttribute("monitor", monitor);
                request.setAttribute("variant", variant);
                request.getRequestDispatcher("views/Admin/update_monitor.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("views/Admin/update_monitor.jsp").forward(request, response);
        }
    }
}