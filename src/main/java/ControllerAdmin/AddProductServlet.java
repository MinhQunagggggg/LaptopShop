package ControllerAdmin;

import DAOAdmin.HeadphoneDAO;
import DAOAdmin.KeyboardDAO;
import DAOAdmin.MonitorDAO;
import DAOAdmin.ProductDAO;
import DAOAdmin.ProductSpecificationDAO;
import DAOAdmin.ProductVariantDAO;
import modelAdmin.ProductAdmin;
import modelAdmin.ProductSpecification;
import modelAdmin.ProductVariant;
import modelAdmin.Monitor;
import DAOAdmin.MouseDAO;
import modelAdmin.Mouse;

import java.io.IOException;
import java.io.InputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import static java.lang.Double.parseDouble;
import static java.lang.Integer.parseInt;
import modelAdmin.Headphone;
import modelAdmin.Keyboard;

@WebServlet("/add-product")
@MultipartConfig(maxFileSize = 16177215)
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/Admin/add_product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            int brandId = Integer.parseInt(request.getParameter("brand_id"));
            int subBrandId = Integer.parseInt(request.getParameter("subbrand_id"));
            int catalogId = Integer.parseInt(request.getParameter("catalog_id"));

            Part filePart = request.getPart("image_data");
            InputStream inputStream = filePart.getInputStream();
            byte[] imageData = inputStream.readAllBytes();

            ProductAdmin product = new ProductAdmin(name, description, categoryId, brandId, subBrandId, catalogId, imageData);
            ProductDAO productDAO = new ProductDAO();

            int productId = productDAO.addProductMNgoc(product);
            if (productId == -1) {
                response.sendRedirect("error.jsp");
                return;
            }

            if (catalogId == 1) { // Laptop
                String cpu = request.getParameter("cpu");
                String ram = request.getParameter("ram");
                String storage = request.getParameter("storage");
                String resolution = request.getParameter("resolution");
                String graphics = request.getParameter("graphics");
                String ports = request.getParameter("ports");
                String wireless = request.getParameter("wireless");
                String camera = request.getParameter("camera");
                String battery = request.getParameter("battery");
                String dimensions = request.getParameter("dimensions");
                String weight = request.getParameter("weight");
                String keyboard = request.getParameter("keyboard");
                String material = request.getParameter("material");
                String warranty = request.getParameter("warranty");
                String os = request.getParameter("os");
                String condition = request.getParameter("condition");
                String refreshRate = request.getParameter("refresh_rate");

                ProductSpecification spec = new ProductSpecification(productId, cpu, ram, storage, resolution, graphics, ports, wireless, camera, battery, dimensions, weight, keyboard, material, warranty, os, condition, refreshRate);
                ProductSpecificationDAO specDAO = new ProductSpecificationDAO();
                specDAO.addProductSpecification(spec);
            }

            if (catalogId == 2) { // Monitor (giả sử ID 2 là Monitor)

                String model = request.getParameter("model");
                double size = parseDouble(request.getParameter("size"));
                String panelType = request.getParameter("panel_type");
                String resolution = request.getParameter("resolution");
                String bitDepth = request.getParameter("bit_depth");
                String colorGamut = request.getParameter("color_gamut");
                int brightness = parseInt(request.getParameter("brightness"));
                int refreshRate = parseInt(request.getParameter("refresh_rate"));
                String hdr = request.getParameter("hdr");
                String ports = request.getParameter("ports");
                boolean audioOut = "on".equals(request.getParameter("audio_out"));
                String functionKeys = request.getParameter("function_keys");
                double weight = parseDouble(request.getParameter("weight"));
                String dimensions = request.getParameter("dimensions");
                String color = request.getParameter("color");

                Monitor monitor = new Monitor(productId, model, size, panelType, resolution, bitDepth, colorGamut, brightness,
                        refreshRate, hdr, ports, audioOut, functionKeys, weight, dimensions, color);
                MonitorDAO monitorDAO = new MonitorDAO();
                monitorDAO.addMonitor(monitor);
            }

            if (catalogId == 3) { // Giả sử ID 3 là chuột (Mouse)
                String brand = request.getParameter("brand");
                int warrantyMonths = Integer.parseInt(request.getParameter("warranty_months"));
                String connectionType = request.getParameter("connection_type");
                boolean wired = "on".equals(request.getParameter("wired"));
                int dpi = Integer.parseInt(request.getParameter("dpi"));
                String switchType = request.getParameter("switch_type");
                String mouseLed = request.getParameter("mouse_led");
                String color = request.getParameter("color");
                String dimensions = request.getParameter("dimensions");
                double weight = Double.parseDouble(request.getParameter("weight"));

                Mouse mouse = new Mouse(productId, brand, warrantyMonths, connectionType, wired, dpi, switchType, mouseLed, color, dimensions, weight);
                MouseDAO mouseDAO = new MouseDAO();
                mouseDAO.addMouse(mouse);
            }
            if (catalogId == 4) { // Giả sử ID 4 là bàn phím (Keyboard)
                String brand = request.getParameter("brand");
                String connectionType = request.getParameter("connection_type");
                boolean mechanical = "on".equals(request.getParameter("mechanical"));
                String switchType = request.getParameter("switch_type");
                boolean rgb = "on".equals(request.getParameter("rgb"));
                String layout = request.getParameter("layout");
                String dimensions = request.getParameter("dimensions");
                double weight = parseDouble(request.getParameter("weight"));
                int warrantyMonths = Integer.parseInt(request.getParameter("warranty_months"));

                Keyboard keyboard = new Keyboard(productId, brand, connectionType, mechanical, switchType, rgb, layout, dimensions, weight, warrantyMonths);
                KeyboardDAO keyboardDAO = new KeyboardDAO();
                keyboardDAO.addKeyboard(keyboard);
            }
            if (catalogId == 5) { // Headphone
                String brand = request.getParameter("brand");
                int warrantyMonths = Integer.parseInt(request.getParameter("warranty_months"));
                String connectionType = request.getParameter("connection_type");
                boolean wired = "on".equals(request.getParameter("wired"));
                String color = request.getParameter("color");
                String ledColor = request.getParameter("led_color");
                double weight = request.getParameter("weight") != null ? Double.parseDouble(request.getParameter("weight")) : 0;
                String frequencyRange = request.getParameter("frequency_range");
                String material = request.getParameter("material");
                int driverSize = Integer.parseInt(request.getParameter("driver_size"));

                Headphone headphone = new Headphone(0, productId, brand, warrantyMonths, connectionType, wired, color, ledColor, weight, frequencyRange, material, driverSize);

                HeadphoneDAO headphoneDAO = new HeadphoneDAO();
                headphoneDAO.addHeadphone(headphone);
            }
            if (request.getParameter("price") != null && request.getParameter("stock") != null) {
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                ProductVariant variant = new ProductVariant(productId, price, stock);
                ProductVariantDAO variantDAO = new ProductVariantDAO();
                variantDAO.addProductVariant(variant);
            }

            response.sendRedirect("list-products");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
