<%-- 
    Document   : filter-by-price
    Created on : Feb 20, 2025, 4:21:49 PM
    Author     : CE182250
--%>
<%-- 
    Document   : all-products
    Created on : Feb 20, 2025, 10:39:33 AM
    Author     : CE182250
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">
   
</head>
<body>
    <jsp:include page="menu.jsp"/>

    <div class="container mt-5">
    <h2 class="text-center text-primary">Products from <fmt:formatNumber value="${minPrice}" pattern="#,###" /> to <fmt:formatNumber value="${maxPrice}" pattern="#,###" /> VND</h2>

    <div class="row gy-4 my-3">

        <c:forEach var="product" items="${products}">
            <div class="col-md-3 d-flex align-items-stretch">
                <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}" class="text-decoration-none w-100">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/assets/img/aa.png" alt="${product.name}">
                        <div class="card-body text-center">
                            <h5>${product.name}</h5>
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

<style>
        /* Global Styles */
        html, body {
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        


        /* Navbar */
        .navbar {
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* Product Section */
        .product-section {
            margin-top: 20px;
            padding-top: 20px;
        }

        /* ??m b?o các hàng s?n ph?m có kho?ng cách ??u */
        .product-section .row {
            row-gap: 40px;
        }

        /* Card s?n ph?m */
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

        /* ??m b?o hình ?nh có cùng chi?u cao */
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        /* ??m b?o card-body có chi?u cao ??ng nh?t */
        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-body h5 {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            min-height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Giá s?n ph?m */
        .card-body p {
            font-size: 18px;
            font-weight: bold;
            color: #28a745;
            margin-top: auto;
        }

        /* Hover effect */
        .card:hover p {
            color: #218838;
            transform: scale(1.05);
        }
</style>
    <jsp:include page="footer.jsp"/>
</body>
</html>


