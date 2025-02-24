<%-- 
    Document   : checkout
    Created on : Feb 24, 2025, 2:13:30 AM
    Author     : CE182250
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Thanh Toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="menu.jsp"/>

<div class="container mt-5">
    <h2 class="text-primary text-center">💳 Thanh Toán</h2>

    <c:if test="${empty checkoutItems}">
        <p class="text-center text-muted">Không có sản phẩm nào để thanh toán.</p>
    </c:if>

    <c:if test="${not empty checkoutItems}">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Tổng</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${checkoutItems}">
                    <tr>
                        <td><img src="${pageContext.request.contextPath}/ProductImage?id=${item.variantId}" width="60"></td>
                        <td>${item.productName}</td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> VND</td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /> VND</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="text-end">
            <h4 class="text-danger">Tổng tiền: 
                <fmt:formatNumber value="${totalAmount}" pattern="#,###" /> VND
            </h4>
            <button class="btn btn-success fs-5 px-4">✔ Xác nhận Thanh Toán</button>
        </div>
    </c:if>
</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
