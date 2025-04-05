package ControllerStaff;

import DAO_Staff.CommentDAO;
import DAO_Staff.ProductDAO;
import DAO_Staff.RateDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model_Staff.Comment;
import Model_Staff.Headphone;
import Model_Staff.Keyboard;
import Model_Staff.Monitor;
import Model_Staff.Mouse;
import Model_Staff.ProductSpecification;
import Model_Staff.Rate;
import model.Product;

@WebServlet(name = "ViewProductDetailServlet", urlPatterns = {"/ViewProductDetails"})
public class ViewProductDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy product_id từ request
            String productIdStr = request.getParameter("product_id");
            if (productIdStr == null || productIdStr.isEmpty()) {
                response.sendRedirect("errorPage.jsp?message=Sản phẩm không tồn tại");
                return;
            }

            int productId = Integer.parseInt(productIdStr);

            // Lấy thông tin sản phẩm
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductInfo(productId);

            if (product == null) {
                response.sendRedirect("errorPage.jsp?message=Sản phẩm không tồn tại");
                return;
            }

            // Lấy catalog_id của sản phẩm
            int catalog_id = productDAO.getCatalogId(productId);

            // Lấy thông số kỹ thuật tùy theo catalog_id
            Object productSpec = null;
            switch (catalog_id) {
                case 1:
                    productSpec = productDAO.getProductSpecifications(productId);
                    break;
                case 2:
                    productSpec = productDAO.getMonitor(productId);
                    break;
                case 3:
                    productSpec = productDAO.getMouse(productId);
                    break;
                case 4:
                    productSpec = productDAO.getKeyboard(productId);
                    break;
                case 5:
                    productSpec = productDAO.getHeadphone(productId);
                    break;
                default:
                    productSpec = null;
            }

            // Chuyển đổi ảnh từ byte[] sang Base64 nếu ảnh không null
            byte[] imageBytes = product.getImageData();
            String imageBase64 = (imageBytes != null)
                    ? "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes) : null;

            // Lấy danh sách bình luận của sản phẩm
            CommentDAO commentDAO = new CommentDAO();
            List<Comment> comments = commentDAO.getCommentsByProduct(productId);
            int numbercmt = commentDAO.countCommentsByProduct(productId);

            // Tạo danh sách phẳng chứa toàn bộ bình luận (bao gồm cả replies)
            List<Comment> allComments = new ArrayList<>();
            for (Comment root : comments) {
                allComments.add(root);
                addRepliesToList(root, allComments);
            }

            // Lấy danh sách đánh giá của sản phẩm
            RateDAO rateDAO = new RateDAO();
            List<Rate> ratings = rateDAO.getRatingsByProduct(productId);

            // Tính điểm trung bình đánh giá
            double averageRating = rateDAO.getAverageRating(productId);

            // Lấy tổng số lượt đánh giá
            int totalRatings = rateDAO.getTotalRatings(productId);

            // Đưa dữ liệu vào request để truyền sang JSP
            request.setAttribute("product", product);
            request.setAttribute("catalog_id", catalog_id);
            request.setAttribute("productSpec", productSpec);
            request.setAttribute("imageBase64", imageBase64);
            request.setAttribute("comments", comments);
            request.setAttribute("allComments", allComments); // Thêm danh sách toàn bộ bình luận
            request.setAttribute("ratings", ratings);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("totalRatings", totalRatings);
            request.setAttribute("numbercmt", numbercmt);

            // Chuyển hướng đến productDetail.jsp
            request.getRequestDispatcher("views/Staff/productDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("errorPage.jsp?message=ID sản phẩm không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp?message=Có lỗi xảy ra khi tải sản phẩm");
        }
    }

    // Hàm đệ quy để thêm tất cả replies vào danh sách phẳng
    private void addRepliesToList(Comment comment, List<Comment> allComments) {
        for (Comment reply : comment.getReplies()) {
            allComments.add(reply);
            addRepliesToList(reply, allComments);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String action = request.getParameter("action");

            if ("deleteComment".equals(action)) {
                int commentId = Integer.parseInt(request.getParameter("commentId"));
                CommentDAO commentDAO = new CommentDAO();
                commentDAO.deleteComment(commentId);
                response.getWriter().write("success");
            } else if ("addComment".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int userId = Integer.parseInt(request.getParameter("userId"));
                String content = request.getParameter("content").trim();
                String parentCommentIdStr = request.getParameter("parentCommentId");

                Integer parentCommentId = (parentCommentIdStr != null && !parentCommentIdStr.trim().isEmpty())
                        ? Integer.parseInt(parentCommentIdStr)
                        : null;

                CommentDAO commentDAO = new CommentDAO();
                commentDAO.addComment(productId, userId, content, parentCommentId);
                response.getWriter().write("success");
            } else {
                response.getWriter().write("invalid_action");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("error");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        } finally {
            response.flushBuffer();
        }
    }
}