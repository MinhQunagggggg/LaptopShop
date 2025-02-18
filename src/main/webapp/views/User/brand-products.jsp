<%-- 
    Document   : brand-products
    Created on : Feb 17, 2025, 10:21:55 PM
    Author     : CE182250
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>All Products of ${brandName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet"> <!-- 🔹 Dùng CSS chung từ home.jsp -->
    <style>
    /* Product Grid */
/* Product Grid */
.products-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px; /* 🔹 Khoảng cách giữa các sản phẩm */
    justify-content: flex-start; /* 🔹 Căn sản phẩm về bên trái */
}

/* Product Card */
.card {
    border: none;
    transition: 0.3s;
    margin-bottom: 30px; /* 🔹 Khoảng cách giữa các hàng */
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    text-align: center;
    padding: 15px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

/* Đảm bảo tất cả card có chiều cao bằng nhau */
.card-body {
    flex-grow: 1; /* Giữ card đồng đều nhau */
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* Đảm bảo hình ảnh có cùng chiều cao */
.card-img-top {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
}

/* Đảm bảo chiều cao tiêu đề sản phẩm đồng nhất */
.card-body h5 {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
    min-height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}

/* Hiển thị giá sản phẩm */
.card-body p {
    font-size: 18px;
    font-weight: bold;
    color: #28a745;
    margin-top: auto;
}

/* Hover effect */
.card:hover {
    transform: scale(1.05);
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.15);
    transition: 0.3s ease-in-out;
}

.card:hover p {
    color: #218838;
    transform: scale(1.05);
}
.a1 {
    color: blue;
    }


    </style>
</head>
<body>
    <jsp:include page="menu.jsp"/>
 
    <div class="container mt-5">
        <h2 class="text-center a1">All Products off ${brandName}</h2>

        <div class="row gx-3 gy-4"> 
            <c:forEach var="product" items="${products}">
                <div class="col-lg-3 col-md-6 col-sm-12 d-flex align-items-stretch"> <!-- 🔹 4 sản phẩm trên màn hình lớn -->
                    <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}" class="text-decoration-none w-100">
                        <div class="card">
                            <img class="card-img-top" src="${pageContext.request.contextPath}/assets/img/aa.png" alt="${product.name}">
                            <div class="card-body text-center">
                                <h5 class="product-title">${product.name}</h5>
                                <p class="text-success fw-bold">
                                    <fmt:formatNumber value="${product.price}" pattern="#,###" /> VND
                                </p>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>


    <jsp:include page="footer.jsp"/>
</body>
</html>