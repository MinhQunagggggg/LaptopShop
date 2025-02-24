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
</head>
<body>

<jsp:include page="menu.jsp"/>

<div class="container mt-5">
    <h2 class="text-primary text-center">🛒 Your Shopping Cart</h2>

    <!-- ✅ Hiển thị thông báo -->
    <c:if test="${not empty sessionScope.cartMessage}">
        <div class="alert alert-success text-center" id="cartAlert">
            ${sessionScope.cartMessage}
        </div>
        <c:remove var="cartMessage" scope="session"/>
    </c:if>

    <c:if test="${empty cartItems}">
        <p class="text-center text-muted">Giỏ hàng của bạn đang trống.</p>
    </c:if>

    <c:if test="${not empty cartItems}">
        <table class="table table-striped cart-table">
            <thead>
                <tr>
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
                        <td><img src="${pageContext.request.contextPath}/ProductImage?id=${item.variantId}" width="60"></td>
                        <td>${item.productName}</td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> VND</td>
                        <td>
                            <form action="UpdateCart" method="POST">
                                <input type="hidden" name="variantId" value="${item.variantId}">
                                <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input">
                                <button type="submit" class="btn btn-primary btn-sm">🔄</button>
                            </form>
                        </td>
                        <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /> VND</td>
                        <td>
                            <form action="RemoveFromCart" method="POST">
                                <input type="hidden" name="variantId" value="${item.variantId}">
                                <button type="submit" class="btn btn-danger btn-sm">🗑</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- ✅ Form Thanh Toán -->
        <form action="Checkout" method="POST" id="checkoutForm">
            <div class="checkout-container text-center">
                <button type="submit" class="btn btn-success fs-5 px-4">💳 Thanh Toán</button>
            </div>
        </form>
    </c:if>
</div>

<jsp:include page="footer.jsp"/>

<!-- ✅ JavaScript: Tự động ẩn thông báo sau 3 giây -->
<script>
    setTimeout(() => {
        let alertBox = document.getElementById("cartAlert");
        if (alertBox) {
            alertBox.style.display = "none";
        }
    }, 3000);
</script>

</body>
</html>
