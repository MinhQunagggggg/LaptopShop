<%@ page import="java.util.List, Model_Staff.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #1a1d20;
            padding: 20px;
            color: white;
            position: fixed;
            border-radius: 0 10px 10px 0;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
        }
        .sidebar h3 {
            text-align: center;
            font-weight: bold;
            padding-bottom: 15px;
            border-bottom: 1px solid #444;
        }
        .sidebar .nav-item {
            margin: 10px 0;
        }
        .sidebar .nav-link {
            color: #ccc;
            padding: 10px;
            border-radius: 5px;
            transition: 0.3s;
            display: flex;
            align-items: center;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
        }
        .sidebar .nav-link:hover {
            background-color: #28a745;
            color: white;
        }
        .content {
            margin-left: 270px;
            padding: 20px;
        }
        .container {
            margin-top: 30px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .table th {
            background-color: #28a745;
            color: white;
            text-align: center;
        }
        .table td {
            text-align: center;
            vertical-align: middle;
        }
        .btn-detail {
            background-color: #007bff;
            color: white;
            font-size: 12px;
            padding: 3px 8px;
            border-radius: 5px;
        }
        .btn-detail:hover {
            background-color: #0056b3;
        }
        .btn-update {
            background-color: #ffc107;
            color: black;
            font-size: 14px;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .btn-update:hover {
            background-color: #e0a800;
        }
        .status-select {
            width: 100%;
            padding: 5px;
            font-size: 14px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .action-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 5px;
        }
        .btn-back {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h3>Staff Dashboard</h3>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="Dashboard" class="nav-link"><i class="bi bi-house-door"></i> Dashboard</a></li>
            <li class="nav-item"><a href="OrderList" class="nav-link"><i class="bi bi-box-seam"></i> Order Management</a></li>
            <li class="nav-item"><a href="#" class="nav-link"><i class="bi bi-people"></i> Customer Management</a></li>
            <li class="nav-item"><a href="ViewProducts" class="nav-link"><i class="bi bi-chat-left-text"></i> Comments Management</a></li>
        </ul>
    </div>

    <div class="content">
        <div class="container">
            <h2 class="header">Danh sách đơn hàng</h2>
            <table class="table table-bordered table-striped">
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
                                statusClass = "badge bg-warning"; // Vàng
                                statusText = "Pending";
                            } else if (statusText.equals("Processing")) {
                                statusClass = "badge bg-danger"; // Đỏ
                            } else if (statusText.equals("Completed")) {
                                statusClass = "badge bg-success"; // Xanh lá
                            }
                        %>
                            <tr>
                                <td><%= order.getUserId()%></td>
                                <td><%= order.getName()%></td>
                                <td><%= order.getPhone()%></td>
                                <td><%= order.getOrderId()%></td>
                                <td><span class="<%= statusClass %>"><%= statusText %></span></td>
                                <td><%= order.getCreateAt()%></td>
                                <td><%= String.format("%,.0f", order.getTotalPrice()) %> VND</td>
                                <td>
                                    <div class="action-container">
                                        <a href="OrderDetail?order_id=<%= order.getOrderId()%>" class="btn btn-detail btn-sm">Xem Chi Tiết</a>
                                        <form action="UpdateOrderStatus" method="post">
                                            <input type="hidden" name="order_id" value="<%= order.getOrderId()%>">
                                            <select name="status_id" class="status-select">
                                                <option value="1" <%= statusText.equals("Pending") ? "selected" : ""%>>Pending</option>
                                                <option value="2" <%= statusText.equals("Processing") ? "selected" : ""%>>Processing</option>
                                                <option value="3" <%= statusText.equals("Completed") ? "selected" : ""%>>Completed</option>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
