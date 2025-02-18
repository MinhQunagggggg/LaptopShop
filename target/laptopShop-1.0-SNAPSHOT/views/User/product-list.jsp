<%-- 
    Document   : product-list
    Created on : Feb 17, 2025, 11:16:17 PM
    Author     : CE182250
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>${catalogName != null ? catalogName : "All Products"}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">
    <style>
        .products-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: flex-start;
        }

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

        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

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

        .card-body p {
            font-size: 18px;
            font-weight: bold;
            color: #28a745;
            margin-top: auto;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.15);
            transition: 0.3s ease-in-out;
        }

        .card:hover p {
            color: #218838;
            transform: scale(1.05);
        }

        .title-style {
            color: blue;
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center title-style">${catalogName != null ? catalogName : "All Products"}</h2>

        <c:choose>
            <c:when test="${hasBrands}">
                <c:forEach var="brandEntry" items="${brandProducts}">
                    <h3 class="text-primary mt-4">${brandEntry.key}</h3>
                    <div class="row gx-3 gy-4">
                        <c:forEach var="product" items="${brandEntry.value}">
                            <div class="col-lg-3 col-md-6 col-sm-12 d-flex align-items-stretch">
                                <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}" class="text-decoration-none w-100">
                                    <div class="card">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/assets/img/${product.imageUrl}" alt="${product.name}">
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
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="row gx-3 gy-4">
                    <c:forEach var="product" items="${allProducts}">
                        <div class="col-lg-3 col-md-6 col-sm-12 d-flex align-items-stretch">
                            <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}" class="text-decoration-none w-100">
                                <div class="card">
                                    <img class="card-img-top" src="${pageContext.request.contextPath}/assets/img/${product.imageUrl}" alt="${product.name}">
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
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>
