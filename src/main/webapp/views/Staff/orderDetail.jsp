<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .product {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
        }
        .product img {
            width: 150px;
            height: auto;
            margin-right: 20px;
            border-radius: 8px;
        }
        .product-info {
            flex-grow: 1;
        }
        .btn-back {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center">Chi tiết đơn hàng</h2>
        <hr>

        <c:choose>
            <c:when test="${not empty orderDetails}">
                <c:forEach var="detail" items="${orderDetails}">
                    <div class="product">
                        <c:choose>
                            <c:when test="${not empty detail.imageUrl}">
                                <img src="${detail.imageUrl}" alt="Product Image">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/default-product.jpg" alt="No Image">
                            </c:otherwise>
                        </c:choose>
                        <div class="product-info">
                            <h4>${detail.productName}</h4>
                            <p>${detail.description}</p>
                            <p><strong>Status:</strong> ${detail.status}</p>
                            <p><strong>Số lượng:</strong> ${detail.quantity}</p>
                            <p><strong>Giá:</strong> 
                                <fmt:formatNumber value="${detail.price}" pattern="#,###" /> VND
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-center">Không có sản phẩm nào trong đơn hàng này.</p>
            </c:otherwise>
        </c:choose>

        <div class="btn-back">
            <a href="OrderList" class="btn btn-primary">Quay lại danh sách đơn hàng</a>
        </div>
    </div>

</body>
</html>
