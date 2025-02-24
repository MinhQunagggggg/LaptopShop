<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        .container {
            margin-top: 30px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product-details {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .product-img {
            flex: 1;
            text-align: center;
        }
        .product-img img {
            width: 100%;
            max-width: 350px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product-info {
            flex: 2;
        }
        .comments-section {
            margin-top: 40px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .comment {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .comment strong {
            color: #007bff;
        }
        .btn-reply, .btn-delete {
            font-size: 0.9rem;
            text-decoration: none;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .btn-reply {
            color: white;
            background-color: #007bff;
        }
        .btn-reply:hover {
            background-color: #0056b3;
        }
        .btn-delete {
            color: white;
            background-color: red;
        }
        .btn-delete:hover {
            background-color: darkred;
        }
        .reply-form, .delete-form {
            display: none;
            margin-top: 10px;
        }
    </style>
    <script>
        function showReplyForm(commentId) {
            document.getElementById('reply-form-' + commentId).style.display = 'block';
        }
        function showDeleteForm(commentId) {
            document.getElementById('delete-form-' + commentId).style.display = 'block';
        }
        function deleteComment(commentId) {
            if (confirm("Bạn có chắc chắn muốn xóa bình luận này?")) {
                fetch("Comment?comment_id=" + commentId, { method: "DELETE" })
                    .then(response => {
                        if (response.status === 204) {
                            alert("Bình luận đã được xóa.");
                            location.reload();
                        } else {
                            alert("Không thể xóa bình luận.");
                        }
                    });
            }
        }
    </script>
</head>
<body>

    <div class="container">
        <h1 class="text-center">Chi Tiết Sản Phẩm</h1>

        <!-- Hiển thị sản phẩm -->
        <div class="product-details">
            <div class="product-img">
                <c:choose>
                    <c:when test="${not empty imageBase64}">
                        <img src="${imageBase64}" alt="Sản phẩm">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/default-product.jpg" alt="Ảnh mặc định">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="product-info">
                <h2>${product.name}</h2>
                <p><strong>Mô tả:</strong> ${product.description}</p>
                <p><strong>Giá:</strong> <fmt:formatNumber value="${product.price}" pattern="#,###" /> VND</p>
            </div>
        </div>

        <!-- Hiển thị bình luận -->
        <div class="comments-section">
            <h3>Bình luận về sản phẩm</h3>

            <c:forEach var="comment" items="${comments}">
                <div class="comment">
                    <p><strong>${comment.userName}</strong>: ${comment.content}</p>
                    <p><i>${comment.createdAt}</i></p>

                    <a href="javascript:void(0);" class="btn-reply" onclick="showReplyForm(${comment.commentId})">Trả lời</a>
                    <a href="javascript:void(0);" class="btn-delete" onclick="deleteComment(${comment.commentId})">Xóa</a>

                    <!-- Form trả lời -->
                    <div id="reply-form-${comment.commentId}" class="reply-form">
                        <form action="Comment" method="POST">
                            <input type="hidden" name="product_id" value="${param.product_id}" />
                            <input type="hidden" name="user_id" value="1" />
                            <input type="hidden" name="parent_comment_id" value="${comment.commentId}" />
                            <textarea name="content" rows="3" placeholder="Nhập phản hồi..."></textarea><br>
                            <button type="submit" class="btn-reply">Gửi phản hồi</button>
                        </form>
                    </div>
                </div>

                <!-- Hiển thị phản hồi -->
                <c:forEach var="reply" items="${comments}">
                    <c:if test="${reply.parentCommentId == comment.commentId}">
                        <div class="comment" style="margin-left: 40px;">
                            <p><strong>${reply.userName}</strong>: ${reply.content}</p>
                            <p><i>${reply.createdAt}</i></p>
                            <a href="javascript:void(0);" class="btn-delete" onclick="deleteComment(${reply.commentId})">Xóa</a>
                        </div>
                    </c:if>
                </c:forEach>
            </c:forEach>

            <!-- Form thêm bình luận -->
            <form action="Comment" method="POST" class="comment-form">
                <h3>Thêm bình luận</h3>
                <input type="hidden" name="product_id" value="${param.product_id}" />
                <input type="hidden" name="user_id" value="1" />
                <textarea name="content" rows="3" placeholder="Nhập bình luận..."></textarea><br>
                <button type="submit" class="btn-reply">Gửi bình luận</button>
            </form>
        </div>

    </div>

</body>
</html>
