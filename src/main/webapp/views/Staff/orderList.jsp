<%@ page import="java.util.List, Model_Staff.Order, java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order List</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>

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
                color: #343a40;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 14px;
            }
            tr:hover {
                background-color: #f1f3f5;
            }
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
            .action-container {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 30px;
                min-height: 20px; /* Đảm bảo chiều cao tối thiểu để căn chỉnh */
            }
            .action-form {
                display: flex;
                align-items: center;
                gap: 5px;
            }
            .action-placeholder {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 150px; /* Đảm bảo chiều rộng tương đương với form */
                padding: 6px 12px;
                border-radius: 5px;
                font-size: 14px;
                font-weight: 600;
                text-align: center;
                background-color: #6c757d;
                color: #fff;
                opacity: 0.65; /* Làm mờ nhẹ để giống trạng thái disabled */
            }
            .status-select {
                padding: 6px;
                border-radius: 5px;
                border: 1px solid #ced4da;
                font-size: 14px;
                min-width: 100px; /* Đảm bảo select có chiều rộng cố định */
            }
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
            .filter-section select, .filter-section input {
                padding: 8px 12px;
                font-size: 16px;
                border-radius: 5px;
                border: 1px solid #ced4da;
                background-color: #fff;
                cursor: pointer;
                min-width: 150px;
            }
            .filter-section select:focus, .filter-section input:focus {
                border-color: #007bff;
                outline: none;
            }
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
            .pagination {
                padding-bottom: 30px;
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-top: 20px;
            }
            .pagination button {
                padding: 8px 16px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                background-color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .pagination button:hover {
                background-color: #e9ecef;
            }
            .pagination button.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }
            .pagination button:disabled {
                cursor: not-allowed;
                opacity: 0.5;
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

                // Kiểm tra độ dài lastName và quyết định giá trị hiển thị
                const displayText = lastName.length > 15 ? "Hello, Staff" : "Hello, " + lastName;

                // Gán giá trị vào HTML
                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelector(".navbar-brand p").textContent = displayText;
                });
            </script>
            <a class="navbar-brand ps-3" href="Dashboard"><p></p></a> <!-- Ban đầu để trống -->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" id="searchInput" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
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
                            <a class="nav-link" href="Dashboard"><div class="sb-nav-link-icon"><i class="fas fa-chart-line"></i></div>Dashboard</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/OrderList"><div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>Order List</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewProducts"><div class="sb-nav-link-icon"><i class="fas fa-box-open"></i></div>View Products</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/CustomerList"><div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>View Customer List</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarranty"><div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>View Warranty</a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Order List</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard / Order List</li>
                    </ol>
                    <div class="card mb-4">
                        <div class="content">
                            <div class="container">

                                <!-- Bộ lọc trạng thái và ngày -->
                                <div class="filter-section">
                                    <label for="statusFilter">Filter by Status:</label>
                                    <select id="statusFilter">
                                        <option value="all">All</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Processing">Processing</option>
                                        <option value="Completed">Completed</option>
                                        <option value="Canceled">Canceled</option>
                                    </select>
                                    <label for="dateFilter">Filter by Date:</label>
                                    <select id="dateFilter">
                                        <option value="all">All</option>
                                        <option value="today">Today's Orders</option>
                                        <option value="week">This Week's Orders</option>
                                        <option value="month">This Month's Orders</option>
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
                                    <tbody id="orderTableBody">
                                        <% 
                                            List<Order> orders = (List<Order>) request.getAttribute("orders");
                                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                        %>
                                        <% if (orders != null && !orders.isEmpty()) { %>
                                        <% for (Order order : orders) { 
                                            String statusClass = "";
                                            String statusText = order.getStatus();
                                            int currentStatusValue = 1;
                                            boolean isFinalStatus = false;
                                            if (statusText.equals("Pending Confirmation") || statusText.equals("Pending")) {
                                                statusClass = "badge bg-warning";
                                                statusText = "Pending";
                                                currentStatusValue = 1;
                                            } else if (statusText.equals("Processing")) {
                                                statusClass = "badge bg-primary";
                                                currentStatusValue = 2;
                                            } else if (statusText.equals("Completed")) {
                                                statusClass = "badge bg-success";
                                                currentStatusValue = 3;
                                                isFinalStatus = true;
                                            } else if (statusText.equals("Canceled")) { 
                                                statusClass = "badge bg-danger";
                                                currentStatusValue = 4;
                                                isFinalStatus = true;
                                            }
                                        %>
                                        <tr data-status="<%= statusText %>" data-date="<%= order.getCreateAt() %>">
                                            <td><%= order.getUserId() %></td>
                                            <td><%= order.getName() %></td>
                                            <td><%= order.getPhone() %></td>
                                            <td><%= order.getOrderId() %></td>
                                            <td><span class="<%= statusClass %>"><%= statusText %></span></td>
                                            <td><%= order.getCreateAt() %></td>
                                            <td><%= String.format("%,.0f", order.getTotalPrice()) %> VND</td>
                                            <td>
                                                <div class="action-container">
                                                    <a href="${pageContext.request.contextPath}/OrderDetail?order_id=<%= order.getOrderId() %>" class="btn btn-detail btn-sm">View Detail</a>
                                                    <% if (!isFinalStatus) { %>
                                                    <form action="${pageContext.request.contextPath}/UpdateOrderStatus" method="post" class="action-form">
                                                        <input type="hidden" name="user_id" value="${user.id}">
                                                        <input type="hidden" name="order_id" value="<%= order.getOrderId() %>">
                                                        <input type="hidden" name="current_status" value="<%= currentStatusValue %>">
                                                        <select name="status_id" class="status-select">
                                                            <% if (currentStatusValue == 1) { %>
                                                            <option value="2">Processing</option>
                                                            <option value="4">Canceled</option>
                                                            <% } else if (currentStatusValue == 2) { %>
                                                            <option value="3">Completed</option>
                                                            <option value="4">Canceled</option>
                                                            <% } %>
                                                        </select>
                                                        <button type="submit" class="btn btn-update btn-sm">Update</button>
                                                    </form>
                                                    <% } else { %>
                                                    <span class="action-placeholder" style="width: 190px;">Update failed </span>

                                                    <% } %>
                                                </div>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% } else { %>
                                        <tr id="noOrdersRow">
                                            <td colspan="8" class="text-center">No found order.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>

                                <!-- Phân trang -->
                                <div class="pagination" id="pagination"></div>                    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/datatables-simple-demo.js"></script>
        <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const searchInput = document.getElementById('searchInput');
                    const searchButton = document.getElementById('btnNavbarSearch');
                    const statusFilter = document.getElementById('statusFilter');
                    const dateFilter = document.getElementById('dateFilter');
                    const tbody = document.getElementById('orderTableBody');
                    const allRows = Array.from(tbody.querySelectorAll('tr:not(#noOrdersRow)')); // Exclude "no orders" row initially
                    const paginationContainer = document.getElementById('pagination');
                    const rowsPerPage = 7;
                    let currentPage = 1;
                    let filteredRows = allRows;

                    // Initial render
                    renderPage(currentPage);
                    renderPagination();

                    // Event listeners for filters
                    searchButton.addEventListener('click', filterAndPaginate);
                    statusFilter.addEventListener('change', filterAndPaginate);
                    dateFilter.addEventListener('change', filterAndPaginate);

                    function filterAndPaginate() {
                        filterTable();
                        currentPage = 1; // Reset to first page after filtering
                        renderPage(currentPage);
                        renderPagination();
                    }

                    function filterTable() {
                        const searchValue = searchInput.value.toLowerCase();
                        const statusValue = statusFilter.value.toLowerCase();
                        const dateValue = dateFilter.value;

                        // Get current date dynamically
                        const today = new Date();
                        const weekStart = new Date(today);
                        weekStart.setDate(today.getDate() - today.getDay()); // Start of the week (Sunday)
                        const monthStart = new Date(today.getFullYear(), today.getMonth(), 1); // Start of the month

                        filteredRows = allRows.filter(row => {
                            const text = row.textContent.toLowerCase();
                            const status = row.getAttribute('data-status') ? row.getAttribute('data-status').toLowerCase() : '';
                            const dateStr = row.getAttribute('data-date');
                            const rowDate = new Date(dateStr); // Parse the date from the row

                            const searchMatch = text.includes(searchValue);
                            const statusMatch = statusValue === 'all' || status === statusValue;
                            let dateMatch = true;

                            if (dateValue === 'today') {
                                dateMatch = rowDate.toDateString() === today.toDateString();
                            } else if (dateValue === 'week') {
                                dateMatch = rowDate >= weekStart && rowDate <= today;
                            } else if (dateValue === 'month') {
                                dateMatch = rowDate >= monthStart && rowDate <= today;
                            }

                            return searchMatch && statusMatch && dateMatch;
                        });

                        if (filteredRows.length === 0) {
                            filteredRows = [createNoOrdersRow()];
                        }
                    }

                    function renderPage(page) {
                        const start = (page - 1) * rowsPerPage;
                        const end = start + rowsPerPage;
                        const rowsToShow = filteredRows.slice(start, end);

                        // Only modify the content of the tbody, not the whole table
                        tbody.innerHTML = '';  // Clear the table body before adding rows
                        rowsToShow.forEach(row => tbody.appendChild(row));
                    }

                    function renderPagination() {
                        const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
                        paginationContainer.innerHTML = '';

                        if (totalPages <= 1)
                            return;

                        const prevButton = document.createElement('button');
                        prevButton.textContent = 'Previous';
                        prevButton.disabled = currentPage === 1;
                        prevButton.addEventListener('click', () => {
                            if (currentPage > 1) {
                                currentPage--;
                                renderPage(currentPage);
                                updatePaginationButtons(totalPages);
                            }
                        });
                        paginationContainer.appendChild(prevButton);

                        const maxButtons = 5;
                        let startPage = Math.max(1, currentPage - Math.floor(maxButtons / 2));
                        let endPage = Math.min(totalPages, startPage + maxButtons - 1);
                        if (endPage - startPage + 1 < maxButtons) {
                            startPage = Math.max(1, endPage - maxButtons + 1);
                        }

                        for (let i = startPage; i <= endPage; i++) {
                            const pageButton = document.createElement('button');
                            pageButton.textContent = i;
                            pageButton.classList.toggle('active', i === currentPage);
                            pageButton.addEventListener('click', () => {
                                currentPage = i;
                                renderPage(currentPage);
                                updatePaginationButtons(totalPages);
                            });
                            paginationContainer.appendChild(pageButton);
                        }

                        const nextButton = document.createElement('button');
                        nextButton.textContent = 'Next';
                        nextButton.disabled = currentPage === totalPages;
                        nextButton.addEventListener('click', () => {
                            if (currentPage < totalPages) {
                                currentPage++;
                                renderPage(currentPage);
                                updatePaginationButtons(totalPages);
                            }
                        });
                        paginationContainer.appendChild(nextButton);
                    }

                    function updatePaginationButtons(totalPages) {
                        const buttons = paginationContainer.querySelectorAll('button');
                        buttons[0].disabled = currentPage === 1;
                        buttons.forEach((btn, index) => {
                            if (index > 0 && index < buttons.length - 1) {
                                btn.classList.toggle('active', parseInt(btn.textContent) === currentPage);
                            }
                        });
                        buttons[buttons.length - 1].disabled = currentPage === totalPages;
                    }

                    function createNoOrdersRow() {
                        const row = document.createElement('tr');
                        row.id = 'noOrdersRow';
                        row.innerHTML = '<td colspan="8" class="text-center">No found Order.</td>';
                        return row;
                    }
                });

        </script>
    </body>
</html>