<%@ page import="modelAdmin.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
                    <div class="container mt-5">
                        <div class="card shadow-lg p-4">
                            <h2 class="text-center text-primary">Chi tiết</h2>
                            <%
                                User staff = (User) request.getAttribute("staff");
                                if (staff != null) {
                            %>
                            <div class="text-center mb-3">
                                <img src="<%= staff.getAvatarUrl() %>" alt="Avatar" class="rounded-circle border shadow" width="120" height="120">
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><b>ID:</b> <%= staff.getUserId() %></li>
                                <li class="list-group-item"><b>Tên:</b> <%= staff.getName() %></li>
                                <li class="list-group-item"><b>Email:</b> <%= staff.getEmail() %></li>
                                <li class="list-group-item"><b>Điện thoại:</b> <%= staff.getPhone() %></li>
                                <li class="list-group-item"><b>Ngày tạo:</b> <%= staff.getCreatedAt() %></li>
                            </ul>
                            <div class="text-center mt-3">
                                <a href="staff-list" class="btn btn-secondary">⬅ Quay lại</a>
                            </div>
                            <% } else { %>
                            <p class="text-danger text-center">Không tìm thấy nhân viên.</p>
                            <% } %>
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
    </body>
</html>

