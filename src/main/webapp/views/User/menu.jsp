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
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top px-4 py-2"> <%-- 🛠 Thêm padding trên dưới để cân đối --%>
    <div class="container-fluid">  

        <!-- 🔹 Logo (Lớn hơn một chút) -->
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/Home">
            <img src="${pageContext.request.contextPath}/assets/img/logo.jpg" 
                 alt="Logo" width="90" height="90" class="rounded-circle border shadow-sm"> <%-- 🛠 Tăng size logo & thêm viền nhẹ --%>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <!-- 🔹 Menu chính (Brand, Accessories) - Căn trái -->
            <ul class="navbar-nav me-auto fs-5">  <%-- 🛠 fs-5 để tăng font size --%>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/AllProducts">All Products</a></li>

                <c:forEach var="brand" items="${brands}">
                    <c:if test="${brand ne 'Lenovo'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/BrandProducts?brand=${brand}">${brand}</a>
                        </li>
                    </c:if>
                </c:forEach>

                <!-- 🔹 Dropdown Lenovo -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/BrandProducts?brand=Lenovo"
                       id="lenovoDropdown" role="button" data-bs-toggle="dropdown">Lenovo</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item fw-bold" href="${pageContext.request.contextPath}/BrandProducts?brand=Lenovo">All Lenovo</a></li>
                        <li><hr class="dropdown-divider"></li>
                            <c:if test="${not empty sessionScope.subBrandsOfLenovo}">
                                <c:forEach var="subBrand" items="${sessionScope.subBrandsOfLenovo}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/BrandProducts?brand=Lenovo&subbrand=${subBrand}">${subBrand}</a></li>
                                </c:forEach>
                            </c:if>
                    </ul>
                </li>

                <!-- 🔹 Dropdown Accessories -->
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
            </ul>

            <!-- 🔹 Search, Cart, User - Căn phải -->
            <div class="d-flex align-items-center ms-auto fs-5">  <%-- 🛠 fs-5 để tăng font size --%>

                <!-- Search Form -->
                <form class="d-flex me-4" action="search" method="GET">
                    <input class="form-control me-2 fs-5" type="search" name="query" 
                           placeholder="Search products..." aria-label="Search" required>
                    <button class="btn btn-outline-success fs-5" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
                <a href="${pageContext.request.contextPath}/ViewOrder" class="btn btn-outline-dark me-4 fs-5">
                    <i class="bi bi-receipt"></i> Order 

                </a>

                <a href="${pageContext.request.contextPath}/Cart" class="btn btn-outline-dark me-4 fs-5">
                    <i class="bi bi-cart-fill"></i> Cart 
                    <span class="badge bg-dark text-white ms-1 rounded-pill fs-6">
                        ${sessionScope.cartSize != null ? sessionScope.cartSize : 0}
                    </span>
                </a>




                <!-- 🔹 User Menu -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle d-flex align-items-center fs-5" type="button" id="userMenu" data-bs-toggle="dropdown">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.avatarData}">
                                        <img src="${pageContext.request.contextPath}/UserImage?id=${sessionScope.user.id}" 
                                             alt="User" width="42" height="42" class="rounded-circle border shadow-sm me-2">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/user.png" 
                                             alt="User" width="42" height="42" class="rounded-circle border shadow-sm me-2">
                                    </c:otherwise>
                                </c:choose>
                                <%-- 🛠 Giảm size avatar + viền + hiệu ứng --%>
                                <span class="fw-bold">${sessionScope.user.name}</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end fs-5" aria-labelledby="userMenu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ViewProfile"><i class="bi bi-person"></i> View Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/EditProfile"><i class="bi bi-pencil-square"></i> Edit Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ChangePassword"><i class="bi bi-key"></i> Change Password</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/WarrantyInfo"><i class="bi bi-shield-check"></i> Warranty</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/Logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/Login" class="btn btn-outline-primary fs-5">
                            <i class="bi bi-box-arrow-in-right"></i> Login
                        </a>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</nav>


<style>
    /* ✅ Căn chỉnh navbar & padding */
    .navbar {
        padding: 12px 30px; /* 🔹 Tăng padding hai bên */
    }

    /* ✅ Căn chỉnh logo */
    .navbar .navbar-brand img {
        width: 45px; /* 🔹 Điều chỉnh size logo */
        height: 45px;
        border: 2px solid #ddd;
        transition: all 0.3s ease-in-out;
    }

    /* ✅ Hiệu ứng hover vào logo */
    .navbar .navbar-brand img:hover {
        transform: scale(1.1);
        border-color: #007bff;
    }

    /* ✅ Căn chỉnh khoảng cách giữa các mục */
    .navbar .navbar-nav .nav-item {
        margin-right: 15px;
        font-size: 18px; /* 🔹 Font chữ to hơn */
    }

    /* ✅ Điều chỉnh kích thước avatar */
    .navbar .rounded-circle {
        width: 32px; /* 🔹 Avatar nhỏ hơn */
        height: 32px;
        border: 2px solid #ddd;
        transition: all 0.3s ease-in-out;
    }

    /* ✅ Hiệu ứng khi hover vào avatar */
    .navbar .rounded-circle:hover {
        transform: scale(1.1);
        border-color: #007bff;
    }

    /* ✅ Điều chỉnh dropdown menu */
    .navbar .dropdown-menu {
        min-width: 240px;
    }

    /* ✅ Hover vào item trong dropdown */
    .navbar .dropdown-item:hover {
        background-color: #f8f9fa;
        color: #007bff;
    }

    /* ✅ Căn chỉnh khoảng cách các thành phần */
    .navbar-nav .nav-link {
        font-weight: bold;
        color: #333;
    }

    .navbar-nav .nav-link:hover {
        color: #007bff;
    }

    /* ✅ Điều chỉnh giỏ hàng và nút search */
    .navbar .btn-outline-dark, .navbar .btn-outline-success {
       font-size: 14px;
        padding: 6px 12px;
    }

    /* ✅ Căn chỉnh toàn bộ menu */
    .navbar .d-flex.align-items-center {
        padding-left: 40px; /* 🔹 Điều chỉnh để cân đối */
    }

</style>
<!-- Banner Slider -->
<header class="mt-5 pt-4">
    <div id="bannerCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/assets/img/1_1.png" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/assets/img/2_1.png" class="d-block w-100">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/assets/img/3_1.png" class="d-block w-100">
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
