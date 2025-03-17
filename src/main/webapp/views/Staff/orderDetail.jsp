<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Chi tiết đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            color: #343a40;
        }
        .order-container {
            width: 90%;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e9ecef;
        }
        .header-section h2 {
            font-size: 30px;
            font-weight: 600;
            margin: 0;
            color: #212529;
        }
        .order-status {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .order-status.pending {
            background-color: #ffc107;
            color: #212529;
        }
        .order-status.completed {
            background-color: #28a745;
            color: #fff;
        }
        .order-status.cancelled {
            background-color: #dc3545;
            color: #fff;
        }
        .info-box {
            display: flex;
            justify-content: space-between;
            gap: 25px;
            margin-bottom: 30px;
        }
        .info-section {
            width: 50%;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 10px;
            border: 1px solid #dee2e6;
            transition: box-shadow 0.3s ease;
        }
        .info-section:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
        .info-section h3 {
            font-size: 20px;
            color: #495057;
            margin-bottom: 15px;
            font-weight: 500;
        }
        .info-section p {
            margin: 8px 0;
            font-size: 16px;
            color: #6c757d;
        }
        .info-section p strong {
            color: #212529;
            font-weight: 600;
        }
        .filter-section {
            margin-bottom: 25px;
            text-align: right;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 15px;
        }
        .filter-section label {
            font-size: 16px;
            font-weight: 500;
            color: #495057;
        }
        .filter-section select {
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 6px;
            border: 1px solid #ced4da;
            background-color: #fff;
            cursor: pointer;
            min-width: 150px;
            transition: border-color 0.3s ease;
        }
        .filter-section select:focus {
            border-color: #007bff;
            outline: none;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 14px;
            text-align: center;
            border: 1px solid #e9ecef;
        }
        th {
            background-color: #343a40;
            color: #ffffff;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }
        tr {
            transition: background-color 0.2s ease;
        }
        tr:hover {
            background-color: #f1f3f5;
        }
        td {
            font-size: 15px;
            color: #495057;
        }
        td img {
            border-radius: 5px;
            max-width: 80px;
        }
        .action-buttons {
            text-align: center;
        }
        .btn {
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 6px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: #fff;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="Dashboard"><p>Xin chào, ${user.name}</p></a>
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
        <ul class="navbar-nav ms-auto ms-md-10 me-3 me-lg-4">
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
                <div class="order-container">
                    <!-- Tiêu đề và trạng thái đơn hàng -->
                    <div class="header-section">
                        <h2>Chi tiết đơn hàng</h2>
                        <span class="order-status ${orderDetails[0].orderStatus == 'Pending' ? 'pending' : orderDetails[0].orderStatus == 'Completed' ? 'completed' : 'cancelled'}">
                            ${orderDetails[0].orderStatus}
                        </span>
                    </div>

                    <!-- Thông tin đơn hàng -->
                    <p>Đơn hàng: <strong>${orderDetails[0].orderId}</strong></p>
                    <p>Ngày tạo: <strong>${orderDetails[0].orderDate}</strong></p>

                    <!-- Thông tin khách hàng và người nhận -->
                    <div class="info-box">
                        <div class="info-section">
                            <h3>Khách hàng</h3>
                            <p><strong>Tên:</strong> ${orderDetails[0].customerName}</p>
                            <p><strong>Số điện thoại:</strong> ${orderDetails[0].customerPhone}</p>
                        </div>
                        <div class="info-section">
                            <h3>Người nhận</h3>
                            <p><strong>Tên:</strong> ${orderDetails[0].consigneeName}</p>
                            <p><strong>Địa chỉ:</strong> ${orderDetails[0].consigneeAddress}</p>
                            <p><strong>Số điện thoại:</strong> ${orderDetails[0].consigneePhone}</p>
                        </div>
                    </div>

                    <!-- Bộ lọc trạng thái -->
                    <div class="filter-section">
                        <label for="statusFilter">Lọc theo trạng thái:</label>
                        <select id="statusFilter">
                            <option value="all">Tất cả</option>
                            <option value="Pending">Pending</option>
                            <option value="Completed">Completed</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </div>

                    <!-- Danh sách sản phẩm -->
                    <table id="productTable">
                        <thead>
                            <tr>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Mô tả</th>
                                <th>Trạng thái</th>
                                <th>Số lượng</th>
                                <th>Đơn giá</th>
                                <th>Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${orderDetails}">
                                <tr data-status="${detail.productStatus}">
                                    <td><img src="${detail.imageUrl}" width="80" alt="${detail.productName}"/></td>
                                    <td>${detail.productName}</td>
                                    <td>${detail.productDescription}</td>
                                    <td>${detail.productStatus}</td>
                                    <td>${detail.quantity}</td>
                                    <td><fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true" /> VNĐ</td>
                                    <td><fmt:formatNumber value="${detail.quantity * detail.price}" type="number" groupingUsed="true" /> VNĐ</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Nút quay lại -->
                    <div class="action-buttons">
                        <a href="OrderList" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại Đơn hàng</a>
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
        // JavaScript để lọc trạng thái sản phẩm
        document.getElementById('statusFilter').addEventListener('change', function() {
            const filterValue = this.value.toLowerCase(); // Chuyển thành chữ thường để so sánh
            const rows = document.querySelectorAll('#productTable tbody tr');

            rows.forEach(row => {
                const status = row.getAttribute('data-status') ? row.getAttribute('data-status').toLowerCase() : '';
                if (filterValue === 'all' || status === filterValue) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>