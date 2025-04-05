<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelAdmin.ProductSpecification, modelAdmin.ProductVariant" %>

<jsp:useBean id="specification" type="modelAdmin.ProductSpecification" scope="request"/>
<jsp:useBean id="variant" type="modelAdmin.ProductVariant" scope="request"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật sản phẩm</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2, h3 { color: #333; }
        form { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; }
        label { font-weight: bold; }
        input, textarea { width: 100%; padding: 8px; margin: 5px 0; border: 1px solid #ccc; border-radius: 5px; }
        button { background-color: #28a745; color: white; padding: 10px; border: none; cursor: pointer; }
        button:hover { background-color: #218838; }
    </style>
</head>
<body>

    <h2>Cập nhật sản phẩm</h2>
    
<form action="updateProduct" method="post">
    <input type="hidden" name="productId" value="<%= request.getAttribute("productId") %>">

        <h3>Thông số kỹ thuật</h3>
        <label>CPU:</label>
        <input type="text" name="cpu" value="${specification.cpu}">
        
        <label>RAM:</label>
        <input type="text" name="ram" value="${specification.ram}">
        
        <label>Lưu trữ:</label>
        <input type="text" name="storage" value="${specification.storage}">
        
        <label>Độ phân giải:</label>
        <input type="text" name="resolution" value="${specification.resolution}">
        
        <label>Card đồ họa:</label>
        <input type="text" name="graphics" value="${specification.graphics}">
        
        <label>Cổng kết nối:</label>
        <input type="text" name="ports" value="${specification.ports}">
        
        <label>Kết nối không dây:</label>
        <input type="text" name="wireless" value="${specification.wireless}">
        
        <label>Camera:</label>
        <input type="text" name="camera" value="${specification.camera}">
        
        <label>Pin:</label>
        <input type="text" name="battery" value="${specification.battery}">
        
        <label>Kích thước:</label>
        <input type="text" name="dimensions" value="${specification.dimensions}">
        
        <label>Trọng lượng:</label>
        <input type="text" name="weight" value="${specification.weight}">
        
        <label>Bàn phím:</label>
        <input type="text" name="keyboard" value="${specification.keyboard}">
        
        <label>Chất liệu:</label>
        <input type="text" name="material" value="${specification.material}">
        
        <label>Bảo hành:</label>
        <input type="text" name="warranty" value="${specification.warranty}">
        
        <label>Hệ điều hành:</label>
        <input type="text" name="os" value="${specification.os}">
        
        <label>Tình trạng:</label>
        <input type="text" name="condition" value="${specification.condition}">
        
        <label>Tần số quét:</label>
        <input type="text" name="refreshRate" value="${specification.refreshRate}">

        <h3>Biến thể sản phẩm</h3>
        <label>Giá:</label>
        <input type="number" name="price" step="0.01" value="${String.format('%.2f', variant.price)}">

        
        <label>Tồn kho:</label>
        <input type="number" name="stock" value="${variant.stock}">
        
        <br><br>
        <button type="submit">Cập nhật</button>
    </form>

</body>
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelAdmin.ProductSpecification" %>
<%@ page import="modelAdmin.ProductVariant" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%
    ProductSpecification specification = (ProductSpecification) request.getAttribute("specification");
    List<ProductVariant> variants = (List<ProductVariant>) request.getAttribute("variants");
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
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/stylesAdmin.css" rel="stylesheet" />
        <style>
        .form-container { max-width: 1000px; margin: 0 auto; padding: 20px; }
        .form-label { font-weight: 600; }
        .btn-submit { background-color: #2c7be5; color: white; }
        .btn-submit:hover { background-color: #2567c9; }
        .error { color: red; }
        .variant-table { margin-top: 20px; }
        .formatted-price { color: #6c757d; font-style: italic; }
    </style>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
                    <body>
    <div class="container form-container">
        <h2 class="text-center mb-4">Cập nhật thông tin sản phẩm</h2>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="updateProduct" method="post">
            <input type="hidden" name="productId" value="<%= specification.getProductId() %>">
            
            <h4>Thông số kỹ thuật</h4>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">CPU</label>
                    <input type="text" class="form-control" name="cpu" value="<%= specification.getCpu() != null ? specification.getCpu() : "" %>" readonly>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Bộ nhớ (Storage)</label>
                    <select class="form-control" name="storage">
                        <option value="<%= specification.getStorage() != null ? specification.getStorage() : "" %>" selected><%= specification.getStorage() != null ? specification.getStorage() : "Chọn bộ nhớ" %></option>
                        <option value="128GB SSD">128GB SSD</option>
                        <option value="256GB SSD">256GB SSD</option>
                        <option value="512GB SSD">512GB SSD</option>
                        <option value="1TB SSD">1TB SSD</option>
                        <option value="1TB HDD">1TB HDD</option>
                        <option value="2TB HDD">2TB HDD</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Độ phân giải</label>
                    <select class="form-control" name="resolution">
                        <option value="<%= specification.getResolution() != null ? specification.getResolution() : "" %>" selected><%= specification.getResolution() != null ? specification.getResolution() : "Chọn độ phân giải" %></option>
                        <option value="1366x768">1366x768</option>
                        <option value="1920x1080">1920x1080 (Full HD)</option>
                        <option value="2560x1440">2560x1440 (QHD)</option>
                        <option value="3840x2160">3840x2160 (4K)</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Đồ họa (Graphics)</label>
                    <select class="form-control" name="graphics">
                        <option value="<%= specification.getGraphics() != null ? specification.getGraphics() : "" %>" selected><%= specification.getGraphics() != null ? specification.getGraphics() : "Chọn đồ họa" %></option>
                        <option value="Intel UHD Graphics">Intel UHD Graphics</option>
                        <option value="NVIDIA GTX 1650">NVIDIA GTX 1650</option>
                        <option value="NVIDIA RTX 3060">NVIDIA RTX 3060</option>
                        <option value="NVIDIA RTX 3080">NVIDIA RTX 3080</option>
                        <option value="AMD Radeon RX 6600">AMD Radeon RX 6600</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Cổng kết nối</label>
                    <select class="form-control" name="ports">
                        <option value="<%= specification.getPorts() != null ? specification.getPorts() : "" %>" selected><%= specification.getPorts() != null ? specification.getPorts() : "Chọn cổng" %></option>
                        <option value="USB 3.0, HDMI">USB 3.0, HDMI</option>
                        <option value="USB-C, HDMI, USB 3.0">USB-C, HDMI, USB 3.0</option>
                        <option value="Thunderbolt 3, USB-C">Thunderbolt 3, USB-C</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Kết nối không dây</label>
                    <select class="form-control" name="wireless">
                        <option value="<%= specification.getWireless() != null ? specification.getWireless() : "" %>" selected><%= specification.getWireless() != null ? specification.getWireless() : "Chọn kết nối" %></option>
                        <option value="Wi-Fi 5, Bluetooth 4.2">Wi-Fi 5, Bluetooth 4.2</option>
                        <option value="Wi-Fi 6, Bluetooth 5.0">Wi-Fi 6, Bluetooth 5.0</option>
                        <option value="Wi-Fi 6E, Bluetooth 5.2">Wi-Fi 6E, Bluetooth 5.2</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Camera</label>
                    <select class="form-control" name="camera">
                        <option value="<%= specification.getCamera() != null ? specification.getCamera() : "" %>" selected><%= specification.getCamera() != null ? specification.getCamera() : "Chọn camera" %></option>
                        <option value="720p HD">720p HD</option>
                        <option value="1080p Full HD">1080p Full HD</option>
                        <option value="Không có">Không có</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Pin</label>
                    <select class="form-control" name="battery">
                        <option value="<%= specification.getBattery() != null ? specification.getBattery() : "" %>" selected><%= specification.getBattery() != null ? specification.getBattery() : "Chọn pin" %></option>
                        <option value="3-cell, 45Wh">3-cell, 45Wh</option>
                        <option value="4-cell, 60Wh">4-cell, 60Wh</option>
                        <option value="6-cell, 90Wh">6-cell, 90Wh</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Kích thước (WxHxD)</label>
                    <select class="form-control" name="dimensions">
                        <option value="<%= specification.getDimensions() != null ? specification.getDimensions() : "" %>" selected><%= specification.getDimensions() != null ? specification.getDimensions() : "Chọn kích thước" %></option>
                        <option value="320 x 220 x 18 mm">320 x 220 x 18 mm</option>
                        <option value="360 x 250 x 20 mm">360 x 250 x 20 mm</option>
                        <option value="400 x 280 x 25 mm">400 x 280 x 25 mm</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Trọng lượng (kg)</label>
                    <select class="form-control" name="weight">
                        <option value="<%= specification.getWeight() != null ? specification.getWeight() : "" %>" selected><%= specification.getWeight() != null ? specification.getWeight() : "Chọn trọng lượng" %></option>
                        <option value="1.2 kg">1.2 kg</option>
                        <option value="1.5 kg">1.5 kg</option>
                        <option value="2.0 kg">2.0 kg</option>
                        <option value="2.5 kg">2.5 kg</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Bàn phím</label>
                    <select class="form-control" name="keyboard">
                        <option value="<%= specification.getKeyboard() != null ? specification.getKeyboard() : "" %>" selected><%= specification.getKeyboard() != null ? specification.getKeyboard() : "Chọn bàn phím" %></option>
                        <option value="Thường">Thường</option>
                        <option value="Có đèn nền">Có đèn nền</option>
                        <option value="RGB">RGB</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Chất liệu</label>
                    <select class="form-control" name="material">
                        <option value="<%= specification.getMaterial() != null ? specification.getMaterial() : "" %>" selected><%= specification.getMaterial() != null ? specification.getMaterial() : "Chọn chất liệu" %></option>
                        <option value="Nhựa">Nhựa</option>
                        <option value="Nhôm">Nhôm</option>
                        <option value="Hợp kim magiê">Hợp kim magiê</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Bảo hành</label>
                    <select class="form-control" name="warranty">
                        <option value="<%= specification.getWarranty() != null ? specification.getWarranty() : "" %>" selected><%= specification.getWarranty() != null ? specification.getWarranty() : "Chọn bảo hành" %></option>
                        <option value="6 tháng">6 tháng</option>
                        <option value="12 tháng">12 tháng</option>
                        <option value="24 tháng">24 tháng</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Hệ điều hành</label>
                    <select class="form-control" name="os">
                        <option value="<%= specification.getOs() != null ? specification.getOs() : "" %>" selected><%= specification.getOs() != null ? specification.getOs() : "Chọn hệ điều hành" %></option>
                        <option value="Windows 10">Windows 10</option>
                        <option value="Windows 11">Windows 11</option>
                        <option value="macOS">macOS</option>
                        <option value="Linux">Linux</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Tình trạng</label>
                    <select class="form-control" name="condition">
                        <option value="<%= specification.getCondition() != null ? specification.getCondition() : "" %>" selected><%= specification.getCondition() != null ? specification.getCondition() : "Chọn tình trạng" %></option>
                        <option value="Mới">Mới</option>
                        <option value="Đã qua sử dụng">Đã qua sử dụng</option>
                        <option value="Tân trang">Tân trang</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Tần số quét (Hz)</label>
                    <select class="form-control" name="refreshRate">
                        <option value="<%= specification.getRefreshRate() != null ? specification.getRefreshRate() : "" %>" selected><%= specification.getRefreshRate() != null ? specification.getRefreshRate() : "Chọn tần số quét" %></option>
                        <option value="60Hz">60Hz</option>
                        <option value="120Hz">120Hz</option>
                        <option value="144Hz">144Hz</option>
                        <option value="240Hz">240Hz</option>
                    </select>
                </div>
            </div>

            <h4 class="variant-table">Biến thể sản phẩm</h4>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>RAM</th>
                        <th>Giá (VND)</th>
                        <th>Giá định dạng</th>
                        <th>Tồn kho</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < variants.size(); i++) { %>
                        <tr>
                            <td>
                                <select class="form-control" name="ram" readonly>
                                    <option value="<%= variants.get(i).getRam() %>" selected><%= variants.get(i).getRam() %></option>
                                    <option value="4GB">4GB</option>
                                    <option value="8GB">8GB</option>
                                    <option value="16GB">16GB</option>
                                    <option value="32GB">32GB</option>
                                </select>
                            </td>
                            <td><input type="number" step="0.01" class="form-control" name="price" value="<%= variants.get(i).getPrice() %>"></td>
                            <td class="formatted-price"><%= currencyFormat.format(variants.get(i).getPrice()) %></td>
                            <td><input type="number" class="form-control" name="stock" value="<%= variants.get(i).getStock() %>"></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="text-center">
                <button type="submit" class="btn btn-submit px-5">Cập nhật</button>
                <a href="list-products" class="btn btn-secondary px-5">Hủy</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
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
        
    </body>
>>>>>>> 37dc03119998d49183623c576df4bc9542129ece
</html>
