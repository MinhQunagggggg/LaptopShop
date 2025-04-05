<%@page import="modelAdmin.ProductAdmin"%>
<<<<<<< HEAD
<%@page import="modelAdmin.Category"%>
<%@page import="modelAdmin.Brand"%>
<%@page import="DAOAdmin.BrandDAO"%>
<%@page import="DAOAdmin.CategoryDAO"%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="productDAO" class="DAOAdmin.ProductDAO" scope="request"/>
<%
    List<Category> categories = new CategoryDAO().getAllCategoriesMNgoc();
    List<Brand> brands = new BrandDAO().getAllBrandsMNgoc();

   
=======
<%@page import="modelAdmin.ProductVariant"%>
<%@page import="modelAdmin.Category"%>
<%@page import="modelAdmin.Brand"%>
<%@page import="modelAdmin.Catalog"%>
<%@page import="DAOAdmin.CatalogDAO"%>
<%@page import="DAOAdmin.BrandDAO"%>
<%@page import="DAOAdmin.CategoryDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="productDAO" class="DAOAdmin.ProductDAO" scope="request"/>

<%
    List<Category> categories = new CategoryDAO().getAllCategoriesMNgoc();
    List<Brand> brands = new BrandDAO().getAllBrandsMNgoc();
    List<Catalog> catalogs = new CatalogDAO().getAllCatalogsMNgoc();

>>>>>>> 37dc03119998d49183623c576df4bc9542129ece
    Map<Integer, String> categoryMap = new HashMap<>();
    for (Category c : categories) {
        categoryMap.put(c.getCategoryId(), c.getName());
    }

    Map<Integer, String> brandMap = new HashMap<>();
    for (Brand b : brands) {
        brandMap.put(b.getBrandId(), b.getName());
    }
