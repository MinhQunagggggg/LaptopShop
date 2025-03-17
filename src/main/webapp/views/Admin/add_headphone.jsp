<%@ page import="java.util.List, DAOAdmin.AccessoryBrandDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    AccessoryBrandDAO accessoryBrandDAO = new AccessoryBrandDAO();
    List<String> brands = accessoryBrandDAO.getAllAccessoryBrands();
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

            /* Điều chỉnh main để di chuyển xuống và giữ căn giữa */
            main {
                margin-top: 50px; /* Dời main xuống 50px */
                display: flex;
                justify-content: center; /* Căn giữa ngang */
                align-items: flex-start; /* Đảm bảo nội dung bắt đầu từ trên */
                width: 100%;
                padding: 0 20px; /* Thêm padding để tránh sát mép */
            }

            .form-container {
                width: 100%;
                max-width: 600px;
                background: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                animation: fadeIn 0.5s ease-in-out;
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

            .radio-group {
                margin-top: 6px;
                display: flex;
                gap: 15px;
                align-items: center;
            }

            .radio-group label {
                margin-top: 0;
                font-weight: 400;
                display: inline;
            }

            input[type="radio"] {
                width: auto;
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

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .full-width {
                grid-column: span 2;
            }

            .error {
                color: #e63946;
                font-size: 12px;
                margin-top: 4px;
                display: block;
            }

            @media (max-width: 600px) {
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
        </style>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar giữ nguyên -->
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
                    <!-- Sidebar giữ nguyên -->
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
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="form-container">
                        <h2>Thêm Tai Nghe Mới</h2>
                        <form action="AddHeadphone" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="form-grid">
                                <div class="full-width">
                                    <label>Tên sản phẩm:</label>
                                    <input type="text" name="product_name" required placeholder="Nhập tên sản phẩm">
                                </div>

                                <div class="full-width">
                                    <label>Mô tả:</label>
                                    <textarea name="description" required placeholder="Nhập mô tả sản phẩm"></textarea>
                                </div>

                                <div>
                                    <label>Thương hiệu phụ kiện:</label>
                                    <select name="accessory_brand_id" required>
                                        <option value="" disabled selected>Chọn thương hiệu</option>
                                        <% for (String brand : brands) { %>
                                        <option value="<%= brand.split(": ")[0] %>"><%= brand.split(": ")[1] %></option>
                                        <% } %>
                                    </select>
                                </div>

                                <div>
                                    <label>Thương hiệu:</label>
                                    <select name="brand" required>
                                        <option value="" disabled selected>Chọn thương hiệu</option>
                                        <option value="Sony">Sony</option>
                                        <option value="Sennheiser">Sennheiser</option>
                                        <option value="SteelSeries">SteelSeries</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Thời gian bảo hành (tháng):</label>
                                    <select name="warranty_months" required>
                                        <option value="" disabled selected>Chọn thời gian bảo hành</option>
                                        <option value="6">6 tháng</option>
                                        <option value="12">12 tháng</option>
                                        <option value="24">24 tháng</option>
                                    </select>
                                    <span class="error" id="warrantyError"></span>
                                </div>

                                <div>
                                    <label>Kiểu kết nối:</label>
                                    <select name="connection_type" required>
                                        <option value="" disabled selected>Chọn kiểu kết nối</option>
                                        <option value="USB">USB</option>
                                        <option value="Bluetooth">Bluetooth</option>
                                        <option value="Wireless 2.4GHz">Wireless 2.4GHz</option>
                                    </select>
                                </div>

                                <div class="full-width">
                                    <label>Có dây:</label>
                                    <div class="radio-group">
                                        <input type="radio" name="wired" value="true" id="wired_yes" required> <label for="wired_yes">Có</label>
                                        <input type="radio" name="wired" value="false" id="wired_no"> <label for="wired_no">Không</label>
                                    </div>
                                </div>

                                <div>
                                    <label>Màu sắc:</label>
                                    <select name="color" required>
                                        <option value="" disabled selected>Chọn màu sắc</option>
                                        <option value="Đen">Đen</option>
                                        <option value="Trắng">Trắng</option>
                                        <option value="Xám">Xám</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Màu đèn LED:</label>
                                    <select name="led_color">
                                        <option value="" disabled selected>Chọn màu LED (tùy chọn)</option>
                                        <option value="RGB">RGB</option>
                                        <option value="Single Color">Single Color</option>
                                        <option value="No LED">No LED</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Trọng lượng (g):</label>
                                    <select name="weight">
                                        <option value="" disabled selected>Chọn trọng lượng</option>
                                        <option value="200">200g</option>
                                        <option value="250">250g</option>
                                        <option value="300">300g</option>
                                    </select>
                                    <span class="error" id="weightError"></span>
                                </div>

                                <div>
                                    <label>Dải tần số (Hz):</label>
                                    <select name="frequency_range" required>
                                        <option value="" disabled selected>Chọn dải tần số</option>
                                        <option value="20Hz - 20kHz">20Hz - 20kHz</option>
                                        <option value="15Hz - 25kHz">15Hz - 25kHz</option>
                                        <option value="10Hz - 30kHz">10Hz - 30kHz</option>
                                    </select>
                                    <span class="error" id="freqError"></span>
                                </div>

                                <div>
                                    <label>Chất liệu:</label>
                                    <select name="material">
                                        <option value="" disabled selected>Chọn chất liệu (tùy chọn)</option>
                                        <option value="Nhựa">Nhựa</option>
                                        <option value="Kim loại">Kim loại</option>
                                        <option value="Da">Da</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Kích thước driver (mm):</label>
                                    <select name="driver_size" required>
                                        <option value="" disabled selected>Chọn kích thước driver</option>
                                        <option value="40">40mm</option>
                                        <option value="50">50mm</option>
                                        <option value="60">60mm</option>
                                    </select>
                                    <span class="error" id="driverError"></span>
                                </div>

                                <div class="full-width">
                                    <label>Hình ảnh:</label>
                                    <input type="file" name="image" accept="image/*" required>
                                </div>

                                <div>
                                    <label>Giá bán (VNĐ):</label>
                                    <input type="number" name="price" step="0.01" required min="0" placeholder="Nhập giá bán">
                                    <span class="error" id="priceError"></span>
                                </div>

                                <div>
                                    <label>Số lượng trong kho:</label>
                                    <input type="number" name="stock" required min="0" placeholder="Nhập số lượng">
                                    <span class="error" id="stockError"></span>
                                </div>
                            </div>

                            <input type="submit" value="Thêm Tai Nghe" class="submit-btn">
                        </form>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright © Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                ·
                                <a href="#">Terms & Conditions</a>
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
                            function validateForm() {
                                let valid = true;

                                let freqInput = document.querySelector('select[name="frequency_range"]');
                                let freqValue = freqInput.value;
                                let freqError = document.getElementById("freqError");

                                let numberFields = ["warranty_months", "weight", "driver_size", "price", "stock"];
                                let errorMessages = {
                                    "warranty_months": "Thời gian bảo hành phải là số dương",
                                    "weight": "Trọng lượng phải là số nguyên dương",
                                    "driver_size": "Kích thước driver phải là số nguyên dương",
                                    "price": "Giá bán phải là số dương",
                                    "stock": "Số lượng phải là số nguyên dương"
                                };

                                numberFields.forEach(field => {
                                    let input = document.querySelector(`[name="${field}"]`);
                                    let errorSpan = document.getElementById(`${field}Error`);
                                    let value = input.tagName === "SELECT" ? input.value : parseFloat(input.value);

                                    if ((value !== "" && value < 0) || (field === "price" && isNaN(value))) {
                                        errorSpan.textContent = errorMessages[field];
                                        valid = false;
                                    } else {
                                        errorSpan.textContent = "";
                                    }
                                });

                                if (!freqValue) {
                                    freqError.textContent = "Vui lòng chọn dải tần số";
                                    valid = false;
                                } else {
                                    freqError.textContent = "";
                                }

                                return valid;
                            }
        </script>
    </body>
</html>