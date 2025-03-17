<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAOAdmin.UserDAO, modelAdmin.User" %>

<%
    int userId = Integer.parseInt(request.getParameter("id"));
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getStaffById(userId);
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
        <style>
            /* Đảm bảo CSS chỉ áp dụng trong main */
            main .container {
                background: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: 0 auto;
            }
            main h2 {
                color: #2c3e50;
                font-weight: 600;
                text-align: center;
                margin-bottom: 25px;
            }
            main .form-group {
                margin-bottom: 20px;
            }
            main label {
                font-size: 14px;
                color: #34495e;
                font-weight: 500;
                margin-bottom: 8px;
                display: block;
            }
            main input[type="text"], main input[type="email"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #dcdcdc;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }
            main input[type="text"]:focus, main input[type="email"]:focus {
                border-color: #007bff;
                box-shadow: 0 0 6px rgba(0, 123, 255, 0.3);
                outline: none;
            }
            main .image-preview {
                text-align: center;
                margin: 20px 0;
            }
            main .image-preview img {
                border-radius: 50%;
                object-fit: cover;
                width: 120px;
                height: 120px;
                border: 2px solid #e9ecef;
                transition: transform 0.3s;
            }
            main .image-preview img:hover {
                transform: scale(1.05);
            }
            main button {
                width: 100%;
                padding: 12px;
                background: #007bff;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.3s, transform 0.2s;
            }
            main button:hover {
                background: #0056b3;
                transform: translateY(-2px);
            }
            main .error {
                color: #dc3545;
                text-align: center;
                margin-bottom: 20px;
                font-size: 14px;
                font-weight: 500;
            }
            main .back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: #007bff;
                text-decoration: none;
                font-size: 14px;
                transition: color 0.3s;
            }
            main .back-link:hover {
                color: #0056b3;
                text-decoration: underline;
            }
        </style>
        <script>
            function updateImagePreview() {
                let input = document.getElementById('avatar_url').value;
                let preview = document.getElementById('previewImage');
                preview.src = input ? input : 'assets/default-avatar.jpg';
                preview.style.opacity = 0;
                setTimeout(() => {
                    preview.style.opacity = 1;
                }, 100); // Hiệu ứng fade-in nhẹ
            }
        </script>
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
                    <div class="container">
                        <h2>Cập nhật thông tin nhân viên</h2>

                        <% if (request.getParameter("error") != null) { %>
                        <p class="error">Cập nhật thất bại! Vui lòng kiểm tra lại.</p>
                        <% } %>

                        <form action="update-staff" method="post">
                            <input type="hidden" name="userId" value="<%= user.getUserId() %>">

                            <div class="form-group">
                                <label>Tên:</label>
                                <input type="text" name="name" value="<%= user.getName() %>" required>
                            </div>

                            <div class="form-group">
                                <label>Số điện thoại:</label>
                                <input type="text" name="phone" value="<%= user.getPhone() %>" required pattern="[0-9]{10}" title="Số điện thoại phải có 10 chữ số">
                            </div>

                            <div class="form-group">
                                <label>Email:</label>
                                <input type="email" name="email" value="<%= user.getEmail() %>" required>
                            </div>

                            <div class="form-group">
                                <label>Ảnh đại diện:</label>
                                <div class="image-preview">
                                    <% if (user.getAvatarUrl() != null && !user.getAvatarUrl().isEmpty()) { %>
                                    <img id="previewImage" src="<%= user.getAvatarUrl() %>" alt="Ảnh nhân viên">
                                    <% } else { %>
                                    <img id="previewImage" src="assets/default-avatar.jpg" alt="Ảnh mặc định">
                                    <% } %>
                                </div>
                                <input type="text" id="avatar_url" name="avatar_url" 
                                       value="<%= user.getAvatarUrl() != null ? user.getAvatarUrl() : "" %>"
                                       oninput="updateImagePreview()">
                            </div>

                            <button type="submit">Cập nhật</button>
                        </form>

                        <a href="staff-list" class="back-link">Quay lại danh sách nhân viên</a>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright © Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
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
    </body>
</html>