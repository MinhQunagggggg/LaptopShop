package ControllerAdmin;

import DAOAdmin.OrderDAO;
import DAOAdmin.CustomerDAO;
import DAOAdmin.ProductDAO;
import DAOAdmin.RevenueDAO;
import DAOAdmin.StaffDAO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet({"/statistics", "/order-stats", "/product-stats", "/customer-stats", "/revenue-stats", "/staff-stats"})
public class StatisticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String yearParam = request.getParameter("year");
        String monthParam = request.getParameter("month");

        Integer year = yearParam != null && !yearParam.isEmpty() ? Integer.parseInt(yearParam) : null;
        Integer month = monthParam != null && !monthParam.isEmpty() ? Integer.parseInt(monthParam) : null;

        // Nếu truy cập "/admin/statistics", hiển thị trang JSP
        if ("/statistics".equals(servletPath)) {
            // Lấy dữ liệu thống kê ban đầu (nếu cần truyền dữ liệu mặc định)
            List<?> orderStats = new OrderDAO().getOrderStats(year, month);
            List<?> productStats = new ProductDAO().getProductStats(year, month);
            List<?> customerStats = new CustomerDAO().getCustomerStats(year, month);
            List<?> revenueStats = new RevenueDAO().getRevenueStats(year, month);
            List<?> staffStats = new StaffDAO().getStaffStats(year, month);

            // Đặt dữ liệu vào request attributes để JSP có thể sử dụng (tùy chọn)
            request.setAttribute("orderStats", orderStats);
            request.setAttribute("productStats", productStats);
            request.setAttribute("customerStats", customerStats);
            request.setAttribute("revenueStats", revenueStats);
            request.setAttribute("staffStats", staffStats);

            // Forward đến Statistics.jsp
            request.getRequestDispatcher("/views/Admin/Statistics.jsp").forward(request, response);
            return;
        }

        // Xử lý các endpoint API để trả về JSON
        Object stats;
        switch (servletPath) {
            case "/order-stats":
                stats = new OrderDAO().getOrderStats(year, month);
                break;
            case "/product-stats":
                stats = new ProductDAO().getProductStats(year, month);
                break;
            case "/customer-stats":
                stats = new CustomerDAO().getCustomerStats(year, month);
                break;
            case "/revenue-stats":
                stats = new RevenueDAO().getRevenueStats(year, month);
                break;
            case "/staff-stats":
                stats = new StaffDAO().getStaffStats(year, month);
                break;
            default:
                stats = Collections.emptyList();
        }

        // Trả về dữ liệu JSON cho các yêu cầu AJAX
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(stats);
        response.getWriter().write(json);
    }
}