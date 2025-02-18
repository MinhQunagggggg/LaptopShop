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
                        <img src="${pageContext.request.contextPath}/assets/img/aa.png" 
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

                            <!-- Quantity Selector & Add to Cart -->
                            <div class="d-flex align-items-center">
                                <div class="quantity-selector d-flex align-items-center border rounded">
                                    <button class="btn btn-outline-secondary px-3" type="button" onclick="decreaseQuantity()">-</button>
                                    <input type="number" id="quantity" name="quantity" value="1" min="1" 
                                           class="form-control text-center mx-2 border-0">
                                    <button class="btn btn-outline-secondary px-3" type="button" onclick="increaseQuantity()">+</button>
                                </div>

                                <button class=" btn-add-to-cart ms-3 py-2" onclick="addToCart(${product.id})">
                                    ADD TO CART
                                </button>
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



        <!-- Rating Section -->
        <div class="container mt-4">
            <h3 class="text-warning">⭐ Rating: <span id="rating-value">${averageRating}</span>/5</h3>
            <div class="rating-container">
                <span class="star" data-value="1">★</span>
                <span class="star" data-value="2">★</span>
                <span class="star" data-value="3">★</span>
                <span class="star" data-value="4">★</span>
                <span class="star" data-value="5">★</span>
            </div>
        </div>

        <!-- Comments Section -->
        <div class="container mt-4">
            <h3 class="text-success">💬 Comments</h3>

            <div class="comment-box">
                <form action="${pageContext.request.contextPath}/AddComment" method="POST">
                    <input type="hidden" name="userId" value="${userId}">
                    <input type="hidden" name="productId" value="${product.id}">
                    <textarea name="comment" placeholder="Write your comment..." required></textarea>
                    <button type="submit" class="btn btn-success">Post Comment</button>
                </form>
            </div>

            <c:if test="${empty comments}">
                <p>No comments yet.</p>
            </c:if>

            <c:if test="${not empty comments}">
                <ul class="list-group shadow-sm mt-3">
                    <c:forEach var="comment" items="${comments}">
                        <li class="list-group-item d-flex align-items-start">
                            <img src="${pageContext.request.contextPath}/assets/img/${comment.avatarUrl}" 
                                 class="rounded-circle me-3 comment-avatar">
                            <div>
                                <strong>${comment.username}</strong> 
                                <span class="text-muted">• <fmt:formatDate value="${comment.createdAt}" pattern="MM/dd/yyyy HH:mm"/></span>
                                <p class="mb-0">${comment.content}</p>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
        <script>
            function decreaseQuantity() {
                let quantityInput = document.getElementById("quantity");
                let currentValue = parseInt(quantityInput.value);
                if (currentValue > 1) {
                    quantityInput.value = currentValue - 1;
                }
            }

            function increaseQuantity() {
                let quantityInput = document.getElementById("quantity");
                let currentValue = parseInt(quantityInput.value);
                quantityInput.value = currentValue + 1;
            }

            function addToCart(productId) {
                let quantity = document.getElementById("quantity").value;
                alert("Added " + quantity + " item(s) to the cart!"); // ✅ Replace with AJAX if needed
            }

        </script>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
