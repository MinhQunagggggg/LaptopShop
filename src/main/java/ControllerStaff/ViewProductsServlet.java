package ControllerStaff;

import DAO_Staff.CommentDAO;
import DAO_Staff.ProductDAO;
import java.io.IOException;
import java.util.*;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model_Staff.Comment;
import model.Product;

/**
 * Servlet hiển thị chi tiết sản phẩm và bình luận
 */
@WebServlet(name = "ViewProductsServlet", urlPatterns = {"/ViewProductDetails"})
public class ViewProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ✅ Kiểm tra và xử lý `product_id` hợp lệ
        String productIdStr = request.getParameter("product_id");
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect("errorPage.jsp?message=Sản phẩm không tồn tại");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("errorPage.jsp?message=ID sản phẩm không hợp lệ");
            return;
        }

        // ✅ Lấy thông tin sản phẩm
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductInfo(productId);

        // ✅ Kiểm tra nếu sản phẩm không tồn tại
        if (product == null) {
            response.sendRedirect("errorPage.jsp?message=Sản phẩm không tồn tại");
            return;
        }

        // ✅ Lấy danh sách bình luận của sản phẩm
        CommentDAO commentDAO = new CommentDAO();
        List<Comment> comments = commentDAO.getCommentsByProduct(productId);

        // ✅ Chuyển đổi ảnh từ `byte[]` sang Base64
        byte[] imageBytes = product.getImageData();
        String imageBase64 = (imageBytes != null)
                ? "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes)
                : null;

        // ✅ Truyền dữ liệu vào request
        request.setAttribute("product", product);
        request.setAttribute("imageBase64", imageBase64);
        request.setAttribute("comments", comments);

        // ✅ Chuyển hướng đến trang chi tiết sản phẩm
        request.getRequestDispatcher("views/Staff/productDetail.jsp").forward(request, response);
    }
}
