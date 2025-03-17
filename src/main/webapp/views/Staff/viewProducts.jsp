<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            color: #343a40;
            margin: 0;
            padding: 0;
        }
        .container-fluid {
            padding: 20px 40px;
        }
        h2 {
            font-weight: 700;
            color: #dc3545;
            text-align: center;
        }
        h2 i {
            margin-right: 10px;
            color: #ff4d4d;
        }
        .breadcrumb {
            background-color: #fff;
            border-radius: 8px;
            padding: 10px 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
            margin-top: 30px;
        }
        .card.product-item {
            width: 100%;
            max-width: 320px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 20px;
            height: 480px; /* Tăng chiều cao để đủ chỗ cho tên sản phẩm dài */
            position: relative;
            overflow: hidden;
        }
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: contain;
            border-radius: 10px;
            transition: transform 0.3s ease-in-out;
        }
        .card:hover .card-img-top {
            transform: scale(1.08);
        }
        .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            text-align: center;
        }
        .product-title {
            font-size: 18px;
            font-weight: 600;
            color: #343a40;
            margin: 15px 0;
            min-height: 60px; /* Đảm bảo đủ không gian cho tên dài */
            overflow: visible; /* Hiển thị đầy đủ tên */
            text-overflow: initial;
            display: block; /* Bỏ giới hạn dòng */
        }
        .product-price {
            font-size: 20px;
            font-weight: 700;
            color: #28a745;
            margin-bottom: 20px;
        }
        .btn-view {
            background-color: #dc3545;
            color: #fff;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s ease-in-out;
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 85%;
        }
        .btn-view:hover {
            background-color: #007bff;
            color: #fff;
            transform: translateX(-50%) scale(1.05);
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }
        .filter-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin: 20px 0;
        }
        .filter-container label {
            font-size: 16px;
            font-weight: 500;
            color: #495057;
        }
        .form-select {
            width: 200px;
            padding: 10px;
            font-size: 16px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }
        .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            outline: none;
        }
        @media (max-width: 768px) {
            .card.product-item {
                max-width: 100%;
                height: 440px; /* Giảm nhẹ chiều cao trên mobile */
            }
            .card-img-top {
                height: 180px;
            }
            .product-title {
                font-size: 16px;
                min-height: 50px; /* Giảm nhẹ trên mobile */
            }
            .product-price {
                font-size: 18px;
            }
            .btn-view {
                padding: 10px 15px;
                font-size: 14px;
            }
            .filter-container {
                flex-direction: column;
                gap: 10px;
            }
            .form-select {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="Dashboard"><p>Xin chào, ${user.name}</p></a>
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
         <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="ViewProducts" method="post">
            <div class="input-group">
                <input class="form-control" type="text" name="search" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                <button class="btn btn-primary" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
            </div>
        </form>
        <ul class="navbar-nav ms-auto ms-md-2 me-3 me-lg-4">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="CustomerProfileDetail?userId=${user.id}">My Profile</a></li>
                    <li><hr class="dropdown-divider" /></li>
                    <li><a class="dropdown-item" href="Logout">Logout</a></li>
                </ul>
            </li>
        </ul>
    </nav>

    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Core</div>
                        <a class="nav-link" href="Dashboard"><div class="sb-nav-link-icon"><i class="fas fa-chart-line"></i></div>Dashboard</a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/OrderList"><div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>Order List</a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/ViewProducts"><div class="sb-nav-link-icon"><i class="fas fa-box-open"></i></div>View Products</a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/CustomerList"><div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>View Customer List</a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarrantyServelet"><div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>View Warranty</a>
                    </div>
                </div>
            </nav>
        </div>
        <div id="layoutSidenav_content">
            <div class="container-fluid px-4">
                <!-- Bỏ tiêu đề Dashboard -->
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">View Products</li>
                </ol>
                <div class="container mt-5">
                    <h2><i class="fas fa-boxes"></i> ${pageTitle}</h2>

                    <!-- Bộ lọc -->
                    <div class="filter-container">
                        <label for="catalogFilter"><i class="fas fa-filter"></i> Lọc theo danh mục:</label>
                        <select id="catalogFilter" class="form-select">
                            <option value="all" selected>Tất cả</option>
                            <option value="1">Laptop</option>
                            <option value="2">Monitor</option>
                            <option value="3">Mouse</option>
                            <option value="4">Keyboard</option>
                            <option value="5">Headphones</option>
                        </select>
                    </div>

                    <!-- Danh sách sản phẩm -->
                    <div class="product-container">
                        <c:forEach var="product" items="${products}">
                            <div class="card product-item" data-catalog="${product.catalog_id}">
                                <img class="card-img-top" src="${product.imageUrl}" alt="${product.name}">
                                <div class="card-body">
                                    <h5 class="product-title">${product.name}</h5>
                                    <p class="product-price">
                                        <fmt:formatNumber value="${product.price}" pattern="#,###" /> VND
                                    </p>
                                </div>
                                <a href="${pageContext.request.contextPath}/ViewProductDetails?product_id=${product.id}" class="btn-view">
                                    <i class="fas fa-eye"></i> Xem chi tiết
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/datatables-simple-demo.js"></script>
        <script>
            document.getElementById("catalogFilter").addEventListener("change", function () {
                let selectedCatalog = this.value;
                document.querySelectorAll(".product-item").forEach(item => {
                    item.style.display = (selectedCatalog === "all" || item.getAttribute("data-catalog") === selectedCatalog) ? "block" : "none";
                });
                localStorage.setItem("selectedCatalog", selectedCatalog);
            });

            window.addEventListener("DOMContentLoaded", function () {
                let storedCatalog = localStorage.getItem("selectedCatalog") || "all";
                document.getElementById("catalogFilter").value = storedCatalog;
                document.querySelectorAll(".product-item").forEach(item => {
                    item.style.display = (storedCatalog === "all" || item.getAttribute("data-catalog") === storedCatalog) ? "block" : "none";
                });
            });
        </script>
    </body>
</html>