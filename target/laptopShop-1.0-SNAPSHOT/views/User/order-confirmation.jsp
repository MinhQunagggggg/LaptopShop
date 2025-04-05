<%-- 
    Document   : order-confirmation
    Created on : Mar 3, 2025, 3:00:03 PM
    Author     : CE182250
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Order Successfully Placed</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<jsp:include page="menu.jsp"/>
<body>
    <div class="container text-center mt-5">
        <h2 class="text-success">🎉 Your Order Has Been Successfully Placed!</h2>
        <c:if test="${not empty sessionScope.paymentMessage}">
    <div class="alert alert-success text-center">
        ${sessionScope.paymentMessage}
    </div>
    <c:remove var="paymentMessage" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.paymentError}">
    <div class="alert alert-danger text-center">
        ${sessionScope.paymentError}
    </div>
    <c:remove var="paymentError" scope="session"/>
</c:if>

        <p><strong>Order ID:</strong> ${sessionScope.orderId}</p>
        <p><strong>Total Amount:</strong> <fmt:formatNumber value="${sessionScope.orderTotal}" pattern="#,###" /> VND</p>

        <h3>📦 Order Details</h3>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Product Name</th>
                    <th>RAM</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${sessionScope.orderDetails}">
                    <tr>
                        <!-- ✅ Display product image -->
                        <td>
                            <img src="${pageContext.request.contextPath}/ProductImage?id=${item.productId}" width="60" class="rounded">
                        </td>
                        <td>${item.productName}</td>
                        <td>${item.ram}</td> <!-- ✅ Added RAM -->
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> VND</td>
                        <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /> VND</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/Home" class="btn btn-primary">🏠 Return to Home</a>
    </div>
</body>
<jsp:include page="footer.jsp"/>
</html>