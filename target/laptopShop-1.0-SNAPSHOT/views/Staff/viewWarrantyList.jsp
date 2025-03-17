<%@ page import="java.util.List, Model_Staff.Warranty" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách bảo hành</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<style>
    /* CSS hiện tại của bạn giữ nguyên */
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        text-align: center;
        vertical-align: middle;
        padding: 10px;
    }
    .btn-detail {
        background-color: #007bff;
        color: white;
        padding: 5px 12px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    .btn-detail:hover {
        background-color: #0056b3;
    }
    .btn-update {
        background-color: #28a745;
        color: white;
        padding: 5px 12px;
        border: none;
        border-radius: 5px;
        transition: all 0.3s ease;
    }
    .btn-update:hover {
        background-color: #218838;
    }
    .action-container {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }
    .status-select {
        padding: 5px;
        border-radius: 5px;
        border: 1px solid #ced4da;
    }
    .badge {
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 14px;
        font-weight: bold;
    }
    .btn-back {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    .title {
        text-align: center;
        color: red;
        font-size: 36px;
    }
    /* CSS mới cho nút Xem */
    .btn-view {
        background-color: #17a2b8;
        color: white;
        padding: 5px 12px;
        border: none;
        border-radius: 5px;
        transition: all 0.3s ease;
    }
    .btn-view:hover {
        background-color: #138496;
    }
</style>
<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!-- Navbar giữ nguyên -->
        <a class="navbar-brand ps-3" href="Dashboard"><p>Xin chào, ${user.name}</p></a>
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
           <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="ViewWarrantyServelet" method="post">
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
            <!-- Sidebar giữ nguyên -->
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
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4 title">Danh sách bảo hành</h1>           
                    <div class="card mb-4">
                        <div class="content">
                            <div class="container">
                                <h2 class="header">Danh sách bảo hành</h2>
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Warranty ID</th>
                                            <th>Order Detail ID</th>
                                            <th>Users ID</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>Address</th>
                                            <th>Status</th>
                                            <th>Service Center</th>
                                            <th>Notes</th>
                                            <th>Date</th>
                                            <th>Update Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Warranty> warranties = (List<Warranty>) request.getAttribute("warranties"); %>
                                        <% if (warranties != null && !warranties.isEmpty()) { %>
                                        <% for (Warranty warranty : warranties) { 
                                            String statusClass = "";
                                            String statusText = ""; 
                                            if (warranty.getStatus_id() == 1) {
                                                statusClass = "badge bg-warning";
                                                statusText = "Waiting";
                                            } else if (warranty.getStatus_id() == 2) {
                                                statusClass = "badge bg-primary";
                                                statusText = "Approved";
                                            } else if (warranty.getStatus_id() == 3) {
                                                statusClass = "badge bg-success";
                                                statusText = "Complete";
                                            } else {
                                                statusClass = "badge bg-danger";
                                                statusText = "Browsing failed";
                                            }
                                        %>
                                        <tr>
                                            <td><%= warranty.getWarranty_id() %></td>
                                            <td><%= warranty.getOder_detail_id() %></td>
                                            <td><%= warranty.getUser_id() %></td>
                                            <td><%= warranty.getName() %></td>
                                            <td><%= warranty.getPhone() %></td>
                                            <td><%= warranty.getAddress() %></td>
                                            <td><span class="<%= statusClass %>"><%= statusText %></span></td>
                                            <td><%= warranty.getSevice_center() %></td>
                                            <td>
                                                <button type="button" class="btn btn-view btn-sm" data-bs-toggle="modal" data-bs-target="#notesModal" data-notes="<%= warranty.getNotes() %>">
                                                    Xem
                                                </button>
                                            </td>
                                            <td><%= warranty.getDate() %></td>
                                            <td>
                                                <form action="UpdateWarrantyStatus" method="post">
                                                    <input type="hidden" name="warranty_id" value="<%= warranty.getWarranty_id() %>">
                                                    <select name="status_id" class="status-select">
                                                        <option value="1" <%= warranty.getStatus_id() == 1 ? "selected" : "" %>>Waiting</option>
                                                        <option value="2" <%= warranty.getStatus_id() == 2 ? "selected" : "" %>>Approved</option>
                                                        <option value="3" <%= warranty.getStatus_id() == 3 ? "selected" : "" %>>Complete</option>
                                                        <option value="4" <%= warranty.getStatus_id() == 4 ? "selected" : "" %>>Browsing failed</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-update btn-sm">Cập nhật</button>
                                                </form>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% } else { %>
                                        <tr>
                                            <td colspan="11" class="text-center">Không có bảo hành nào.</td>
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
            </main>
        </div>
    </div>

    <!-- Modal cho Notes -->
    <div class="modal fade" id="notesModal" tabindex="-1" aria-labelledby="notesModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="notesModalLabel">Ghi chú</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="notesContent"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/Staffacj/js/scripts.js"></script>
    <script>
        // JavaScript để truyền nội dung ghi chú vào modal
        document.addEventListener('DOMContentLoaded', function () {
            var notesModal = document.getElementById('notesModal');
            notesModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget; // Nút "Xem" đã được nhấp
                var notes = button.getAttribute('data-notes'); // Lấy nội dung ghi chú từ data-notes
                var modalBody = notesModal.querySelector('#notesContent');
                modalBody.textContent = notes || 'Không có ghi chú.'; // Hiển thị ghi chú hoặc thông báo mặc định
            });
        });
    </script>
</body>
</html>