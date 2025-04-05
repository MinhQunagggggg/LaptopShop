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
                background-color: #fff;
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
                margin-bottom: 25px;
                font-size: 28px; /* Tăng kích thước tiêu đề */
            }
            h2 i {
                margin-right: 12px;
                color: #ff4d4d;
            }
            .breadcrumb {
                background-color: #fff;           
            }
            .product-container {
                display: grid;
                grid-template-columns: repeat(5, 1fr); /* 5 sản phẩm trên 1 dòng */
                gap: 30px; /* Tăng khoảng cách */
                margin-top: 40px;
            }
            .card.product-item {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease-in-out;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                padding: 25px; /* Tăng padding */
                height: 480px; /* Tăng chiều cao để chứa nội dung */
                position: relative;
                overflow: hidden;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            }
            .card-img-top {
                width: 100%;
                height: 220px; /* Tăng kích thước ảnh */
                object-fit: contain;
                border-radius: 8px;
                transition: transform 0.3s ease-in-out;
            }
            .card:hover .card-img-top {
                transform: scale(1.05);
            }
            .card-body {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-start; /* Đẩy nội dung lên trên */
                text-align: center;
                padding-top: 15px;
                padding-bottom: 60px; /* Thêm padding dưới để dành chỗ cho nút */
            }
            .product-title {
                font-size: 20px; /* Tăng kích thước chữ */
                font-weight: 600;
                color: #343a40;
                margin: 0 0 15px 0; /* Giảm khoảng cách dưới */
                max-height: 60px; /* Giới hạn chiều cao tối đa */
                overflow: hidden; /* Ẩn phần vượt quá */
                text-overflow: ellipsis; /* Thêm dấu ... khi bị cắt */
                display: -webkit-box;
                -webkit-line-clamp: 2; /* Giới hạn 2 dòng */
                -webkit-box-orient: vertical;
            }
            .product-price {
                font-size: 22px; /* Tăng kích thước giá */
                font-weight: 700;
                color: #28a745;
                margin: 0 0 20px 0; /* Giảm khoảng cách để cân đối */
                flex-shrink: 0; /* Đảm bảo không bị co lại */
            }
            .btn-view {
                background-color: #dc3545;
                color: #fff;
                padding: 12px 20px; /* Tăng kích thước nút */
                border-radius: 6px;
                text-decoration: none;
                font-weight: 600;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: all 0.3s ease-in-out;
                position: absolute;
                bottom: 20px; /* Giảm khoảng cách từ dưới lên */
                left: 50%;
                transform: translateX(-50%);
                width: 90%;
                font-size: 18px; /* Tăng cỡ chữ */
            }
            .btn-view:hover {
                background-color: #007bff;
                color: #fff;
                transform: translateX(-50%) scale(1.03);
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
            }
            .filter-container {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 25px; /* Tăng khoảng cách */
                margin: 30px 0;
            }
            .filter-container label {
                font-size: 20px; /* Tăng kích thước chữ */
                font-weight: 500;
                color: #495057;
            }
            .form-select,
            .search-input {
                width: 300px; /* Tăng chiều rộng */
                padding: 14px; /* Tăng padding */
                font-size: 20px; /* Tăng kích thước chữ */
                border-radius: 8px;
                border: 1px solid #ced4da;
                background-color: #fff;
                transition: border-color 0.3s ease;
            }
            .form-select:focus,
            .search-input:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                outline: none;
            }
            .pagination {
                display: flex;
                justify-content: center;
                gap: 15px; /* Tăng khoảng cách */
                margin-top: 50px; /* Tăng khoảng cách trên */
                margin-bottom: 40px;
            }
            .pagination button {
                padding: 12px 24px; /* Tăng kích thước nút */
                border: 1px solid #ced4da;
                border-radius: 6px;
                background-color: #fff;
                cursor: pointer;
                font-size: 18px; /* Tăng kích thước chữ */
                transition: background-color 0.3s ease;
            }
            .pagination button:hover {
                background-color: #e9ecef;
            }
            .pagination button.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }
            .pagination button:disabled {
                cursor: not-allowed;
                opacity: 0.5;
            }
            @media (max-width: 1200px) {
                .product-container {
                    grid-template-columns: repeat(4, 1fr); /* 4 sản phẩm */
                }
                .card.product-item {
                    height: 460px;
                }
            }
            @media (max-width: 992px) {
                .product-container {
                    grid-template-columns: repeat(3, 1fr); /* 3 sản phẩm */
                }
                .card.product-item {
                    height: 440px;
                }
            }
            @media (max-width: 768px) {
                .product-container {
                    grid-template-columns: repeat(2, 1fr); /* 2 sản phẩm */
                }
                .card.product-item {
                    height: 420px;
                }
                .card-img-top {
                    height: 200px;
                }
                .product-title {
                    font-size: 18px;
                    max-height: 54px; /* Điều chỉnh chiều cao tối đa */
                }
                .product-price {
                    font-size: 20px;
                }
                .btn-view {
                    padding: 10px 18px;
                    font-size: 16px;
                }
                .filter-container {
                    flex-direction: column;
                    gap: 20px;
                }
                .form-select,
                .search-input {
                    width: 100%;
                }
            }
            @media (max-width: 576px) {
                .product-container {
                    grid-template-columns: 1fr; /* 1 sản phẩm */
                }
                .card.product-item {
                    height: 400px;
                }
            }
        </style>
    </head>
    <body>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <script>
                // Lấy giá trị từ EL và đảm bảo là string
                const fullName = "${user.name != null ? user.name : 'Guest'}"; // Thêm dấu nháy và xử lý null
                const lastName = fullName.split(" ").pop(); // Lấy tên cuối
                console.log(lastName); // Kết quả: "Minh" nếu fullName là "Tran Nhat Minh"

                // Kiểm tra độ dài lastName và quyết định giá trị hiển thị
                const displayText = lastName.length > 15 ? "Hello, Staff" : "Hello, " + lastName;

                // Gán giá trị vào HTML
                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelector(".navbar-brand p").textContent = displayText;
                });
            </script>
            <a class="navbar-brand ps-3" href="Dashboard"><p></p></a> <!-- Ban đầu để trống -->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" id="searchInput" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <ul class="navbar-nav ms-auto ms-md-2 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <form action="CustomerProfileDetail" method="post" style="display: inline;">
                            <input type="hidden" name="userId" value="${user.id}">
                            <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 6px 12px; text-align: left; width: 100%; color: inherit; cursor: pointer;">My Profile</button>
                        </form>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarranty"><div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>View Warranty</a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">       
                <div class="container-fluid px-4">                  
                    <div class="container mt-5">
                         <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard / ViewProducts</li>
                    </ol>
                        <h2><i class="fas fa-boxes"></i> ${pageTitle}</h2>                   
                        <!-- Bộ lọc -->
                        <div class="filter-container">
                            <label for="catalogFilter"><i class="fas fa-filter"></i> Filter by category:</label>
                            <select id="catalogFilter" class="form-select">
                                <option value="all" selected>All</option>
                                <option value="1">Laptop</option>
                                <option value="2">Monitor</option>
                                <option value="3">Mouse</option>
                                <option value="4">Keyboard</option>
                                <option value="5">Headphones</option>
                            </select>
                        </div>

                        <!-- Danh sách sản phẩm -->
                        <div class="product-container" id="productContainer">
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
                                        <i class="fas fa-eye"></i> View Detail
                                    </a>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Phân trang -->
                        <div class="pagination" id="pagination"></div>
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
                document.addEventListener("DOMContentLoaded", function () {
                    const searchInput = document.getElementById("searchInput");
                    const catalogFilter = document.getElementById("catalogFilter");
                    const productContainer = document.getElementById("productContainer");
                    const allProducts = Array.from(productContainer.querySelectorAll(".product-item"));
                    const paginationContainer = document.getElementById("pagination");
                    const productsPerPage = 10;
                    let currentPage = 1;
                    let filteredProducts = allProducts;

                    // Initial render
                    renderPage(currentPage);
                    renderPagination();

                    // Crisp Search
                    searchInput.addEventListener("input", filterAndPaginate);

                    // Catalog Filter
                    catalogFilter.addEventListener("change", function () {
                        localStorage.setItem("selectedCatalog", this.value);
                        filterAndPaginate();
                    });

                    // Load stored catalog filter
                    let storedCatalog = localStorage.getItem("selectedCatalog") || "all";
                    catalogFilter.value = storedCatalog;

                    function filterAndPaginate() {
                        filterProducts();
                        currentPage = 1; // Reset to first page
                        renderPage(currentPage);
                        renderPagination();
                    }

                    function filterProducts() {
                        const searchValue = searchInput.value.toLowerCase();
                        const catalogValue = catalogFilter.value;

                        filteredProducts = allProducts.filter(product => {
                            const name = product.querySelector(".product-title").textContent.toLowerCase();
                            const catalogId = product.getAttribute("data-catalog");
                            const searchMatch = name.includes(searchValue);
                            const catalogMatch = catalogValue === "all" || catalogId === catalogValue;
                            return searchMatch && catalogMatch;
                        });

                        if (filteredProducts.length === 0) {
                            productContainer.innerHTML = '<p style="text-align: center; grid-column: 1 / -1; font-size: 20px;">No found product.</p>';
                        }
                    }

                    function renderPage(page) {
                        const start = (page - 1) * productsPerPage;
                        const end = start + productsPerPage;
                        const productsToShow = filteredProducts.slice(start, end);

                        if (filteredProducts.length > 0) {
                            productContainer.innerHTML = '';
                            productsToShow.forEach(product => productContainer.appendChild(product));
                        }
                    }

                    function renderPagination() {
                        const totalPages = Math.ceil(filteredProducts.length / productsPerPage);
                        paginationContainer.innerHTML = '';

                        if (totalPages <= 1)
                            return;

                        // Previous button
                        const prevButton = document.createElement("button");
                        prevButton.textContent = "Previous";
                        prevButton.disabled = currentPage === 1;
                        prevButton.addEventListener("click", () => {
                            if (currentPage > 1) {
                                currentPage--;
                                renderPage(currentPage);
                                updatePaginationButtons(totalPages);
                            }
                        });
                        paginationContainer.appendChild(prevButton);

                        // Page buttons (limit to 5)
                        const maxButtons = 5;
                        let startPage = Math.max(1, currentPage - Math.floor(maxButtons / 2));
                        let endPage = Math.min(totalPages, startPage + maxButtons - 1);
                        if (endPage - startPage + 1 < maxButtons) {
                            startPage = Math.max(1, endPage - maxButtons + 1);
                        }

                        for (let i = startPage; i <= endPage; i++) {
                            const pageButton = document.createElement("button");
                            pageButton.textContent = i;
                            pageButton.classList.toggle("active", i === currentPage);
                            pageButton.addEventListener("click", () => {
                                currentPage = i;
                                renderPage(currentPage);
                                updatePaginationButtons(totalPages);
                            });
                            paginationContainer.appendChild(pageButton);
                        }

                        // Next button
                        const nextButton = document.createElement("button");
                        nextButton.textContent = "Next";
                        nextButton.disabled = currentPage === totalPages;
                        nextButton.addEventListener("click", () => {
                            if (currentPage < totalPages) {
                                currentPage++;
                                renderPage(currentPage);
                                updatePaginationButtons(totalPages);
                            }
                        });
                        paginationContainer.appendChild(nextButton);
                    }

                    function updatePaginationButtons(totalPages) {
                        const buttons = paginationContainer.querySelectorAll("button");
                        buttons[0].disabled = currentPage === 1; // Prev
                        buttons.forEach((btn, index) => {
                            if (index > 0 && index < buttons.length - 1) {
                                btn.classList.toggle("active", parseInt(btn.textContent) === currentPage);
                            }
                        });
                        buttons[buttons.length - 1].disabled = currentPage === totalPages; // Next
                    }
                });
        </script>
    </body>
</html>