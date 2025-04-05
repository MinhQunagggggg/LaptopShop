<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <style>
            /* Giữ nguyên CSS của bạn */
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
                max-width: 600px;
                background: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                animation: fadeIn 0.5s ease-in-out;
                margin: 0 auto;
            }
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
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
            .checkbox-group {
                margin-top: 15px;
                display: flex;
                gap: 20px;
                align-items: center;
            }
            .checkbox-group label {
                margin-top: 0;
                display: inline;
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
            /* Ẩn trường model */
            #model-container {
                display: none;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/Home">
                <img src="${pageContext.request.contextPath}/assets/img/logoDashboard.png" 
                     alt="Logo" width="120" height="120" 
                     style="display: block; margin: auto; margin-top: 50px; filter: brightness(1.3);">
            </a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
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
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="form-container">
                        <h2>Thêm Màn Hình Mới</h2>
                        <form name="monitorForm" action="AddMonitor" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="form-grid">
                                <div class="full-width">
                                    <label>Tên sản phẩm:</label>
                                    <input type="text" name="product_name" id="product_name" required placeholder="Nhập tên sản phẩm" oninput="autoFillModel()">
                                </div>

                                <div class="full-width">
                                    <label>Mô tả:</label>
                                    <textarea name="description" required placeholder="Nhập mô tả sản phẩm"></textarea>
                                </div>

                                <!-- Ẩn trường model -->
                                <div id="model-container">
                                    <label>Mã model:</label>
                                    <input type="text" name="model" id="model" required placeholder="Nhập mã model">
                                </div>

                                <div>
                                    <label>Kích thước (inch):</label>
                                    <select name="size" required>
                                        <option value="" disabled selected>Chọn kích thước</option>
                                        <option value="24">24 inch</option>
                                        <option value="27">27 inch</option>
                                        <option value="32">32 inch</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Loại tấm nền:</label>
                                    <select name="panel_type" required>
                                        <option value="" disabled selected>Chọn loại</option>
                                        <option value="IPS">IPS</option>
                                        <option value="VA">VA</option>
                                        <option value="TN">TN</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Độ phân giải:</label>
                                    <select name="resolution" required>
                                        <option value="" disabled selected>Chọn độ phân giải</option>
                                        <option value="1920x1080">1920x1080 (Full HD)</option>
                                        <option value="2560x1440">2560x1440 (QHD)</option>
                                        <option value="3840x2160">3840x2160 (4K)</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Độ sáng (nits):</label>
                                    <select name="brightness">
                                        <option value="" disabled selected>Chọn độ sáng</option>
                                        <option value="250">250 nits</option>
                                        <option value="300">300 nits</option>
                                        <option value="400">400 nits</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Tần số quét (Hz):</label>
                                    <select name="refresh_rate" required>
                                        <option value="" disabled selected>Chọn tần số</option>
                                        <option value="60">60 Hz</option>
                                        <option value="75">75 Hz</option>
                                        <option value="144">144 Hz</option>
                                        <option value="240">240 Hz</option>
                                    </select>
                                </div>

                                <div class="full-width">
                                    <label>Cổng kết nối:</label>
                                    <select name="ports">
                                        <option value="" disabled selected>Chọn cổng kết nối</option>
                                        <option value="HDMI">HDMI</option>
                                        <option value="DisplayPort">DisplayPort</option>
                                        <option value="HDMI, DisplayPort">HDMI, DisplayPort</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Trọng lượng (kg):</label>
                                    <select name="weight">
                                        <option value="" disabled selected>Chọn trọng lượng</option>
                                        <option value="3.5">3.5 kg</option>
                                        <option value="4.0">4.0 kg</option>
                                        <option value="5.0">5.0 kg</option>
                                    </select>
                                </div>

                                <div>
                                    <label>Màu sắc:</label>
                                    <select name="color">
                                        <option value="" disabled selected>Chọn màu sắc</option>
                                        <option value="Black">Black</option>
                                        <option value="White">White</option>
                                        <option value="Silver">Silver</option>
                                    </select>
                                </div>

                                <div class="full-width">
                                    <label>Hình ảnh sản phẩm:</label>
                                    <input type="file" name="image" accept="image/*" required>
                                </div>

                                <div>
                                    <label>Giá bán (VNĐ):</label>
                                    <input type="number" name="price" min="1" step="0.01" required placeholder="Nhập giá bán">
                                </div>

                                <div>
                                    <label>Số lượng trong kho:</label>
                                    <input type="number" name="stock" min="0" required placeholder="Nhập số lượng">
                                </div>

                                <div class="checkbox-group full-width">
                                    <div>
                                        <input type="checkbox" name="hdr" value="true">
                                        <label>Hỗ trợ HDR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" name="audio_out" value="true">
                                        <label>Có âm thanh đầu ra</label>
                                    </div>
                                </div>
                            </div>

                            <input type="submit" value="Thêm Màn Hình" class="submit-btn">
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
            function autoFillModel() {
                var productName = document.getElementById("product_name").value;
                var modelInput = document.getElementById("model");
                // Gán giá trị của product_name trực tiếp vào model
                modelInput.value = productName;
            }
        </script>
    </body>
</html>