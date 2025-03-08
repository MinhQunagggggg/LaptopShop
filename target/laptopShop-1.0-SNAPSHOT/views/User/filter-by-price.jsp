<%-- 
    Document   : filter-by-price
    Created on : Feb 20, 2025, 4:21:49 PM
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
    

     <c:if test="${empty searchQuery}"> 
            <!-- Categories Filter - Hi?n th? 3 nút ngang hàng -->
            <div class="d-flex justify-content-center gap-3 mt-3 cata">
                <!-- ? L?p danh m?c t? Database (hi?n th? 3 danh m?c ??u tiên) -->
                <c:forEach var="catalog" items="${catalogs}" begin="0" end="2">
                    <a href="${pageContext.request.contextPath}/CategoryProducts?category=${catalog}" class="btn btn-outline-primary fw-bold">
                        ${catalog}
                    </a>
                </c:forEach>     
            </div>

            <!-- B? l?c giá trong khung -->
            <div class="container mt-4">
                <div class="card p-3 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title text-center fw-bold text-primary">Filter by Price</h5>

                        <!-- Thanh tr??t -->
                        <div class="row">
                            <div class="col-sm-12">
                                <div id="slider-range"></div>
                            </div>
                        </div>

                        <!-- Hi?n th? giá Min - Max -->
                        <div class="row slider-labels mt-3">
                            <div class="col-6 text-start">
                                <strong>Min:</strong> <span id="slider-range-value1"></span> VND
                            </div>
                            <div class="col-6 text-end">
                                <strong>Max:</strong> <span id="slider-range-value2"></span> VND
                            </div>
                        </div>

                        <!-- Nút L?c Giá -->
                        <div class="text-center mt-3">
                            <button id="filter-price-btn" class="btn btn-primary fw-bold px-4">OK</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

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

<h2 class="text-center text-primary">Products from <fmt:formatNumber value="${minPrice}" pattern="#,###" /> to <fmt:formatNumber value="${maxPrice}" pattern="#,###" /> VND</h2>
        <c:if test="${not empty searchQuery}">
            <div class="container mt-5">
                <h2 class="text-center text-primary mt-3">Search results for "${searchQuery}"</h2>

                <div class="row">
                    <c:forEach var="product" items="${products}">
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}" class="text-decoration-none">
                                <div class="card">
                                   <img class="card-img-top" src="${pageContext.request.contextPath}/ProductImage?id=${product.id}" alt="${product.name}">

                                    
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
    
    
    <div class="row gy-4 my-3">

        <c:forEach var="product" items="${products}">
            <div class="col-md-3 d-flex align-items-stretch">
                <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}" class="text-decoration-none w-100">
                    <div class="card">
                       <img class="card-img-top" src="${pageContext.request.contextPath}/ProductImage?id=${product.id}" alt="${product.name}">

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


