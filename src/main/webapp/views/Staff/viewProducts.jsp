<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Global Styles */
        html, body {
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        /* Card sản phẩm */
        .card {
            border: none;
            transition: 0.3s;
            margin-bottom: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            text-align: center;
            padding: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.15);
        }

        /* Hình ảnh sản phẩm */
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        /* Giá sản phẩm */
        .card-body p {
            font-size: 18px;
            font-weight: bold;
            color: #28a745;
        }

        .card:hover p {
            color: #218838;
            transform: scale(1.05);
        }
    </style>
</head> 
<body>

    <div class="container mt-5">
        <h2 class="text-center title-style mt-3">${pageTitle}</h2>

        <div class="row gx-3 gy-4">
            <c:forEach var="product" items="${products}">

                <div class="col-lg-3 col-md-6 col-sm-12 d-flex align-items-stretch">
                    <a href="${pageContext.request.contextPath}/Comment?product_id=${product.id}" class="text-decoration-none w-100">
                        <div class="card">
                            <img class="card-img-top" src="${product.imageUrl}" alt="${product.name}">
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

</body>
</html>
