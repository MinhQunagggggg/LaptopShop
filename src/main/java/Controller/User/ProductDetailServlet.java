package Controller.User;

import DAO.CommentDAO;
import DAO.RatingDAO;
import DAO.ProductDAO;
import model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import model.Comment;

/**
 *
 * @author CE182250
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/ProductDetail"})
public class ProductDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String productIdParam = request.getParameter("id");

        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("Home");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("Home");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        RatingDAO ratingDAO = new RatingDAO();
        CommentDAO commentDAO = new CommentDAO();

        // Lấy thông tin sản phẩm
        Product product = productDAO.getProductInfo(productId);
        if (product == null) {
            response.sendRedirect("Home");
            return;
        }

        // Lấy thông số kỹ thuật
        productDAO.getProductSpecifications(product);

        // Lấy đánh giá trung bình
        double avgRating = ratingDAO.getProductAverageRating(productId);

        // Lấy danh sách bình luận
        List<Comment> comments = commentDAO.getProductComments(productId);

        // Gửi dữ liệu sang JSP
        request.setAttribute("product", product);
        request.setAttribute("averageRating", avgRating);
        request.setAttribute("comments", comments);
        request.getRequestDispatcher("views/User/product-detail.jsp").forward(request, response);
    }
}