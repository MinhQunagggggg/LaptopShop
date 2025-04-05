<%@page import="modelAdmin.Category"%>
<%@page import="modelAdmin.Brand"%>
<%@page import="modelAdmin.SubBrand"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<String> ramList = (List<String>) request.getAttribute("ramList");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/stylesAdmin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: "Poppins", sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
            }

            #layoutSidenav_content {
                padding-top: 50px;
            }

            .form-container {
                width: 100%;
                max-width: 900px;
                background: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                animation: fadeIn 0.5s ease-in-out;
                margin: 0 auto;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            h2 {
                text-align: center;
                color: #1a73e8;
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: 700;
                letter-spacing: 0.5px;
            }

            h3 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
                font-size: 20px;
                font-weight: 600;
            }

            label {
                font-weight: 600;
                color: #2c3e50;
                margin-top: 15px;
                display: block;
            }

            input, textarea, select {
                width: 100%;
                padding: 12px 15px;
                margin-top: 6px;
                border: 1px solid #dcdcdc;
                border-radius: 8px;
                font-size: 14px;
                background: #f8fafc;
                transition: all 0.3s ease;
            }

            input:focus, textarea:focus, select:focus {
                border-color: #1a73e8;
                box-shadow: 0 0 10px rgba(26, 115, 232, 0.2);
                background: #fff;
            }

            textarea {
                resize: vertical;
                min-height: 80px;
            }

            select {
                appearance: none;
                background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 20 20"%3E%3Cpath fill="%232c3e50" d="M10 12l4-4h-8z"/%3E%3C/svg%3E') no-repeat right 15px center;
                background-size: 12px;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .full-width {
                grid-column: span 2;
            }

            .variant-section {
                background: #f9fbfc;
                padding: 20px;
                border-radius: 10px;
                margin-top: 20px;
            }

            .submit-btn {
                width: 100%;
                background: linear-gradient(135deg, #1a73e8, #0d47a1);
                color: white;
                padding: 14px;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                margin-top: 30px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .submit-btn:hover {
                background: linear-gradient(135deg, #0d47a1, #1a73e8);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(26, 115, 232, 0.4);
            }

            #cpu-tree {
                margin-top: 10px;
                background: #fff;
                border: 1px solid #dcdcdc;
                border-radius: 8px;
                padding: 10px;
                max-height: 200px;
                overflow-y: auto;
            }

            .error {
                color: #e63946;
                font-size: 12px;
                margin-top: 4px;
                display: block;
            }

            @media (max-width: 768px) {
                .form-grid {
                    grid-template-columns: 1fr;
                }
                .full-width {
                    grid-column: span 1;
                }
                .form-container {
                    padding: 20px;
                }
            }

            #ram-forms {
                margin-top: 15px;
            }

            .variant-form {
                margin: 10px 0;
                padding: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                display: none; /* Ẩn mặc định */
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
                    <div class="form-container">
                        <h2>Thêm Laptop</h2>
                        <form action="add-product" method="post" enctype="multipart/form-data" id="productForm" onsubmit="return validateForm(event)">
                            <div class="form-grid">
                                <div class="full-width">
                                    <label>Tên sản phẩm:</label>
                                    <input type="text" id="product-name" name="name" required placeholder="Nhập tên sản phẩm">
                                </div>
                                <div class="full-width">
                                    <label>Mô tả:</label>
                                    <textarea name="description" placeholder="Nhập mô tả sản phẩm"></textarea>
                                </div>
                                <div>
                                    <label>Danh mục:</label>
                                    <select name="category_id" required>
                                        <option value="" disabled selected>-- Chọn danh mục --</option>
                                        <% for (Category c : new DAOAdmin.CategoryDAO().getAllCategoriesMNgoc()) { %>
                                        <option value="<%= c.getCategoryId() %>"><%= c.getName() %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div>
                                    <label>Thương hiệu:</label>
                                    <select id="brand_id" name="brand_id" required onchange="toggleSubBrand()">
                                        <option value="" disabled selected>-- Chọn thương hiệu --</option>
                                        <% for (Brand b : new DAOAdmin.BrandDAO().getAllBrandsMNgoc()) { %>
                                        <option value="<%= b.getBrandId() %>"><%= b.getName() %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div id="subbrand_div" style="display: none;">
                                    <label>Sub-Brand:</label>
                                    <select id="subbrand_id" name="subbrand_id">
                                        <option value="" disabled selected>-- Chọn sub-brand --</option>
                                        <% for (SubBrand sb : new DAOAdmin.SubBrandDAO().getAllSubBrandsMNgoc()) { %>
                                        <option value="<%= sb.getSubBrandId() %>"><%= sb.getName() %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="full-width">
                                    <label>Hình ảnh:</label>
                                    <input type="file" name="image_data" accept="image/*" required>
                                </div>
                            </div>

                            <input type="hidden" name="catalog_id" value="1">

                            <h3>Thông số Laptop</h3>
                            <div class="form-grid">
                                <div>
                                    <label>CPU:</label>
                                    <input type="text" id="cpu-input" name="cpu" readonly placeholder="Chọn CPU từ danh sách">
                                    <div id="cpu-tree"></div>
                                </div>
                                <div>
                                    <label>Ổ cứng:</label>
                                    <select id="storage-select" name="storage" required>
                                        <option value="" disabled selected>Chọn dung lượng</option>
                                        <option value="128GB">128GB</option>
                                        <option value="256GB">256GB</option>
                                        <option value="512GB">512GB</option>
                                        <option value="1TB">1TB</option>
                                        <option value="2TB">2TB</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Độ phân giải:</label>
                                    <select name="resolution" required>
                                        <option value="" disabled selected>Chọn độ phân giải</option>
                                        <option value="1366x768">1366x768</option>
                                        <option value="1920x1080">1920x1080 (Full HD)</option>
                                        <option value="2560x1440">2560x1440 (2K)</option>
                                        <option value="3840x2160">3840x2160 (4K UHD)</option>
                                        <option value="5120x2880">5120x2880 (5K)</option>
                                        <option value="7680x4320">7680x4320 (8K)</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Card đồ họa:</label>
                                    <select id="graphics-select" name="graphics" required>
                                        <option value="" disabled selected>Chọn card đồ họa</option>
                                        <option value="Intel UHD Graphics">Intel UHD Graphics</option>
                                        <option value="Intel Iris Xe Graphics">Intel Iris Xe Graphics</option>
                                        <option value="NVIDIA GeForce GTX 1650">NVIDIA GeForce GTX 1650</option>
                                        <option value="NVIDIA GeForce RTX 3050">NVIDIA GeForce RTX 3050</option>
                                        <option value="NVIDIA GeForce RTX 3060">NVIDIA GeForce RTX 3060</option>
                                        <option value="NVIDIA GeForce RTX 3070">NVIDIA GeForce RTX 3070</option>
                                        <option value="NVIDIA GeForce RTX 3080">NVIDIA GeForce RTX 3080</option>
                                        <option value="NVIDIA GeForce RTX 3090">NVIDIA GeForce RTX 3090</option>
                                        <option value="AMD Radeon RX 6600">AMD Radeon RX 6600</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Cổng kết nối:</label>
                                    <select name="ports" required>
                                        <option value="" disabled selected>Chọn cổng kết nối</option>
                                        <option value="USB-A, USB-C, HDMI">USB-A, USB-C, HDMI</option>
                                        <option value="USB-C, Thunderbolt 4">USB-C, Thunderbolt 4</option>
                                        <option value="HDMI, DisplayPort">HDMI, DisplayPort</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Không dây:</label>
                                    <select name="wireless" required>
                                        <option value="" disabled selected>Chọn kết nối không dây</option>
                                        <option value="Wi-Fi 5, Bluetooth 5.0">Wi-Fi 5, Bluetooth 5.0</option>
                                        <option value="Wi-Fi 6, Bluetooth 5.1">Wi-Fi 6, Bluetooth 5.1</option>
                                        <option value="Wi-Fi 6E, Bluetooth 5.2">Wi-Fi 6E, Bluetooth 5.2</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Camera:</label>
                                    <select name="camera" required>
                                        <option value="" disabled selected>Chọn camera</option>
                                        <option value="720p HD">720p HD</option>
                                        <option value="1080p Full HD">1080p Full HD</option>
                                        <option value="IR Camera (Windows Hello)">IR Camera (Windows Hello)</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Pin:</label>
                                    <select name="battery" required>
                                        <option value="" disabled selected>Chọn dung lượng pin</option>
                                        <option value="3-cell 42Wh">3-cell 42Wh</option>
                                        <option value="4-cell 56Wh">4-cell 56Wh</option>
                                        <option value="6-cell 99Wh">6-cell 99Wh</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Kích thước:</label>
                                    <input type="text" name="dimensions" id="dimensions" placeholder="Rộng x Cao x Dày (VD: 400x300x20)">
                                </div>
                                <div>
                                    <label>Trọng lượng (kg):</label>
                                    <input type="number" name="weight" id="weight" step="0.01" min="0" placeholder="Nhập trọng lượng">
                                </div>
                                <div>
                                    <label>Bàn phím:</label>
                                    <select name="keyboard" required>
                                        <option value="" disabled selected>Chọn loại bàn phím</option>
                                        <option value="Có đèn nền">Có đèn nền</option>
                                        <option value="Không có đèn nền">Không có đèn nền</option>
                                        <option value="Cảm biến vân tay">Cảm biến vân tay</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Chất liệu:</label>
                                    <select name="material" required>
                                        <option value="" disabled selected>Chọn chất liệu</option>
                                        <option value="Nhôm">Nhôm</option>
                                        <option value="Nhựa">Nhựa</option>
                                        <option value="Carbon Fiber">Carbon Fiber</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Bảo hành:</label>
                                    <select name="warranty" required>
                                        <option value="" disabled selected>Chọn thời gian bảo hành</option>
                                        <option value="12 tháng">12 tháng</option>
                                        <option value="24 tháng">24 tháng</option>
                                        <option value="36 tháng">36 tháng</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Hệ điều hành:</label>
                                    <select name="os" required>
                                        <option value="" disabled selected>Chọn hệ điều hành</option>
                                        <option value="Windows 10">Windows 10</option>
                                        <option value="Windows 11">Windows 11</option>
                                        <option value="macOS">macOS</option>
                                        <option value="Linux">Linux</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Tình trạng:</label>
                                    <select name="condition" required>
                                        <option value="" disabled selected>Chọn tình trạng</option>
                                        <option value="Mới 100%">Mới 100%</option>
                                        <option value="Like new 99%">Like new 99%</option>
                                        <option value="Đã qua sử dụng">Đã qua sử dụng</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Tần số quét:</label>
                                    <select name="refresh_rate" required>
                                        <option value="" disabled selected>Chọn tần số quét</option>
                                        <option value="60Hz">60Hz</option>
                                        <option value="120Hz">120Hz</option>
                                        <option value="144Hz">144Hz</option>
                                        <option value="240Hz">240Hz</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Trong phần <div class="variant-section"> -->
                            <div class="variant-section">
                                <h3>Thông tin biến thể </h3>
                                <div class="form-grid">
                                    <div class="full-width">
                                        <label>Chọn RAM:</label>
                                        <select id="ram-select" name="ram" multiple onchange="toggleForms()">
                                            <option value="4GB">4GB</option>
                                            <option value="8GB">8GB</option>
                                            <option value="16GB">16GB</option>
                                            <option value="32GB">32GB</option>
                                            <option value="64GB">64GB</option>
                                            <option value="96GB">96GB</option>
                                            <option value="128GB">128GB</option>
                                        </select>
                                        <small style="color: #666;">(Nhấn giữ Ctrl để chọn nhiều RAM)</small>
                                    </div>
                                </div>

                                <div id="ram-forms">
                                    <div id="form_4GB" class="variant-form">
                                        <h4>4GB</h4>
                                        <label>Giá</label>
                                        <input type="number" name="price_4GB" step="0.01" placeholder="">
                                        <label>Số lượng</label>
                                        <input type="number" name="stock_4GB" placeholder="">
                                    </div>
                                    <div id="form_8GB" class="variant-form">
                                        <h4>8GB</h4>
                                        <label>Giá</label>
                                        <input type="number" name="price_8GB" step="0.01" placeholder="">
                                        <label>Số lượng</label>
                                        <input type="number" name="stock_8GB" placeholder="">
                                    </div>
                                    <div id="form_16GB" class="variant-form">
                                        <h4>16GB</h4>
                                        <label>Giá</label>
                                        <input type="number" name="price_16GB" step="0.01" placeholder="">
                                        <label>Số lượng</label>
                                        <input type="number" name="stock_16GB" placeholder="">
                                    </div>
                                    <div id="form_32GB" class="variant-form">
                                        <h4>32GB</h4>
                                        <label>Giá</label>
                                        <input type="number" name="price_32GB" step="0.01" placeholder="">
                                        <label>Số lượng</label>
                                        <input type="number" name="stock_32GB" placeholder="">
                                    </div>
                                    <div id="form_64GB" class="variant-form">
                                        <h4>64GB</h4>
                                        <label>Giá</label>
                                        <input type="number" name="price_64GB" step="0.01" placeholder="">
                                        <label>Số lượng</label>
                                        <input type="number" name="stock_64GB" placeholder="">
                                    </div>
                                    <div id="form_96GB" class="variant-form">
                                        <h4>96GB</h4>
                                        <label>Giá</label>
                                        <input type="number" name="price_96GB" step="0.01" placeholder="">
                                        <label>Số lượng</label>
                                        <input type="number" name="stock_96GB" placeholder="">
                                    </div>
                                    <div id="form_128GB" class="variant-form">
                                        <h4>128GB</h4>
                                        <label>Giá</label>
                                        <input type="number" name="price_128GB" step="0.01" placeholder="">
                                        <label>Số lượng</label>
                                        <input type="number" name="stock_128GB" placeholder="">
                                    </div>
                                </div>
                            </div>

                            <input type="submit" value="Thêm Sản Phẩm" class="submit-btn">
                        </form>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright © Your Website 2023</div>
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
        <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/assets/demo/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/datatables-simple-demo.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
        <script>
                                            $(document).ready(function () {
                                                let originalName = "";
                                                let isTyping = false;

                                                // Cấu trúc cây CPU
                                                $('#cpu-tree').jstree({
                                                    'core': {
                                                        'data': [
                                                            {
                                                                "text": "Intel", "state": {"opened": true}, "children": [
                                                                    {"text": "Core i3-12100"},
                                                                    {"text": "Core i5-12400"},
                                                                    {"text": "Core i7-13700K"},
                                                                    {"text": "Core i9-13900K"}
                                                                ]
                                                            },
                                                            {
                                                                "text": "AMD", "state": {"opened": true}, "children": [
                                                                    {"text": "Ryzen 5 7600X"},
                                                                    {"text": "Ryzen 7 7800X3D"},
                                                                    {"text": "Ryzen 9 7950X"}
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                });

                                                // Khi chọn CPU trong cây
                                                $('#cpu-tree').on("select_node.jstree", function (e, data) {
                                                    $('#cpu-input').val(data.node.text);
                                                    updateProductName();
                                                });

                                                // Kiểm tra xem người dùng có đang nhập tên sản phẩm không
                                                $('#product-name').on("input", function () {
                                                    isTyping = true;
                                                });

                                                // Khi người dùng ngừng nhập một lúc (800ms), cập nhật tên gốc
                                                let typingTimer;
                                                $('#product-name').on("blur", function () {
                                                    clearTimeout(typingTimer);
                                                    typingTimer = setTimeout(function () {
                                                        originalName = $('#product-name').val().trim();
                                                        isTyping = false;
                                                        updateProductName();
                                                    }, 800);
                                                });

                                                // Sự kiện thay đổi trên các select box
                                                $('#ram-select, #storage-select, #graphics-select').on("change", function () {
                                                    updateProductName();
                                                });

                                                function updateProductName() {
                                                    if (isTyping)
                                                        return; // Không cập nhật nếu đang nhập tên

                                                    let baseName = originalName || $('#product-name').val().trim();
                                                    let cpu = $('#cpu-input').val().trim();
                                                    let ramArray = $('#ram-select').val() || []; // Mảng các RAM được chọn
                                                    let storage = $('#storage-select').val();
                                                    let graphics = $('#graphics-select').val();

                                                    let details = [];
                                                    if (cpu)
                                                        details.push(cpu);

                                                    // Xóa RAM cũ trước khi thêm mới
                                                    baseName = baseName.replace(/(\d+GB,?\s?)+RAM/g, "").trim();

                                                    if (ramArray.length > 0) {
                                                        let ramText = ramArray.join(", ") + " RAM";
                                                        details.push(ramText);
                                                    }
                                                    if (storage)
                                                        details.push("SSD " + storage);
                                                    if (graphics)
                                                        details.push(graphics);

                                                    let fullName = baseName + (details.length > 0 ? " " + details.join(" ") : "");
                                                    $('#product-name').val(fullName.trim());
                                                }
                                            });

                                            document.addEventListener("DOMContentLoaded", function () {
                                                toggleForms(); // Khởi tạo trạng thái ban đầu
                                            });

                                            function toggleForms() {
                                                const selectedRams = Array.from(document.getElementById("ram-select").selectedOptions).map(option => option.value);
                                                const allForms = ["4GB", "8GB", "16GB", "32GB", "64GB", "96GB", "128GB"];
                                                allForms.forEach(ram => {
                                                    const formDiv = document.getElementById("form_" + ram);
                                                    formDiv.style.display = selectedRams.includes(ram) ? "block" : "none";
                                                });
                                            }

                                            function validateForm(event) {
                                                event.preventDefault(); // Ngăn submit mặc định để kiểm tra trước
                                                const selectedRams = Array.from(document.getElementById("ram-select").selectedOptions).map(option => option.value);

                                                // Kiểm tra RAM
                                                if (selectedRams.length === 0) {
                                                    alert("Vui lòng chọn ít nhất một tùy chọn RAM.");
                                                    return false;
                                                }

                                                // Kiểm tra price và stock cho từng RAM
                                                let isValid = true;
                                                selectedRams.forEach(ram => {
                                                    const price = document.getElementsByName("price_" + ram)[0].value;
                                                    const stock = document.getElementsByName("stock_" + ram)[0].value;
                                                    if (!price || !stock) {
                                                        alert("Vui lòng điền giá và số lượng cho " + ram);
                                                        isValid = false;
                                                    }
                                                });

                                                // Nếu hợp lệ, submit form
                                                if (isValid) {
                                                    document.getElementById("productForm").submit();
                                                }
                                                return false;
                                            }
        </script>
        <script>
    function toggleSubBrand() {
        var brandId = document.getElementById("brand_id").value;
        var subBrandDiv = document.getElementById("subbrand_div");

        if (brandId == "1") {
            subBrandDiv.style.display = "block"; // Hiện sub-brand nếu brand_id = 1
        } else {
            subBrandDiv.style.display = "none"; // Ẩn sub-brand nếu brand_id khác 1
        }
    }
</script>
    </body>
</html>