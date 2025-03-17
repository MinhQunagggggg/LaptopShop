<%@ page import="java.util.List, Model_Staff.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        /* Căn giữa nội dung trong bảng */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            text-align: center;
            vertical-align: middle;
            padding: 12px;
            border: 1px solid #e9ecef;
        }
        th {
            background-color: #343a40;
            color: #ffffff;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }
        tr:hover {
            background-color: #f1f3f5;
        }
        /* Định dạng nút "Xem Chi Tiết" */
        .btn-detail {
            background-color: #007bff;
            color: white;
            padding: 6px 14px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .btn-detail:hover {
            background-color: #0056b3;
        }
        /* Định dạng nút "Cập nhật" */
        .btn-update {
            background-color: #28a745;
            color: white;
            padding: 6px 14px;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .btn-update:hover {
            background-color: #218838;
        }
        /* Định dạng ô chứa hành động */
        .action-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        /* Định dạng dropdown */
        .status-select {
            padding: 6px;
            border-radius: 5px;
            border: 1px solid #ced4da;
            font-size: 14px;
        }
        /* Định dạng badge trạng thái */
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        .btn-back {
            display: flex;
            justify-content: center;
            margin-top: 25px;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: #fff;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        /* Định dạng bộ lọc */
        .filter-section {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 15px;
            background-color: #e9ecef;
            padding: 10px;
            border-radius: 6px;
        }
        .filter-section label {
            font-size: 16px;
            font-weight: 500;
            color: #495057;
        }
        .filter-section select {
            padding: 8px 12px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ced4da;
            background-color: #fff;
            cursor: pointer;
            min-width: 150px;
        }
        .filter-section select:focus {
            border-color: #007bff;
            outline: none;
        }
        /* Tổng thể container */
        .container-fluid {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        h1 {
            color: #212529;
            font-size: 32px;
            font-weight: 600;
        }
        .card {
            border: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
    </style>
</head>
<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="Dashboard"><p>Xin chào, ${user.name}</p></a>
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
        <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="OrderList" method="post">
            <div class="input-group">
                <input class="form-control" type="text" name="search" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                <button class="btn btn-primary" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
            </div>
        </form>
        <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
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
            <div class="container-fluid px-4">
                <h1 class="mt-4">Danh sách đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">Dashboard / Order List</li>
                </ol>
                <div class="card mb-4">
                    <div class="content">
                        <div class="container">
                            <h2 class="header">Danh sách đơn hàng</h2>

                            <!-- Bộ lọc trạng thái -->
                            <div class="filter-section">
                                <label for="statusFilter">Lọc theo trạng thái:</label>
                                <select id="statusFilter">
                                    <option value="all">Tất cả</option>
                                    <option value="Pending">Pending</option>
                                    <option value="Processing">Processing</option>
                                    <option value="Completed">Completed</option>
                                    <option value="Canceled">Canceled</option>
                                </select>
                            </div>

                            <!-- Bảng danh sách đơn hàng -->
                            <table class="table table-bordered table-striped" id="orderTable">
                                <thead>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Name</th>
                                        <th>Phone</th>
                                        <th>Order ID</th>
                                        <th>Status</th>
                                        <th>Created At</th>
                                        <th>Total Price</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Order> orders = (List<Order>) request.getAttribute("orders"); %>
                                    <% if (orders != null && !orders.isEmpty()) { %>
                                    <% for (Order order : orders) { 
                                        String statusClass = "";
                                        String statusText = order.getStatus();
                                        if (statusText.equals("Pending Confirmation")) {
                                            statusClass = "badge bg-warning";
                                            statusText = "Pending";
                                        } else if (statusText.equals("Processing")) {
                                            statusClass = "badge bg-primary";
                                        } else if (statusText.equals("Completed")) {
                                            statusClass = "badge bg-success";
                                        } else if (statusText.equals("Canceled")) { 
                                            statusClass = "badge bg-danger";
                                        }
                                    %>
                                    <tr data-status="<%= statusText %>">
                                        <td><%= order.getUserId() %></td>
                                        <td><%= order.getName() %></td>
                                        <td><%= order.getPhone() %></td>
                                        <td><%= order.getOrderId() %></td>
                                        <td><span class="<%= statusClass %>"><%= statusText %></span></td>
                                        <td><%= order.getCreateAt() %></td>
                                        <td><%= String.format("%,.0f", order.getTotalPrice()) %> VND</td>
                                        <td>
                                            <div class="action-container">
                                                <a href="OrderDetail?order_id=<%= order.getOrderId() %>" class="btn btn-detail btn-sm">Xem Chi Tiết</a>
                                                <form action="UpdateOrderStatus" method="post">
                                                    <input type="hidden" name="order_id" value="<%= order.getOrderId() %>">
                                                    <select name="status_id" class="status-select">
                                                        <option value="1" <%= statusText.equals("Pending") ? "selected" : "" %>>Pending</option>
                                                        <option value="2" <%= statusText.equals("Processing") ? "selected" : "" %>>Processing</option>
                                                        <option value="3" <%= statusText.equals("Completed") ? "selected" : "" %>>Completed</option>
                                                        <option value="4" <%= statusText.equals("Canceled") ? "selected" : "" %>>Canceled</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-update btn-sm">Cập nhật</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <% } else { %>
                                    <tr>
                                        <td colspan="8" class="text-center">Không có đơn hàng nào.</td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <div class="btn-back">
                                <a href="Dashboard" class="btn btn-secondary">Quay lại Dashboard</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/Staffacj/js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="/Staffacj/js/datatables-simple-demo.js"></script>
    <script>
        // JavaScript để lọc trạng thái đơn hàng
        document.addEventListener('DOMContentLoaded', function() {
            const filter = document.getElementById('statusFilter');
            if (filter) {
                filter.addEventListener('change', function() {
                    const filterValue = this.value.toLowerCase();
                    const rows = document.querySelectorAll('#orderTable tbody tr');

                    rows.forEach(row => {
                        const status = row.getAttribute('data-status') ? row.getAttribute('data-status').toLowerCase() : '';
                        if (filterValue === 'all' || status === filterValue) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                });
            } else {
                console.error('Không tìm thấy bộ lọc trạng thái!');
            }
        });
    </script>
</body>
</html>