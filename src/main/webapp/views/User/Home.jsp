<%-- 
    Document   : product-detail
    Created on : Feb 12, 2025, 10:27:24 PM
    Author     : CE182250
--%>

<%@page import="java.util.List"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="model.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
    ProductDAO dao = new ProductDAO();
    List<String> brands = dao.getAllBrands();
    request.setAttribute("brands", brands);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Laptop Shop - Home</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">

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

        /* C?n ch?nh v? trí nút carousel */
        .carousel-control-prev, 
.carousel-control-next {
    width: 8%; /* ?i?u ch?nh kích th??c */
    bottom: -30px; /* ? ??y nút xu?ng d??i s?n ph?m */
    top: auto; /* Lo?i b? top: 50% */
    transform: none; /* Lo?i b? c?n gi?a theo transform */
    z-index: 10; /* ??m b?o nút không b? che */
    position: absolute; /* ??t v? trí tuy?t ??i ?? c?n ch?nh d? h?n */
}

        .carousel-control-prev {
            left: -40px;
        }

        .carousel-control-next {
            right: -40px;
        }

        .carousel-control-prev-icon, 
        .carousel-control-next-icon {
            width: 400px;
            height: 400px;
            background-color: rgba(0, 0, 0, 0);
            border-radius: 50%;
            padding: 10px;
        }

        .carousel-control-prev:hover .carousel-control-prev-icon,
        .carousel-control-next:hover .carousel-control-next-icon {
            background-color: rgba(0, 0, 0, 0.9);
        }
        .mt-3{
            padding-bottom: 50px;
            padding-top: -20px;
        }
       
.highlight {
    border: 3px solid #ffcc00; /* Vi?n vàng ?? làm n?i b?t */
    transition: border 0.3s ease-in-out;
}
.cata{
    padding-left: 40px;
    padding-bottom: 10px;
}

    </style>
</head>

<body>
    <jsp:include page="menu.jsp" />

    
    <!-- Categories Filter - Hi?n th? 3 nút ngang hàng -->
<div class="d-flex justify-content-left gap-3 mt-3 cata">
    <!-- ? L?p danh m?c t? Database (hi?n th? 3 danh m?c ??u tiên) -->
    <c:forEach var="catalog" items="${catalogs}" begin="0" end="2">
        <a href="${pageContext.request.contextPath}/CategoryProducts?category=${catalog}" class="btn btn-outline-primary fw-bold">
            ${catalog}
        </a>
    </c:forEach>     
</div>

<!-- B? l?c giá -->
<div class="container mt-4">
    <div class="row">
        <div class="col-sm-12">
            <div id="slider-range"></div>
        </div>
    </div>
    <div class="row slider-labels mt-2">
        <div class="col-6 text-start">
            <strong>Min:</strong> <span id="slider-range-value1"></span> VND
        </div>
        <div class="col-6 text-end">
            <strong>Max:</strong> <span id="slider-range-value2"></span> VND
        </div>
    </div>
    <!-- Nút l?c giá -->
    <div class="text-center mt-3">
        <button id="filter-price-btn" class="btn btn-primary">OK</button>
    </div>
</div>

<!-- CSS cho thanh tr??t -->
<style>
    #slider-range {
    width: 60%;  /* ? Gi?m chi?u r?ng xu?ng 60% */
    margin: 0 auto; /* ? C?n gi?a thanh tr??t */
}

    #slider-range {
        height: 6px;
        background: #ccc;
        border-radius: 5px;
        position: relative;
    }

    .slider-selection {
        height: 100%;
        background: #345DBB;
        position: absolute;
        border-radius: 5px;
    }

    .slider-handle {
        width: 20px;
        height: 20px;
        background: #345DBB;
        border-radius: 50%;
        position: absolute;
        top: -7px;
        cursor: pointer;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    }
</style>

<!-- Nhúng th? vi?n noUiSlider -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.0/nouislider.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.6.0/nouislider.min.css" />

<!-- JavaScript -->
<script>
    $(document).ready(function () {
        var slider = document.getElementById('slider-range');

        noUiSlider.create(slider, {
            start: [10000000, 30000000], // Giá tr? m?c ??nh
            step: 200000, // B??c nh?y
            range: {
                'min': 0, // Giá tr? nh? nh?t
                'max': 60000000  // Giá tr? l?n nh?t
            },
            format: {
                to: function (value) {
                    return new Intl.NumberFormat('vi-VN').format(value);
                },
                from: function (value) {
                    return Number(value.replace(/,/g, ''));
                }
            },
            connect: true, // Ph?n gi?a ??m h?n
        });

        // Hi?n th? giá tr? ban ??u
        slider.noUiSlider.on('update', function (values, handle) {
            document.getElementById('slider-range-value1').innerHTML = values[0];
            document.getElementById('slider-range-value2').innerHTML = values[1];
        });

        // X? lý khi b?m nút "L?c giá"
        $("#filter-price-btn").click(function () {
            let minPrice = slider.noUiSlider.get()[0].replace(/\D/g, '');
            let maxPrice = slider.noUiSlider.get()[1].replace(/\D/g, '');

            // Chuy?n h??ng ??n trang l?c s?n ph?m theo giá
            window.location.href = "FilterByPrice?minPrice=" + minPrice + "&maxPrice=" + maxPrice;
        });
    });
</script>


    <!-- N?u có k?t qu? tìm ki?m, hi?n th? s?n ph?m tìm th?y -->
    <c:if test="${not empty searchQuery}">
        <div class="container mt-5">
            <h2 class="text-center text-primary mt-3">Search results for "${searchQuery}"</h2>
            
            <div class="row">
                <c:forEach var="product" items="${products}">
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}" class="text-decoration-none">
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

            <c:if test="${empty products}">
                <p class="text-center text-muted">No products found.</p>
            </c:if>
        </div>
    </c:if>

    <!-- N?u có tìm ki?m, ?n danh sách s?n ph?m m?c ??nh -->
    <div class="container product-section mt-5 ${not empty searchQuery ? 'hide-section' : ''}">
        
        


        <c:forEach var="brand" items="${brands}" varStatus="status">
            <div class="brand-section">
                <h2 class="text-center text-primary">${brand}</h2>
                <div id="carousel-${status.index}" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <c:forEach var="product" items="${brandProducts[status.index]}" varStatus="productStatus">
                            <c:if test="${productStatus.index % 4 == 0}">
                                <div class="carousel-item ${productStatus.index == 0 ? 'active' : ''}">
                                    <div class="row">
                            </c:if>

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

                            <c:if test="${productStatus.index % 4 == 3 || productStatus.last}">
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#carousel-${status.index}" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carousel-${status.index}" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </button>
                </div>

                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/BrandProducts?brand=${brand}" class="btn btn-outline-primary">
                        View All Products of ${brand}
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>