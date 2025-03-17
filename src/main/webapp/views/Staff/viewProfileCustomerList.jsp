<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, Model_Staff.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách khách hàng</title>
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
                margin-top: 40px;
                padding: 0 15px;
                max-width: 1200px;
                margin-left: auto;
                margin-right: auto;
            }
            h2 {
                text-align: center;
                color: #dc3545;
                font-size: 32px;
                font-weight: 600;
                margin-bottom: 30px;
            }
            .action-header {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 25px;
            }
            .btn {
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 6px;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-success {
                background-color: #28a745;
                color: #fff;
            }
            .btn-success:hover {
                background-color: #218838;
            }
            .btn-primary {
                background-color: #007bff;
                color: #fff;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: #fff;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
                border: 2px solid #d1d3e2;
            }
            th, td {
                padding: 15px;
                text-align: center;
                border: 2px solid #d1d3e2;
            }
            th {
                background-color: #343a40;
                color: #343a40  ;
                font-weight: 700; /* Tăng độ đậm */
                text-transform: uppercase;
                font-size: 14px;
                text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2); /* Thêm bóng chữ */
            }
            td {
                font-size: 15px;
                color: #343a40;
            }
            tr:hover {
                background-color: #f1f3f5;
            }
            .avatar-img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 50%;
                border: 2px solid #e9ecef;
            }
            .no-data {
                text-align: center;
                color: #dc3545;
                font-size: 18px;
                padding: 20px;
            }
            .action-footer {
                text-align: center;
                margin-top: 30px;
            }
            @media (max-width: 768px) {
                .container {
                    padding: 10px;
                }
                table {
                    font-size: 14px;
                }
                .avatar-img {
                    width: 40px;
                    height: 40px;
                }
                .btn {
                    padding: 8px 15px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="Dashboard"><p>Xin chào, ${user.name}</p></a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="CustomerList" method="post">
                <div class="input-group">
                    <input class="form-control" type="text" name="search" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <ul class="navbar-nav ms-auto ms-md-2 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="CustomerProfileDetail?userId=${user.id}">My Profile</a></li>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarrantyServelet">
                                <div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>
                                View Warranty
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <div class="container">
                    <h2>Danh sách khách hàng</h2>
                    <div class="action-header">
                        <a href="CreateCustomerAccountServlet" class="btn btn-success">
                            <i class="fas fa-plus-circle"></i> Tạo tài khoản khách hàng
                        </a>
                    </div>

                    <table class="table">
                        <thead>
                            <tr>
                                <th>Avatar</th>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<User> customers = (List<User>) request.getAttribute("customers");
                                if (customers != null && !customers.isEmpty()) {
                                    for (User customer : customers) {
                                        byte[] avatarData = customer.getAvatarUrl();
                                        String avatarBase64 = (avatarData != null && avatarData.length > 0) 
                                            ? java.util.Base64.getEncoder().encodeToString(avatarData) 
                                            : "";
                            %>
                            <tr>
                                <td>
                                    <img src="<%= avatarBase64.isEmpty() ? "https://via.placeholder.com/60" : "data:image/jpeg;base64," + avatarBase64 %>" 
                                         alt="Avatar" class="avatar-img">
                                </td>
                                <td><%= customer.getId() %></td>
                                <td><%= customer.getName() != null ? customer.getName() : "N/A" %></td>
                                <td><%= customer.getPhone() != null ? customer.getPhone() : "N/A" %></td>
                                <td><%= customer.getEmail() != null ? customer.getEmail() : "N/A" %></td>
                                <td><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></td>
                                <td>
                                    <a href="CustomerProfileDetail?userId=<%= customer.getId() %>" class="btn btn-primary btn-sm">
                                        <i class="fas fa-eye"></i> Xem Chi Tiết
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="no-data">Không có dữ liệu khách hàng.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>

                    <div class="action-footer">
                        <a href="Dashboard" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/datatables-simple-demo.js"></script>
    </body>
</html>