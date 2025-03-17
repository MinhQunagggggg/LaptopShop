package Controller;

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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.Comment;
import model.ProductVariant;
import model.User;

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

        Product product = productDAO.getProductInfo(productId);
        if (product == null) {
            response.sendRedirect("Home");
            return;
        }

        // Lấy thông số kỹ thuật sản phẩm
        productDAO.getProductSpecifications(product);
        double avgRating = ratingDAO.getAverageRating(productId);

        // 🔹 Lấy danh sách bình luận cha
        List<Comment> parentComments = commentDAO.getParentComments(productId);

        // 🔹 Lấy danh sách phản hồi
        List<Comment> replies = commentDAO.getReplies(productId);

        List<ProductVariant> ramOptions = productDAO.getRamOptionsByProductId(productId);
        request.setAttribute("ramOptions", ramOptions);

        // 🔹 Gán các phản hồi vào bình luận cha
        for (Comment parent : parentComments) {
            List<Comment> childReplies = new ArrayList<>();
            for (Comment reply : replies) {
                if (reply.getParentCommentId() == parent.getCommentId()) {
                    childReplies.add(reply);
                }
            }
            parent.setReplies(childReplies);
        }
        // Lấy user từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        boolean userRated = false;
        int userRating = 0;

        if (user != null) {
            userRated = ratingDAO.hasUserRated(productId, user.getId());
            if (userRated) {
                userRating = ratingDAO.getUserRating(productId, user.getId());
            }
        }
        request.setAttribute("product", product);
        request.setAttribute("averageRating", avgRating);
        request.setAttribute("parentComments", parentComments);
        request.setAttribute("userRated", userRated);
        request.setAttribute("userRating", userRating);
        request.getRequestDispatcher("views/User/product-detail.jsp").forward(request, response);
    }
}
