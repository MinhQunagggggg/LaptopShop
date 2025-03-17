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

            #layoutSidenav_content {
                padding-top: 50px; /* Đẩy main xuống dưới bằng cách thêm khoảng cách phía trên */
            }

            .form-container {
                width: 100%;
                max-width: 600px;
                background: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                animation: fadeIn 0.5s ease-in-out;
                margin: 0 auto; /* Căn giữa form-container */
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

            #brand-container {
                display: none; /* Ẩn trường Thương hiệu */
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
                        <h2>Thêm Chuột Mới</h2>
                        <form action="AddMouse" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
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
                                    <select name="accessory_brand_id" id="accessory_brand_id" required onchange="autoFillBrand()">
                                        <option value="" disabled selected>Chọn thương hiệu</option>
                                        <% for (String brand : brands) { %>
                                        <option value="<%= brand.split(": ")[0] %>" data-brand="<%= brand.split(": ")[1] %>">
                                            <%= brand.split(": ")[1] %>
                                        </option>
                                        <% } %>
                                    </select>
                                </div>

                                <!-- Trường brand là input text và bị ẩn -->
                                <div id="brand-container">
                                    <label>Thương hiệu:</label>
                                    <input type="text" name="brand" id="brand" required>
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
                                    <label>DPI:</label>
                                    <select name="dpi" required>
                                        <option value="" disabled selected>Chọn DPI</option>
                                        <option value="800">800</option>
                                        <option value="1600">1600</option>
                                        <option value="3200">3200</option>
                                    </select>
                                    <span class="error" id="dpiError"></span>
                                </div>

                                <div>
                                    <label>Loại công tắc:</label>
                                    <select name="switch_type">
                                        <option value="" disabled selected>Chọn loại công tắc (tùy chọn)</option>
                                        <option value="Mechanical">Mechanical</option>
                                        <option value="Optical">Optical</option>
                                        <option value="Silent">Silent</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Đèn LED chuột:</label>
                                    <select name="mouse_led">
                                        <option value="" disabled selected>Chọn đèn LED (tùy chọn)</option>
                                        <option value="RGB">RGB</option>
                                        <option value="Single Color">Single Color</option>
                                        <option value="No LED">No LED</option>
                                    </select>
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
                                    <label>Kích thước:</label>
                                    <select name="dimensions">
                                        <option value="" disabled selected>Chọn kích thước</option>
                                        <option value="120 x 65 x 40 mm">120 x 65 x 40 mm</option>
                                        <option value="130 x 70 x 45 mm">130 x 70 x 45 mm</option>
                                        <option value="115 x 60 x 38 mm">115 x 60 x 38 mm</option>
                                    </select>
                                    <span class="error" id="dimensionsError"></span>
                                </div>

                                <div>
                                    <label>Trọng lượng (g):</label>
                                    <select name="weight" required>
                                        <option value="" disabled selected>Chọn trọng lượng</option>
                                        <option value="85">85g</option>
                                        <option value="100">100g</option>
                                        <option value="120">120g</option>
                                    </select>
                                    <span class="error" id="weightError"></span>
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

                            <input type="submit" value="Thêm Chuột" class="submit-btn">
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
            function autoFillBrand() {
                var accessoryBrandSelect = document.getElementById("accessory_brand_id");
                var brandInput = document.getElementById("brand");
                var selectedOption = accessoryBrandSelect.options[accessoryBrandSelect.selectedIndex];
                var brandName = selectedOption.getAttribute("data-brand");

                if (brandName) {
                    brandInput.value = brandName; // Tự động điền tên thương hiệu vào input
                } else {
                    brandInput.value = ""; // Nếu không có giá trị, để trống
                }
            }

            function validateForm() {
                let valid = true;

                let dpiInput = document.querySelector('select[name="dpi"]');
                let dpiValue = dpiInput.value;
                let dpiError = document.getElementById("dpiError");

                let dimensionsInput = document.querySelector('select[name="dimensions"]');
                let dimensionsValue = dimensionsInput.value;
                let dimensionsError = document.getElementById("dimensionsError");

                let numberFields = ["warranty_months", "weight", "price", "stock"];
                let errorMessages = {
                    "warranty_months": "Thời gian bảo hành phải là số dương",
                    "weight": "Trọng lượng phải là số nguyên dương",
                    "price": "Giá bán phải là số dương",
                    "stock": "Số lượng phải là số nguyên dương"
                };

                numberFields.forEach(field => {
                    let input = document.querySelector(`[name="${field}"]`);
                    let errorSpan = document.getElementById(`${field}Error`);
                    let value = input.tagName === "SELECT" ? input.value : parseFloat(input.value);

                    if (value < 0 || (field === "price" && isNaN(value))) {
                        errorSpan.textContent = errorMessages[field];
                        valid = false;
                    } else {
                        errorSpan.textContent = "";
                    }
                });

                if (!dpiValue) {
                    dpiError.textContent = "Vui lòng chọn DPI";
                    valid = false;
                } else {
                    dpiError.textContent = "";
                }

                if (dimensionsValue && !/^\d{2,4} x \d{2,4} x \d{2,4} mm$/.test(dimensionsValue)) {
                    dimensionsError.textContent = "Kích thước phải có định dạng '120 x 65 x 40 mm'";
                    valid = false;
                } else {
                    dimensionsError.textContent = "";
                }

                return valid;
            }
        </script>
    </body>
</html>