<%-- 
    Document   : product-detail
    Created on : Feb 15, 2025, 11:26:24 PM
    Author     : CE182250
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">
    <head>
        <title>${product.name}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 1200px;
            }

            .product-detail {
                background: #ffffff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .product-title {
                font-size: 28px;
                font-weight: bold;
                color: #007bff;
            }

            .price {
                font-size: 24px;
                font-weight: bold;
                color: #dc3545;
            }

            .product-image {
                max-width: 100%;
                height: 250px; /* 🔹 Reduced height to match info section */
                object-fit: contain;
            }

            .quantity-selector {
                display: flex;
                align-items: center;
                border-radius: 5px;
                border: 1px solid #ced4da;
            }

            .quantity-selector input {
                width: 60px;
                text-align: center;
                border: none;
                font-size: 18px;
                font-weight: bold;
            }

            .quantity-selector button {
                font-size: 18px;
                padding: 5px 10px;
            }

            .btn-add-to-cart {
                background-color: #28a745;
                color: white;
                font-size: 18px;
                font-weight: bold;
                border-radius: 5px;
                padding: 10px 20px;
                transition: 0.3s;
            }

            .btn-add-to-cart:hover {
                background-color: #218838;
            }

            /* Comment Section */
            .list-group-item {
                background: #ffffff;
                border-radius: 5px;
                padding: 10px;
                border-left: 5px solid #007bff;
            }

            .comment-avatar {
                width: 40px;
                height: 40px;
                object-fit: cover;
            }

            /* Rating System */
            .rating-container {
                font-size: 30px;
                cursor: pointer;
                display: flex;
                gap: 5px;
                justify-content: center;
            }

            .star {
                color: gray;
                transition: color 0.3s;
            }

            .star:hover, .star.selected {
                color: gold;
            }

            /* Comment Input Box */
            .comment-box {
                background: #ffffff;
                border-radius: 5px;
                padding: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .comment-box textarea {
                width: 100%;
                height: 80px;
                resize: none;
                border: 1px solid #ced4da;
                border-radius: 5px;
                padding: 10px;
            }

            .comment-box button {
                margin-top: 10px;
            }
            /* 🔹 Căn chỉnh form */
            .add-to-cart-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* 🔹 Ô nhập số lượng */
            .quantity-input {
                width: 50px; /* ✅ Giảm kích thước để vừa phải */
                font-size: 16px;
                font-weight: bold;
                border-radius: 5px;
                text-align: center;
                padding: 5px;
            }

            /* 🔹 Nút tăng/giảm số lượng */
            .quantity-btn {
                width: 35px; /* ✅ Giảm kích thước để cân đối */
                height: 35px;
                font-size: 16px;
                border-radius: 5px;
            }

            /* 🔹 Nút "Thêm vào giỏ hàng" */
            .add-to-cart-btn {
                font-size: 14px; /* ✅ Giảm kích thước để vừa vặn */
                font-weight: bold;
                padding: 8px 12px; /* ✅ Thu nhỏ padding */
                border-radius: 5px;
                transition: 0.3s ease-in-out;
                white-space: nowrap; /* ✅ Giữ chữ không bị xuống dòng */
            }

            .add-to-cart-btn:hover {
                background-color: #218838;
                transform: scale(1.05);
            }


        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>

        <!-- Product Information Section -->
        <div class="container mt-5">
            <c:if test="${not empty product}">
                <div class="row align-items-center g-0">
                    <!-- Product Image -->
                    <div class="col-md-5 text-center p-5">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/ProductImage?id=${product.id}" alt="${product.name}"
                             class="img-fluid rounded shadow product-image">
                    </div>

                    <!-- Product Details -->
                    <div class="col-md-7 p-0">
                        <div class="product-detail p-4 rounded shadow-sm bg-white">
                            <h2 class="product-title text-primary">${product.name}</h2>

                            <p class="price text-danger fw-bold fs-4">
                                <fmt:formatNumber value="${product.price}" pattern="#,###" /> USD
                            </p>

                            <p class="product-description">${product.description}</p>



                            <!-- Hiển thị thông báo khi thêm vào giỏ hàng -->
                            <c:if test="${not empty sessionScope.cartMessage}">
                                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                                    ${sessionScope.cartMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <% session.removeAttribute("cartMessage");%> <!-- Xóa thông báo sau khi hiển thị -->
                            </c:if>

                            <!-- Form thêm vào giỏ hàng -->
                            <form action="AddToCart" method="POST" class="add-to-cart-form">
                                <input type="hidden" name="variantId" value="${product.id}">

                                <div class="d-flex align-items-center">
                                    <!-- 🔹 Nút giảm số lượng -->
                                    <button type="button" class="btn btn-outline-secondary quantity-btn" onclick="changeQuantity(-1)">
                                        <i class="bi bi-dash-lg"></i>
                                    </button>

                                    <!-- 🔹 Ô nhập số lượng -->
                                    <input type="number" name="quantity" id="quantity" value="1" min="1" 
                                           class="form-control text-center mx-2 quantity-input">

                                    <!-- 🔹 Nút tăng số lượng -->
                                    <button type="button" class="btn btn-outline-secondary quantity-btn" onclick="changeQuantity(1)">
                                        <i class="bi bi-plus-lg"></i>
                                    </button>

                                    <!-- 🔹 Nút thêm vào giỏ hàng -->
                                    <button type="submit" class="btn btn-success ms-3 add-to-cart-btn">
                                        🛒 Thêm vào giỏ hàng
                                    </button>
                                    <!-- ✅ Hiển thị thông báo khi thêm vào giỏ hàng thành công -->
<c:if test="${not empty sessionScope.cartMessage}">
    <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
        ${sessionScope.cartMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% session.removeAttribute("cartMessage"); %> <!-- Xóa thông báo sau khi hiển thị -->
</c:if>


                                </div>
                            </form>

                            <script>
                                function changeQuantity(value) {
                                    let quantityInput = document.getElementById("quantity");
                                    let currentValue = parseInt(quantityInput.value);

                                    // Kiểm tra nếu giá trị hợp lệ
                                    if (currentValue + value >= 1) {
                                        quantityInput.value = currentValue + value;
                                    }
                                }
                            </script>


                        </div>
                        </form>


                        <div> 
                            </br>
                        </div>
                        <div> 
                            ✅ Bảo hành Laptop 12 tháng miễn phí
                        </div>
                        <div> 
                            ✅ Install Windows and Office licenses by machine
                        </div>
                        <div> 
                            ✅ Free screen color scale package worth 300.000 VND
                        </div>


                    </div>
                </div>
            </div>
        </c:if>
    </div>
    <hr>
    <!-- Bảng thông số kỹ thuật -->
    <div class="container mt-4">
        <h3 class="text-info">🔧 Thông số kỹ thuật</h3>
        <table class="table table-specs">
            <c:forEach var="entry" items="${product.specifications}">
                <tr>
                    <th>${entry.key}</th>
                    <td>${entry.value}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="container mt-4">
        <h3 class="text-warning">⭐ Rating: <span id="rating-value">${averageRating}</span>/5</h3>

        <!-- Nếu user chưa đánh giá thì hiển thị hệ thống rating -->
        <c:if test="${!userRated}">
            <form action="${pageContext.request.contextPath}/RateProduct" method="POST">
                <input type="hidden" name="productId" value="${product.id}">

                <button type="submit" name="rating" value="1">★</button>
                <button type="submit" name="rating" value="2">★</button>
                <button type="submit" name="rating" value="3">★</button>
                <button type="submit" name="rating" value="4">★</button>
                <button type="submit" name="rating" value="5">★</button>
            </form>
        </c:if>

        <!-- Nếu user đã đánh giá, hiển thị số sao đã đánh giá -->
        <c:if test="${userRated}">
            <p>Bạn đã đánh giá sản phẩm này: <strong>${userRating}⭐</strong></p>
        </c:if>
    </div>



    <div class="container mt-4">
        <h3 class="text-success">💬 Bình luận</h3>

        <c:if test="${empty sessionScope.user}">
            <p><a href="${pageContext.request.contextPath}/Login?redirect=ProductDetail&id=${product.id}">Đăng nhập</a> để bình luận.</p>
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <div class="comment-box">
                <form action="${pageContext.request.contextPath}/AddComment" method="POST">
                    <input type="hidden" name="productId" value="${product.id}">
                    <textarea name="commentText" placeholder="Viết bình luận..." required></textarea>
                    <button type="submit" class="btn btn-success">Gửi</button>
                </form>
            </div>
        </c:if>

        <hr>

        <ul class="list-group mt-3">
            <c:forEach var="comment" items="${parentComments}">
                <li class="list-group-item">
                    <div class="comment-header">
                        <strong>${comment.username}</strong>
                        <span class="text-muted">• <fmt:formatDate value="${comment.createdAt}" pattern="HH:mm dd/MM/yyyy"/></span>
                    </div>
                    <p>${comment.content}</p>

                    <!-- Nếu user đang đăng nhập là chủ sở hữu bình luận, hiển thị nút Sửa và Xóa -->
                    <c:if test="${not empty sessionScope.user && sessionScope.user.id == comment.userId}">
                        <button class="btn btn-sm btn-warning" onclick="showEditForm(${comment.commentId})">Sửa</button>
                        <form action="${pageContext.request.contextPath}/DeleteComment" method="POST" class="d-inline">
                            <input type="hidden" name="commentId" value="${comment.commentId}">
                            <input type="hidden" name="productId" value="${product.id}">
                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa bình luận này?')">Xóa</button>
                        </form>
                    </c:if>

                    <div id="editForm-${comment.commentId}" style="display:none;">
                        <form action="${pageContext.request.contextPath}/EditComment" method="POST">
                            <input type="hidden" name="commentId" value="${comment.commentId}">
                            <input type="hidden" name="productId" value="${product.id}">
                            <textarea name="newContent">${comment.content}</textarea>
                            <button type="submit" class="btn btn-sm btn-primary">Lưu</button>
                            <button type="button" class="btn btn-sm btn-secondary" onclick="hideEditForm(${comment.commentId})">Hủy</button>
                        </form>
                    </div>

                    <ul class="reply-list">
                        <c:forEach var="reply" items="${comment.replies}">
                            <li class="reply-item">
                                <div class="comment-header">
                                    <strong>${reply.username}</strong>
                                    <span class="text-muted">• <fmt:formatDate value="${reply.createdAt}" pattern="HH:mm dd/MM/yyyy"/></span>
                                </div>
                                <p>${reply.content}</p>

                                <!-- Nếu user là chủ sở hữu của phản hồi, hiển thị nút Sửa và Xóa -->
                                <c:if test="${not empty sessionScope.user && sessionScope.user.id == reply.userId}">
                                    <button class="btn btn-sm btn-warning" onclick="showEditForm(${reply.commentId})">Sửa</button>
                                    <form action="${pageContext.request.contextPath}/DeleteComment" method="POST" class="d-inline">
                                        <input type="hidden" name="commentId" value="${reply.commentId}">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa bình luận này?')">Xóa</button>
                                    </form>
                                </c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
            </c:forEach>
        </ul>
    </div>

    <script>
        function showEditForm(commentId) {
            document.getElementById("editForm-" + commentId).style.display = "block";
        }

        function hideEditForm(commentId) {
            document.getElementById("editForm-" + commentId).style.display = "none";
        }
        function changeQuantity(value) {
            let quantityInput = document.getElementById("quantity");
            let currentValue = parseInt(quantityInput.value);

            // Kiểm tra nếu giá trị hợp lệ
            if (currentValue + value >= 1) {
                quantityInput.value = currentValue + value;
            }
        }
 document.addEventListener("DOMContentLoaded", function() {
        var cartAlert = document.querySelector(".alert-success");
        if (cartAlert) {
            setTimeout(function() {
                cartAlert.style.display = "none";
            }, 3000);
        }
    });
    </script>


    <style>
        .reply-list {
            margin-left: 50px;
            border-left: 3px solid #28a745;
            padding-left: 15px;
        }
        .reply-item {
            background-color: #e9ecef;
            border-radius: 5px;
            padding: 10px;
            margin-top: 5px;
        }
    </style>

    <jsp:include page="footer.jsp"/>
</body>
</html>