<<<<<<< HEAD
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                height: 100vh;
                background-color: #343a40;
                color: white;
                padding-top: 20px;
                position: fixed;
                width: 250px;
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                padding: 10px;
                display: block;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            .content {
                margin-left: 260px;
                padding: 20px;
            }
            .table img {
                max-width: 70px;
                height: auto;
                border-radius: 8px;
                border: 1px solid #ddd;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4 class="text-center">Dashboard</h4>
            <a href="#">Quản lý sản phẩm</a>
            <ul class="list-unstyled ps-3">
                <li><a href="/add-product">Thêm sản phẩm</a></li>
                <li><a href="/list-products">Danh sách sản phẩm</a></li>
            </ul>
        </div>

        <div class="content">
            <h2 class="text-center mb-4 text-secondary">📋 Danh Sách Sản Phẩm</h2>
            <table class="table table-bordered table-hover">
                <thead>
                    <tr class="text-center">
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Mô tả</th>
                        <th>Danh mục</th>
                        <th>Thương hiệu</th>
                        <th>Hình ảnh</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<ProductAdmin> productList = (List<ProductAdmin>) request.getAttribute("productList");
                        if (productList != null && !productList.isEmpty()) {
                            for (ProductAdmin product : productList) {%>
                    <tr class="align-middle">
                        <td class="text-center"><%= product.getProductId()%></td>
                        <td><%= product.getName()%></td>
                        <td><%= product.getDescription()%></td>
                        <td class="text-center"><%= categoryMap.get(product.getCategoryId())%></td>
                        <td class="text-center"><%= brandMap.get(product.getBrandId())%></td>
                        <td class="text-center">
                            <% if (product.getImageData() != null) {%>
                            <img src="imageServlet?productId=<%= product.getProductId()%>" alt="Ảnh sản phẩm">
                            <% } else { %>
                            <span class="empty-message">Không có ảnh</span>
                            <% }%>
                        </td>
                        <td class="text-center">
                            <a href="EditProductServlet?productId=<%= product.getProductId()%>" class="btn btn-warning">✏ Sửa</a>
                            <a href="delete-product?productId=<%= product.getProductId()%>" class="btn btn-danger"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">🗑 Xóa</a>
                            <a href="${pageContext.request.contextPath}/updateProduct?productId=<%= product.getProductId()%>" 
                               class="btn btn-info">🔄 Cập nhật chi tiết</a>
                        </td>
                    </tr>
                    <%  }
                } else { %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">Không có sản phẩm nào.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
=======
    
    Map<Integer, String> catalogMap = new HashMap<>();
    for (Catalog c : catalogs) {
        catalogMap.put(c.getCatalogId(), c.getName());
    }

    // Định dạng tiền tệ VND
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Danh Sách Sản Phẩm - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/stylesAdmin.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            :root {
                --primary-color: #2c7be5;
                --secondary-color: #e9ecef;
                --text-color: #212529;
                --hover-color: #f8f9fa;
                --warning-color: #ef476f;
            }

            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                overflow: hidden;
            }

            .card-header {
                background: linear-gradient(135deg, var(--primary-color), #4dabf7);
                color: white;
                padding: 1.5rem;
                border-bottom: none;
            }

            .table {
                margin-bottom: 0;
                background: white;
            }

            .table th {
                background: var(--secondary-color);
                border-bottom: 2px solid #dee2e6;
                padding: 12px;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.9rem;
            }

            .table td {
                padding: 12px;
                vertical-align: middle;
                border-bottom: 1px solid #eef2f7;
            }

            .btn-action {
                padding: 6px 15px;
                border-radius: 20px;
                font-size: 0.9rem;
                transition: all 0.3s ease;
            }

            .btn-edit {
                background: #ffd166;
                color: #333;
                border: none;
            }

            .btn-edit:hover {
                background: #ffca4b;
                color: #333;
            }

            .btn-delete {
                background: var(--warning-color);
                color: white;
                border: none;
            }

            .btn-delete:hover {
                background: #e6335a;
                color: white;
            }

            .product-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
                border: 1px solid var(--secondary-color);
                transition: transform 0.2s ease;
            }

            .product-image:hover {
                transform: scale(1.1);
            }

            .search-container {
                max-width: 400px;
                margin-bottom: 20px;
            }

            .stock-warning {
                color: var(--warning-color);
                font-weight: 500;
            }

            .price {
                color: #28a745;
                font-weight: 500;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/Home">
                <img src="${pageContext.request.contextPath}/assets/img/logoDashboard.png" 
                     alt="Logo" width="120" height="120" 
                     style="display: block; margin: auto; margin-top: 50px; filter: brightness(1.3);">
            </a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <button class="btn btn-outline-secondary align-items-center fs-7 py-1 px-2 mt-5 me-1" 
                                type="button" id="userMenu" data-bs-toggle="dropdown">
                            <span class="fw-medium">${sessionScope.user.name} (Admin)</span>
                        </button>
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="statistics">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Thống Kê
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Thêm sản phẩm
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="add-product">Laptop</a>
                                    <a class="nav-link" href="AddMonitor">Màn hình</a>
                                    <a class="nav-link" href="AddMouse">Chuột</a>
                                    <a class="nav-link" href="AddKeyboard">Bàn phím</a>
                                    <a class="nav-link" href="AddHeadphone">Tai nghe</a>
                                </nav>
                            </div>
                            <a class="nav-link" href="list-products">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Danh sách sản phẩm
                            </a>
                            <a class="nav-link" href="staff-list">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Quản lí nhân viên
                            </a>
                            
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    
                                    
                                    
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="401.html">401 Page</a>
                                            <a class="nav-link" href="404.html">404 Page</a>
                                            <a class="nav-link" href="500.html">500 Page</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            
                        </div>
                    </div>
                    
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4 py-5">
                        <div class="card">
                            <div class="card-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h2 class="mb-0">
                                        <i class="fas fa-box-open me-2"></i>Danh Sách Sản Phẩm
                                    </h2>

                                </div>
                            </div>
                            <div class="card-body p-4">

                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr class="text-center">
                                                <th>ID</th>
                                                <th>Tên Sản Phẩm</th>
                                                <th>Giá</th>
                                                <th>Tồn Kho</th>
                                                <th>Phân Loại</th>
                                                <th>Hình Ảnh</th>
                                                <th>Hành Động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                            List<ProductAdmin> productList = (List<ProductAdmin>) request.getAttribute("productList");
                                            List<ProductVariant> variantList = (List<ProductVariant>) request.getAttribute("variantList");
                                            if (productList != null && !productList.isEmpty() && variantList != null && !variantList.isEmpty()) {
                                                for (ProductAdmin product : productList) {
                                                    // Tìm variant đầu tiên phù hợp với productId
                                                    ProductVariant variant = variantList.stream()
                                                        .filter(v -> v.getProductId() == product.getProductId())
                                                        .findFirst()
                                                        .orElse(null);
                                            %>
                                            <tr>
                                                <td class="text-center"><%= product.getProductId() %></td>
                                                <td><%= product.getName() %></td>
                                                <td class="text-center price">
                                                    <%= variant != null ? currencyFormat.format(variant.getPrice()) : "Chưa có giá" %>
                                                </td>
                                                <td class="text-center <%= variant != null && variant.getStock() < 10 ? "stock-warning" : "" %>">
                                                    <%= variant != null ? variant.getStock() : "0" %>
                                                </td>
                                                <td class="text-center"><%= catalogMap.get(product.getCatalogId()) %></td>
                                                <td class="text-center">
                                                    <% if (product.getImageData() != null) { %>
                                                    <img src="imageServlet?productId=<%= product.getProductId() %>" 
                                                         alt="Product" class="product-image">
                                                    <% } else { %>
                                                    <span class="text-muted">Không có ảnh</span>
                                                    <% } %>
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/<%= 
                                                    product.getCatalogId() == 1 ? "updateProduct" :
                                                    product.getCatalogId() == 2 ? "updateMonitor" :
                                                    product.getCatalogId() == 3 ? "updateMouse" :
                                                    product.getCatalogId() == 4 ? "updateKeyboard" :
                                                    product.getCatalogId() == 5 ? "updateHeadphone" : "" %>?productId=<%= product.getProductId() %>" 
                                                       class="btn btn-edit btn-action me-2">
                                                        <i class="fas fa-edit me-1"></i>Cập nhật
                                                    </a>
                                                    <a href="delete-product?productId=<%= product.getProductId() %>" 
                                                       class="btn btn-delete btn-action"
                                                       onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?')">
                                                        <i class="fas fa-trash me-1"></i>Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                            <% 
                                                }
                                            } else { %>
                                            <tr>
                                                <td colspan="7" class="text-center py-4 text-muted">
                                                    <i class="fas fa-exclamation-circle me-2"></i>
                                                    Chưa có sản phẩm nào
                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
        <script>
                                                           document.addEventListener('DOMContentLoaded', function () {
                                                               const dataTable = new simpleDatatables.DataTable(".table", {
                                                                   searchable: true,
                                                                   fixedHeight: true,
                                                                   perPage: 10,
                                                                   labels: {
                                                                       placeholder: "Tìm kiếm...",
                                                                       perPage: "{select} sản phẩm mỗi trang",
                                                                       noRows: "Không tìm thấy sản phẩm",
                                                                       info: "Hiển thị {start} đến {end} của {rows} sản phẩm"
                                                                   }
                                                               });
                                                           });
        </script>
    </body>
</html>
>>>>>>> 37dc03119998d49183623c576df4bc9542129ece
