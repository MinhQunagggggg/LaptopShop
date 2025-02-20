<%-- 
    Document   : menu
    Created on : Feb 14, 2025, 1:11:08 AM
    Author     : CE182250
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="java.util.List" %>
<%@ page import="DAO.ProductDAO" %>
<head>
    <title>Website</title>
    <link href="${pageContext.request.contextPath}/css/styles.css?v=1.0" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/script.js?v=1.0"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"> <!-- ✅ Thêm Bootstrap Icons -->
</head>

<%
    ProductDAO dao = new ProductDAO();
    List<String> accessoryCatalogs = dao.getAccessoryCatalogs(); // Lấy danh mục phụ kiện
    List<String> brands = dao.getAllBrands(); // Lấy danh sách hãng laptop
    request.setAttribute("accessoryCatalogs", accessoryCatalogs);
    request.setAttribute("brands", brands);
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/Home">
            <img src="${pageContext.request.contextPath}/assets/img/logo.jpg" alt="Logo" width="50" height="50" class="rounded-circle">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Menu chính -->
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/AllProducts">All Products</a>
                </li>


                <!-- Hiển thị tất cả thương hiệu ngoại trừ Lenovo -->
                <c:forEach var="brand" items="${brands}">
                    <c:if test="${brand ne 'Lenovo'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/BrandProducts?brand=${brand}">${brand}</a>
                        </li>
                    </c:if>
                </c:forEach>

                <!-- Dropdown Lenovo - Hiển thị trên tất cả các trang -->
                <!-- Dropdown Lenovo - Hiển thị trên tất cả các trang -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/BrandProducts?brand=Lenovo" 
                       id="lenovoDropdown" role="button" data-bs-toggle="dropdown">
                        Lenovo
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item fw-bold" href="${pageContext.request.contextPath}/BrandProducts?brand=Lenovo">
                                All Lenovo
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>

                        <!-- ✅ Lấy danh sách SubBrands từ session để luôn hiển thị -->
                        <c:if test="${not empty sessionScope.subBrandsOfLenovo}">
                            <c:forEach var="subBrand" items="${sessionScope.subBrandsOfLenovo}">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/BrandProducts?brand=Lenovo&subbrand=${subBrand}">
                                        ${subBrand}
                                    </a>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </li>

                <!-- Dropdown Accessories -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="accessoryDropdown" role="button" data-bs-toggle="dropdown">
                        Accessories
                    </a>
                    <ul class="dropdown-menu">
                        <c:forEach var="catalog" items="${accessoryCatalogs}">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ProductList?catalog=${catalog}">${catalog}</a></li>
                            </c:forEach>
                    </ul>
                </li>


                <div class="d-flex align-items-center ms-auto"> 

                    <!-- Search Form -->
                    <form class="d-flex me-3" action="search" method="GET">
                        <input class="form-control me-2" type="search" name="query" 
                               placeholder="Search products..." aria-label="Search" required>
                        <button class="btn btn-outline-success" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </form>

                    <!-- Giỏ hàng -->
                    <a href="${pageContext.request.contextPath}/Cart" class="btn btn-outline-dark me-3">
                        <i class="bi bi-cart-fill"></i> Cart 
                        <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                    </a>


                </div>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <!-- Dropdown User -->
                        <a href="${pageContext.request.contextPath}/Logout" class="btn btn-outline-primary">
                            <i class="bi bi-box-arrow-in-right"></i> Logout
                        </a>
                        <div class="dropdown">
                            <img src="${pageContext.request.contextPath}/assets/img/user.png" 
                                 alt="User" width="40" height="40" 
                                 class="rounded-circle dropdown-toggle" 
                                 id="userMenu" data-bs-toggle="dropdown" role="button" aria-expanded="false">

                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
                                <li class="dropdown-header text-center fw-bold">${sessionScope.user.name}</li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Profile">
                                        <i class="bi bi-person"></i> View Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/EditProfile">
                                        <i class="bi bi-pencil-square"></i> Edit Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ChangePassword">
                                        <i class="bi bi-key"></i> Change Password</a></li>
                                <li><hr class="dropdown-divider"></li>
                            </ul>
                        </div>

                    </c:when>
                    <c:otherwise>
                        <!-- Nút Login -->
                        <a href="${pageContext.request.contextPath}/Login" class="btn btn-outline-primary">
                            <i class="bi bi-box-arrow-in-right"></i> Login
                        </a>
                    </c:otherwise>
                </c:choose>
</div>


                <style>
                    /* ✅ Căn chỉnh Avatar + User Menu */
                    .navbar .dropdown {
                        position: relative;
                    }

                    /* ✅ Định dạng Avatar */
                    .navbar .rounded-circle {
                        border: 2px solid #ddd;
                        transition: all 0.3s ease-in-out;
                    }


                    /* ✅ Hiệu ứng khi hover vào Avatar */
                    .navbar .rounded-circle:hover {
                        transform: scale(1.1);
                        border-color: #007bff;
                    }

                    /* ✅ Dropdown menu đẹp hơn */
                    .navbar .dropdown-menu {
                        min-width: 220px;
                    }

                    /* ✅ Hover vào các item trong dropdown */
                    .navbar .dropdown-item:hover {
                        background-color: #f8f9fa;
                        color: #007bff;
                    }

                    html, body {
                        text-size-adjust: 100%; /* Thay vì -webkit-text-size-adjust */
                    }

                    .some-class {
                        text-align: match-parent; /* Safari hỗ trợ */
                        text-align: -webkit-match-parent; /* Các trình duyệt khác */
                    }

                    body {
                        padding-top: 80px;
                    }

                    /* Định dạng menu */
                    .navbar-nav .nav-item {
                        margin-right: 15px; /* Tăng khoảng cách giữa các thương hiệu */
                    }

                    .navbar-nav .nav-link {
                        font-weight: bold;
                        color: #333;
                    }

                    .navbar-nav .nav-link:hover {
                        color: #007bff;
                    }

                    /* Định dạng dropdown */
                    .dropdown-menu {
                        min-width: 200px;
                    }

                    .dropdown-item:hover {
                        background-color: #f8f9fa;
                        color: #007bff;
                    }
                    .align-items-center {
                        padding-left: 60px;
                    }
                </style>


        </div>
    </div>
</nav>
<!-- Banner Slider -->
<header class="mt-5 pt-3">
    <div id="bannerCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/assets/img/1.png" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/assets/img/2.png" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/assets/img/3.png" class="d-block w-100">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</header>
