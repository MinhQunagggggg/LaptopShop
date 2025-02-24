package ControllerStaff;

import DAO_Staff.CommentDAO;
import DAO_Staff.ProductDAO;
import Model_Staff.Comment;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;


@WebServlet(name = "CommentServlet", urlPatterns = {"/Comment"})
public class CommentServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String productIdStr = request.getParameter("product_id");

    if (productIdStr == null || productIdStr.isEmpty()) {
        response.sendRedirect("errorPage.jsp?message=Thiếu ID sản phẩm");
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

    if (product == null) {
        response.sendRedirect("errorPage.jsp?message=Sản phẩm không tồn tại");
        return;
    }

    // ✅ Chuyển đổi ảnh từ `byte[]` sang Base64
    byte[] imageBytes = product.getImageData();
    String imageBase64 = null;

    if (imageBytes != null && imageBytes.length > 0) {
        imageBase64 = "data:image/png;base64," + java.util.Base64.getEncoder().encodeToString(imageBytes);
    }

    // ✅ Truyền dữ liệu đến JSP
    request.setAttribute("product", product);
    request.setAttribute("imageBase64", imageBase64);

    // ✅ Lấy danh sách bình luận
    CommentDAO commentDAO = new CommentDAO();
    List<Comment> comments = commentDAO.getCommentsByProduct(productId);
    request.setAttribute("comments", comments);

    // ✅ Chuyển đến JSP
    request.getRequestDispatcher("views/Staff/productDetail.jsp").forward(request, response);
}



    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("product_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String content = request.getParameter("content");
        String parentCommentIdStr = request.getParameter("parent_comment_id");

        Integer parentCommentId = (parentCommentIdStr != null && !parentCommentIdStr.isEmpty()) 
                                ? Integer.parseInt(parentCommentIdStr) 
                                : null;

        CommentDAO commentDAO = new CommentDAO();
        commentDAO.addComment(productId, userId, content, parentCommentId);

        response.sendRedirect("Comment?product_id=" + productId);
    }

    // Xử lý yêu cầu DELETE để xóa bình luận
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int commentId = Integer.parseInt(request.getParameter("comment_id"));
        CommentDAO commentDAO = new CommentDAO();
        commentDAO.deleteComment(commentId);
        response.setStatus(HttpServletResponse.SC_NO_CONTENT);  // Trả về mã trạng thái 204 (No Content)
    }
}

