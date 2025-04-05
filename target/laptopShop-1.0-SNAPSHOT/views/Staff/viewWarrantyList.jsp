<%@ page import="java.util.List, Model_Staff.Warranty, java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
       
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Warranty List</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #fff;
                color: #343a40;
            }
            .container-fluid {
                padding: 20px 40px;
            }
            .title {
                text-align: center;
                color: #dc3545;
                font-size: 36px;
                font-weight: 600;
                margin-bottom: 30px;
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
                text-align: center;
                vertical-align: middle;
                padding: 15px 20px;
                border: 2px solid #d1d3e2;
            }
            th {
                background-color: #343a40;
                color: #343a40;
                font-weight: 700;
                text-transform: uppercase;
                font-size: 14px;
            }
            td {
                font-size: 15px;
                color: #343a40;
            }
            tr:hover {
                background-color: #f1f3f5;
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
                margin-top: 30px;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: #fff;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                transition: all 0.3s ease;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            .pagination {
                padding-bottom: 30px;
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 30px;
                margin-bottom: 40px;
            }
            .pagination button {
                padding: 12px 24px;
                border: 1px solid #ced4da;
                border-radius: 6px;
                background-color: #fff;
                cursor: pointer;
                font-size: 18px;
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
            @media (max-width: 768px) {
                th, td {
                    padding: 10px;
                    font-size: 14px;
                }
                .container-fluid {
                    padding: 10px 20px;
                }
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <script>
                const fullName = "${user.name != null ? user.name : 'Guest'}";
                const lastName = fullName.split(" ").pop();
                console.log(lastName);

                const displayText = lastName.length > 15 ? "Hello, Staff" : "Hello, " + lastName;

                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelector(".navbar-brand p").textContent = displayText;
                });
            </script>
            <a class="navbar-brand ps-3" href="Dashboard"><p></p></a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" id="searchInput" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <ul class="navbar-nav ms-auto ms-md-2 me-3 me-lg-4">
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
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4 title">Warranty List</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard / WarrantyList</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="content">
                                <!-- Status and Date Filters -->
                                <div class="filter-section">
                                    <label for="statusFilter">Filter by Status:</label>
                                    <select id="statusFilter">
                                        <option value="all">All</option>
                                        <option value="Waiting">Waiting</option>
                                        <option value="Approved">Approved</option>
                                        <option value="Complete">Complete</option>
                                        <option value="Browsing failed">Browsing failed</option>
                                    </select>
                                    <label for="dateFilter">Filter by Date:</label>
                                    <select id="dateFilter">
                                        <option value="all">All</option>
                                        <option value="today">Today</option>
                                        <option value="week">This Week</option>
                                        <option value="month">This Month</option>
                                    </select>
                                </div>

                                <table class="table" id="warrantyTable">
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
                                    <tbody id="warrantyTableBody">
                                        <% 
                                            List<Warranty> warranties = (List<Warranty>) request.getAttribute("warranties");
                                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                        %>
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
                                        <tr class="warranty-row" data-status="<%= statusText %>" data-date="<%= warranty.getDate() %>">
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
                                                    View
                                                </button>
                                            </td>
                                            <td><%= warranty.getDate() %></td>
                                            <td>
                                                <% if (warranty.getStatus_id() < 3) { %>
                                                <form action="UpdateWarrantyStatus" method="post" class="action-container">
                                                    <input type="hidden" name="warranty_id" value="<%= warranty.getWarranty_id() %>">
                                                    <input type="hidden" name="staff_id" value="${user.id}">
                                                    <select name="status_id" class="status-select">
                                                        <% if (warranty.getStatus_id() == 1) { %>                                                       
                                                        <option value="2">Approved</option>                                                             
                                                        <option value="4">Browsing failed</option>
                                                        <% } else if (warranty.getStatus_id() == 2) { %>                                                       
                                                        <option value="3">Complete</option>
                                                        <option value="4">Browsing failed</option>
                                                        <% } %>
                                                    </select>
                                                    <button type="submit" class="btn btn-update btn-sm">Update</button>
                                                </form>
                                                <% } else { %>
                                                <span>Cannot Edit</span>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% } else { %>
                                        <tr id="noWarrantiesRow">
                                            <td colspan="11" class="text-center">No warranties available.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>

                                <!-- Pagination -->
                                <div class="pagination" id="pagination"></div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Notes Modal -->
        <div class="modal fade" id="notesModal" tabindex="-1" aria-labelledby="notesModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="notesModalLabel">Notes</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="notesContent"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
                    // Notes Modal
                    var notesModal = document.getElementById('notesModal');
                    notesModal.addEventListener('show.bs.modal', function (event) {
                        var button = event.relatedTarget;
                        var notes = button.getAttribute('data-notes');
                        var modalBody = notesModal.querySelector('#notesContent');
                        modalBody.textContent = notes || 'No notes available.';
                    });

                    // Search, Filter and Pagination
                    const searchInput = document.getElementById('searchInput');
                    const searchButton = document.getElementById('btnNavbarSearch');
                    const statusFilter = document.getElementById('statusFilter');
                    const dateFilter = document.getElementById('dateFilter');
                    const tbody = document.getElementById('warrantyTableBody');
                    const allRows = Array.from(tbody.querySelectorAll('tr:not(#noWarrantiesRow)'));
                    const paginationContainer = document.getElementById('pagination');
                    const rowsPerPage = 5;
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

                        const today = new Date();
                        const weekStart = new Date(today);
                        weekStart.setDate(today.getDate() - today.getDay());
                        const monthStart = new Date(today.getFullYear(), today.getMonth(), 1);

                        filteredRows = allRows.filter(row => {
                            const text = row.textContent.toLowerCase();
                            const status = row.getAttribute('data-status') ? row.getAttribute('data-status').toLowerCase() : '';
                            const dateStr = row.getAttribute('data-date');
                            const rowDate = new Date(dateStr);

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
                            filteredRows = [createNoWarrantiesRow()];
                        }
                    }

                    function renderPage(page) {
                        const start = (page - 1) * rowsPerPage;
                        const end = start + rowsPerPage;
                        const rowsToShow = filteredRows.slice(start, end);

                        tbody.innerHTML = '';
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

                    function createNoWarrantiesRow() {
                        const row = document.createElement('tr');
                        row.id = 'noWarrantiesRow';
                        row.innerHTML = '<td colspan="11" class="text-center">No warranties available.</td>';
                        return row;
                    }
                });
        </script>
    </body>
</html>
