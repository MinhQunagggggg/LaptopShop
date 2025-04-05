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
            .info-section {
                background-color: #f8f8f8; /* Màu nền nhẹ cho toàn bộ section */
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Thêm hiệu ứng bóng */
                margin: 10px 0;
                font-family: Arial, sans-serif;
            }

            .info-section h3 {
                font-size: 18px;
                margin-bottom: 10px;
                color: #333;
            }

            .payment-method {
                background-color: #4CAF50; /* Màu xanh lá cho phần COD */
                color: white;
                font-size: 16px;
                padding: 8px 15px;
                border-radius: 5px;
                display: inline-block;
            }

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
                color: #fff;
            }
            .order-status.processing {
                background-color: #007bff;
                color: #fff;
            }
            .order-status.completed {
                background-color: #28a745;
                color: #fff;
            }
            .order-status.cancelled {
                background-color: #dc3545;
                color: #fff;
            }
            .order-status.default {
                background-color: #6c757d;
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarranty">
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
                            <h2>Order Detail</h2>
                            <span class="order-status
                                  ${orderDetails[0].orderStatus != null && orderDetails[0].orderStatus == 'Pending Confirmation' ? 'pending' : 
                                    orderDetails[0].orderStatus != null && orderDetails[0].orderStatus == 'Processing' ? 'processing' : 
                                    orderDetails[0].orderStatus != null && orderDetails[0].orderStatus == 'Completed' ? 'completed' : 
                                    orderDetails[0].orderStatus != null && orderDetails[0].orderStatus == 'Canceled' ? 'cancelled' : 'default'}">
                                      ${orderDetails[0].orderStatus != null ? orderDetails[0].orderStatus : 'Unknown'}
                                  </span>
                            </div>

                            <!-- Thông tin đơn hàng -->
                            <p>Order ID: <strong>${orderDetails[0].orderId}</strong></p>
                            <p>Created at: <strong>${orderDetails[0].orderDate}</strong></p>

                            <!-- Thông tin khách hàng và người nhận -->
                            <div class="info-box">
                                <div class="info-section">
                                    <h3>Custommer</h3>
                                    <p><strong>Name:</strong> ${orderDetails[0].customerName}</p>
                                    <p><strong>Phone:</strong> ${orderDetails[0].customerPhone}</p>
                                    <p><strong>Address:</strong> ${orderDetails[0].customerAddress}</p>
                                </div>
                                <div class="info-section">
                                    <h3>Payment method</h3>
                                    <p class="payment-method"><strong>COD</strong></p>
                                </div>

                            </div>              
                            <!-- Danh sách sản phẩm -->
                            <table id="productTable">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Total Price</th>
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
                                <a href="OrderList" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Order List</a>
                            </div>
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