<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelAdmin.Mouse" %>
<%@ page import="modelAdmin.ProductVariant" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    Mouse mouse = (Mouse) request.getAttribute("mouse");
    ProductVariant variant = (ProductVariant) request.getAttribute("variant");
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
            .form-container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }
            .form-label {
                font-weight: 600;
            }
            .btn-submit {
                background-color: #2c7be5;
                color: white;
            }
            .btn-submit:hover {
                background-color: #2567c9;
            }
            .error {
                color: red;
            }
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
                            <h2 class="text-center mb-4">Cập nhật thông tin chuột</h2>
                            <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger error"><%= request.getAttribute("error") %></div>
                            <% } %>
                            <form action="updateMouse" method="post">
                                <input type="hidden" name="productId" value="<%= mouse.getProductId() %>">

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Thương hiệu</label>
                                        <select class="form-control" name="brand" required>
                                            <option value="<%= mouse.getBrand() != null ? mouse.getBrand() : "" %>" selected><%= mouse.getBrand() != null ? mouse.getBrand() : "Chọn thương hiệu" %></option>
                                            <option value="Logitech">Logitech</option>
                                            <option value="Razer">Razer</option>
                                            <option value="SteelSeries">SteelSeries</option>
                                            <option value="Corsair">Corsair</option>
                                            <option value="ASUS">ASUS</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Thời gian bảo hành (tháng)</label>
                                        <input type="number" class="form-control" name="warrantyMonths" value="<%= mouse.getWarrantyMonths() %>" required>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Kiểu kết nối</label>
                                        <select class="form-control" name="connectionType" required>
                                            <option value="<%= mouse.getConnectionType() != null ? mouse.getConnectionType() : "" %>" selected><%= mouse.getConnectionType() != null ? mouse.getConnectionType() : "Chọn kiểu kết nối" %></option>
                                            <option value="USB">USB</option>
                                            <option value="Bluetooth">Bluetooth</option>
                                            <option value="2.4GHz Wireless">2.4GHz Wireless</option>
                                            <option value="USB + Wireless">USB + Wireless</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Có dây</label>
                                        <select class="form-control" name="wired">
                                            <option value="true" <%= mouse.isWired() ? "selected" : "" %>>Có</option>
                                            <option value="false" <%= !mouse.isWired() ? "selected" : "" %>>Không</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">DPI</label>
                                        <input type="number" class="form-control" name="dpi" value="<%= mouse.getDpi() %>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Loại switch</label>
                                        <select class="form-control" name="switchType">
                                            <option value="<%= mouse.getSwitchType() != null ? mouse.getSwitchType() : "" %>" selected><%= mouse.getSwitchType() != null ? mouse.getSwitchType() : "Chọn loại switch" %></option>
                                            <option value="Omron">Omron</option>
                                            <option value="Kailh">Kailh</option>
                                            <option value="Huano">Huano</option>
                                            <option value="Optical">Optical</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">LED chuột</label>
                                        <select class="form-control" name="mouseLed">
                                            <option value="<%= mouse.getMouseLed() != null ? mouse.getMouseLed() : "" %>" selected><%= mouse.getMouseLed() != null ? mouse.getMouseLed() : "Chọn LED" %></option>
                                            <option value="Không">Không</option>
                                            <option value="Đơn sắc">Đơn sắc</option>
                                            <option value="RGB">RGB</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Màu sắc</label>
                                        <select class="form-control" name="color" required>
                                            <option value="<%= mouse.getColor() != null ? mouse.getColor() : "" %>" selected><%= mouse.getColor() != null ? mouse.getColor() : "Chọn màu sắc" %></option>
                                            <option value="Đen">Đen</option>
                                            <option value="Trắng">Trắng</option>
                                            <option value="Xám">Xám</option>
                                            <option value="Đỏ">Đỏ</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Kích thước (WxHxD)</label>
                                        <select class="form-control" name="dimensions">
                                            <option value="<%= mouse.getDimensions() != null ? mouse.getDimensions() : "" %>" selected><%= mouse.getDimensions() != null ? mouse.getDimensions() : "Chọn kích thước" %></option>
                                            <option value="120 x 60 x 40 mm">120 x 60 x 40 mm</option>
                                            <option value="130 x 65 x 45 mm">130 x 65 x 45 mm</option>
                                            <option value="140 x 70 x 50 mm">140 x 70 x 50 mm</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Trọng lượng (kg)</label>
                                        <input type="number" step="0.01" class="form-control" name="weight" value="<%= mouse.getWeight() %>">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Giá (VND)</label>
                                        <input type="number" step="0.01" class="form-control" name="price" value="<%= variant.getPrice() %>">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Tồn kho</label>
                                        <input type="number" class="form-control" name="stock" value="<%= variant.getStock() %>">
                                    </div>
                                </div>

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
</html>
