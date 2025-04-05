<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model_Staff.User, DAO_Staff.CustomerDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Custommer Account</title>  
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f6f9;
                color: #343a40;
            }
            .container {
                max-width: 700px;
                margin: 50px auto;
                padding: 0 15px;
            }
            .card {
                background-color: #fff;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                border: none;
                padding: 30px;
            }
            h2 {
                font-size: 32px;
                font-weight: 700;
                color: #dc3545;
                text-align: center;
                margin-bottom: 30px;
            }
            .form-label {
                font-size: 16px;
                font-weight: 500;
                color: #495057;
                margin-bottom: 8px;
            }
            .input-group {
                position: relative;
                margin-bottom: 20px;
            }
            .input-group-text {
                background-color: #f8f9fa;
                border: 1px solid #ced4da;
                border-right: none;
                border-radius: 6px 0 0 6px;
                padding: 10px;
                color: #6c757d;
            }
            .form-control {
                border: 1px solid #ced4da;
                border-radius: 0 6px 6px 0;
                padding: 10px 15px;
                font-size: 16px;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }
            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                outline: none;
            }
            .form-control[type="file"] {
                border-radius: 6px;
                padding: 8px 15px;
            }
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
                border-radius: 6px;
                padding: 10px;
                text-align: center;
                margin-bottom: 20px;
                font-size: 14px;
                font-weight: 500;
            }
            .btn {
                padding: 12px 25px;
                font-size: 16px;
                border-radius: 6px;
                text-decoration: none;
                transition: all 0.3s ease;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-success {
                background-color: #28a745;
                color: #fff;
                border: none;
            }
            .btn-success:hover {
                background-color: #218838;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: #fff;
                border: none;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            .d-grid {
                display: grid;
                gap: 15px;
                margin-top: 30px;
            }
            @media (max-width: 576px) {
                .card {
                    padding: 20px;
                }
                h2 {
                    font-size: 28px;
                }
                .form-control, .btn {
                    font-size: 14px;
                }
                .input-group-text {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <script>
                // Lấy giá trị từ EL và đảm bảo là string
                const fullName = "${user.name != null ? user.name : 'Guest'}"; // Thêm dấu nháy và xử lý null
                const lastName = fullName.split(" ").pop(); // Lấy tên cuối
                console.log(lastName); // Kết quả: "Minh" nếu fullName là "Tran Nhat Minh"

                // Gán giá trị vào HTML
                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelector(".navbar-brand p").textContent = "Hello, " + lastName;
                });
            </script>
            <a class="navbar-brand ps-3" href="Dashboard"><p></p></a> <!-- Ban đầu để trống -->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
                <i class="fas fa-bars"></i>
            </button>
            <ul class="navbar-nav ms-auto ms-md-10 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" 
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user fa-fw"></i>
                    </a>
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
                            <a class="nav-link" href="Dashboard">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-line"></i></div>
                                Dashboard
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/OrderList">
                                <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                                Order List
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewProducts">
                                <div class="sb-nav-link-icon"><i class="fas fa-box-open"></i></div>
                                View Products
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/CustomerList">
                                <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                                View Customer List
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarranty">
                                <div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>
                                View Warranty
                            </a>
                        </div>
                    </div>
                </nav>
            </div>

            <div id="layoutSidenav_content">
                <div class="container">
                    <div class="card">
                        <div class="card-body">
                            <h2>Create Custommer Account</h2>
                            <form id="createAccountForm" action="CreateCustomerAccountServlet" method="POST" enctype="multipart/form-data">
                                <!-- Họ và Tên -->
                                <div class="input-group">
                                    <label for="name" class="form-label">Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="name" name="name" required 
                                               value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                                    </div>
                                </div>

                                <!-- Số Điện Thoại -->
                                <div class="input-group">
                                    <label for="phone" class="form-label">Phone</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input type="text" class="form-control" id="phone" name="phone" required
                                               value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="input-group">
                                    <label for="email" class="form-label">Email</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email" required
                                               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                                    </div>
                                </div>
                                <% 
                                    String errorMessageemail = (String) request.getAttribute("errorMessageemail");
                                    if (errorMessageemail != null && !errorMessageemail.isEmpty()) {
                                %>
                                <div class="alert alert-danger">
                                    <strong><%= errorMessageemail %></strong>
                                </div>
                                <% } %>

                                <!-- Địa Chỉ -->
                                <div class="input-group">
                                    <label for="address" class="form-label">Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                        <input type="text" class="form-control" id="address" name="address" required
                                               value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
                                    </div>
                                </div>

                                <!-- Ảnh Đại Diện -->
                                <div class="input-group">
                                    <label for="avatar" class="form-label">Image</label>
                                    <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*">
                                </div>

                                <!-- Tên Đăng Nhập -->
                                <div class="input-group">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user-circle"></i></span>
                                        <input type="text" class="form-control" id="username" name="username" required
                                               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                                    </div>
                                </div>
                                <% 
                                    String errorMessageusername = (String) request.getAttribute("errorMessageusername");
                                    if (errorMessageusername != null && !errorMessageusername.isEmpty()) {
                                %>
                                <div class="alert alert-danger">
                                    <strong><%= errorMessageusername %></strong>
                                </div>
                                <% } %>

                                <!-- Mật Khẩu -->
                                <div class="input-group">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                    </div>
                                </div>

                                <!-- Xác Nhận Mật Khẩu -->
                                <div class="input-group">
                                    <label for="confirmPassword" class="form-label">Confilm Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    </div>
                                    <div id="passwordError" class="alert alert-danger" style="display: none;">
                                        <strong>The Passwword not match.Please try again!</strong>
                                    </div>
                                </div>

                                <!-- Nút Submit -->
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-check"></i> Create Account
                                    </button>
                                    <a href="CustomerList" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- JavaScript để kiểm tra mật khẩu -->
                <script>
                    document.getElementById('createAccountForm').addEventListener('submit', function (event) {
                        const password = document.getElementById('password').value;
                        const confirmPassword = document.getElementById('confirmPassword').value;
                        const passwordError = document.getElementById('passwordError');

                        if (password !== confirmPassword) {
                            event.preventDefault();
                            passwordError.style.display = 'block';
                        } else {
                            passwordError.style.display = 'none';
                        }
                    });
                </script>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
                <script src="${pageContext.request.contextPath}/Staffacj/js/scripts.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
                <script src="${pageContext.request.contextPath}/Staffacj/js/datatables-simple-demo.js"></script>
            </div>
        </div>
    </body>
</html>