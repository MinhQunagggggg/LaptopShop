<%-- 
    Document   : cart
    Created on : Feb 22, 2025, 8:08:23 PM
    Author     : CE182250
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Your Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">

    <style>
        /* ✅ Cố định kích thước cột, tự động xuống dòng nếu quá dài */
        .cart-table th, .cart-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            white-space: normal;
            word-wrap: break-word;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* ✅ Điều chỉnh độ rộng của từng cột */
        .cart-table th:nth-child(1), .cart-table td:nth-child(1) { width: 5%; } /* Checkbox */
        .cart-table th:nth-child(2), .cart-table td:nth-child(2) { width: 10%; } /* Hình ảnh */
        .cart-table th:nth-child(3), .cart-table td:nth-child(3) { width: 30%; max-width: 250px; } /* Tên sản phẩm */
        .cart-table th:nth-child(4), .cart-table td:nth-child(4) { width: 15%; } /* Giá */
        .cart-table th:nth-child(5), .cart-table td:nth-child(5) { width: 15%; } /* Số lượng */
        .cart-table th:nth-child(6), .cart-table td:nth-child(6) { width: 15%; } /* Tổng */
        .cart-table th:nth-child(7), .cart-table td:nth-child(7) { width: 10%; } /* Hành động */

        /* ✅ Đảm bảo bảng không bị bóp lại */
        .cart-table {
            width: 100%;
            table-layout: fixed;
        }

        /* ✅ Hình ảnh sản phẩm */
        .cart-table img {
            border-radius: 5px;
            max-width: 60px;
            height: auto;
        }

        /* ✅ Nút cập nhật & xoá */
        .btn-danger, .btn-primary {
            transition: 0.3s ease-in-out;
        }

        .btn-danger:hover {
            background-color: #dc3545;
            transform: scale(1.05);
        }

        .btn-primary:hover {
            transform: scale(1.05);
        }

        /* ✅ Input số lượng */
        .quantity-input {
            width: 60px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 5px;
        }

        /* ✅ Hiển thị thông báo */
        .alert-success {
            display: none;
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 1000;
            padding: 15px;
            border-radius: 5px;
            background-color: #28a745;
            color: white;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        /* ✅ Căn giữa button thanh toán */
        .checkout-container {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="menu.jsp"/>

<div class="container mt-5">
    <h2 class="text-primary text-center">🛒 Your Shopping Cart</h2>

    <!-- ✅ Thông báo thêm vào giỏ hàng thành công -->
    <c:if test="${not empty sessionScope.cartMessage}">
        <div class="alert-success" id="cartAlert">
            ${sessionScope.cartMessage}
        </div>
        <% session.removeAttribute("cartMessage"); %>
    </c:if>

    <c:if test="${empty cartItems}">
        <p class="text-center text-muted">Giỏ hàng của bạn đang trống.</p>
    </c:if>

    <c:if test="${not empty cartItems}">
        <form action="Checkout" method="POST" id="checkoutForm">
            <table class="table table-striped cart-table">
                <thead>
                    <tr>
                        <th>Chọn</th> <!-- Chọn tất cả -->
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td><input type="checkbox" name="selectedItems" value="${item.variantId}" class="product-checkbox"></td>
                            <td><img src="${pageContext.request.contextPath}/ProductImage?id=${item.variantId}" width="60"></td>
                        <td>${item.productName}</td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> VND</td>
                        
                        <!-- Form cập nhật số lượng -->
                        <td>
                            <form action="UpdateCart" method="POST" class="d-flex align-items-center">
                                <input type="hidden" name="variantId" value="${item.variantId}">
                                <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input mx-2">
                                <button type="submit" class="btn btn-primary btn-sm">🔄 Cập nhật</button>
                            </form>
                        </td>

                        <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /> VND</td>
                        <td>
                            <form action="RemoveFromCart" method="POST">
                                <input type="hidden" name="variantId" value="${item.variantId}">
                                <button type="submit" class="btn btn-danger btn-sm">🗑 Xóa</button>
                            </form>
                                
                        </td>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 🔹 Button Thanh Toán -->
            <div class="checkout-container">
                <button type="submit" class="btn btn-success fs-5 px-4">💳 Thanh Toán</button>
            </div>
        </form>
    </c:if>
</div>

<jsp:include page="footer.jsp"/>

<!-- ✅ JavaScript -->
<script>
    // Chọn hoặc bỏ chọn tất cả sản phẩm
    function toggleAll(source) {
        let checkboxes = document.querySelectorAll(".product-checkbox");
        checkboxes.forEach(checkbox => checkbox.checked = source.checked);
    }

    // Kiểm tra nếu không có sản phẩm nào được chọn thì chặn submit form
    document.getElementById("checkoutForm").addEventListener("submit", function(event) {
        let selectedItems = document.querySelectorAll(".product-checkbox:checked");
        if (selectedItems.length === 0) {
            alert("Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
            event.preventDefault();
        }
    });

    // Xử lý cập nhật giỏ hàng không cần load lại trang
    document.querySelectorAll(".update-cart-form").forEach(form => {
        form.addEventListener("submit", function(event) {
            event.preventDefault();
            let formData = new FormData(this);
            fetch("UpdateCart", {
                method: "POST",
                body: formData
            }).then(response => response.text()).then(data => {
                location.reload(); // Load lại trang sau khi cập nhật thành công
            });
        });
    });
</script>

</body>
</html>



