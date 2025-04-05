<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, Model_Staff.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer List</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #fff;
                color: #343a40;
            }
            .container {
                margin-top: 40px;
                padding: 0 15px;
                max-width: 1300px;
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
                background-color: #ffffff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
                border: 1px solid #000000;
                transition: box-shadow 0.3s ease;
            }
            table:hover {
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 14px;
                text-align: center;
                vertical-align: middle;
                border: 1px solid #000000;
            }
            th {
                background-color: #2d3748;
                color: #343a40;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 13px;
            }
            tr:hover {
                background-color: #f7fafc;
                transition: background-color 0.2s ease;
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
            .pagination {
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
            @media (max-width: 768px) {
                .container {
                    padding: 10px;
                }
                th, td {
                    padding: 10px;
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
                <div class="container">
                    <h2>Customer List</h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard / CustomerList</li>
                    </ol>
                    <div class="action-header">
                        <a href="CreateCustomerAccountServlet" class="btn btn-success">
                            <i class="fas fa-plus-circle"></i> Create Customer Account
                        </a>
                    </div>

                    <table class="table" id="customerTable">
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
                            <tr class="customer-row">
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
                                    <form action="CustomerProfileDetail" method="post" style="display: inline-block;">
                                        <input type="hidden" name="userId" value="<%= customer.getId() %>">
                                        <button type="submit" class="btn btn-primary btn-sm">View Details</button>
                                    </form>
                                    <form id="deleteForm_<%= customer.getId() %>" action="DeleteCustomerProfile" method="POST" style="display: inline-block; margin-left: 10px;">
                                        <input type="hidden" name="userId" value="<%= customer.getId() %>">
                                        <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal('<%= customer.getId() %>')">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="no-data">No customer data available.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <!-- Delete Confirmation Modal -->
                    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="deleteModalLabel">Delete Confirmation</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    Are you sure you want to delete this customer's profile? This action will permanently delete the data and cannot be undone.
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        let currentFormId = null;

                        function showDeleteModal(customerId) {
                            currentFormId = "deleteForm_" + customerId;
                            const modal = new bootstrap.Modal(document.getElementById("deleteModal"));
                            modal.show();
                        }

                        document.getElementById("confirmDeleteBtn").addEventListener("click", function () {
                            if (currentFormId) {
                                document.getElementById(currentFormId).submit();
                            }
                            bootstrap.Modal.getInstance(document.getElementById("deleteModal")).hide();
                        });
                    </script>
                </div>
                <div class="pagination" id="pagination"></div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/datatables-simple-demo.js"></script>
        <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const searchInput = document.getElementById("searchInput");
                            const customerTable = document.getElementById("customerTable");
                            const allCustomers = Array.from(customerTable.querySelectorAll(".customer-row"));
                            const paginationContainer = document.getElementById("pagination");
                            const customersPerPage = 5;
                            let currentPage = 1;
                            let filteredCustomers = allCustomers;

                            renderPage(currentPage);
                            renderPagination();

                            searchInput.addEventListener("input", filterAndPaginate);

                            document.getElementById("btnNavbarSearch").addEventListener("click", filterAndPaginate);

                            function filterAndPaginate() {
                                filterCustomers();
                                currentPage = 1;
                                renderPage(currentPage);
                                renderPagination();
                            }

                            function filterCustomers() {
                                const searchValue = searchInput.value.toLowerCase();
                                filteredCustomers = allCustomers.filter(row => {
                                    const name = row.cells[2].textContent.toLowerCase();
                                    const phone = row.cells[3].textContent.toLowerCase();
                                    const email = row.cells[4].textContent.toLowerCase();
                                    const address = row.cells[5].textContent.toLowerCase();
                                    return name.includes(searchValue) || phone.includes(searchValue) ||
                                            email.includes(searchValue) || address.includes(searchValue);
                                });

                                if (filteredCustomers.length === 0) {
                                    customerTable.querySelector("tbody").innerHTML =
                                            '<tr><td colspan="7" class="no-data">No matching customer data.</td></tr>';
                                }
                            }

                            function renderPage(page) {
                                const start = (page - 1) * customersPerPage;
                                const end = start + customersPerPage;
                                const customersToShow = filteredCustomers.slice(start, end);

                                if (filteredCustomers.length > 0) {
                                    const tbody = customerTable.querySelector("tbody");
                                    tbody.innerHTML = "";
                                    customersToShow.forEach(customer => tbody.appendChild(customer));
                                }
                            }

                            function renderPagination() {
                                const totalPages = Math.ceil(filteredCustomers.length / customersPerPage);
                                paginationContainer.innerHTML = "";

                                if (totalPages <= 1)
                                    return;

                                const prevButton = document.createElement("button");
                                prevButton.textContent = "Previous";
                                prevButton.disabled = currentPage === 1;
                                prevButton.addEventListener("click", () => {
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
                                    const pageButton = document.createElement("button");
                                    pageButton.textContent = i;
                                    pageButton.classList.toggle("active", i === currentPage);
                                    pageButton.addEventListener("click", () => {
                                        currentPage = i;
                                        renderPage(currentPage);
                                        updatePaginationButtons(totalPages);
                                    });
                                    paginationContainer.appendChild(pageButton);
                                }

                                const nextButton = document.createElement("button");
                                nextButton.textContent = "Next";
                                nextButton.disabled = currentPage === totalPages;
                                nextButton.addEventListener("click", () => {
                                    if (currentPage < totalPages) {
                                        currentPage++;
                                        renderPage(currentPage);
                                        updatePaginationButtons(totalPages);
                                    }
                                });
                                paginationContainer.appendChild(nextButton);
                            }

                            function updatePaginationButtons(totalPages) {
                                const buttons = paginationContainer.querySelectorAll("button");
                                buttons[0].disabled = currentPage === 1;
                                buttons.forEach((btn, index) => {
                                    if (index > 0 && index < buttons.length - 1) {
                                        btn.classList.toggle("active", parseInt(btn.textContent) === currentPage);
                                    }
                                });
                                buttons[buttons.length - 1].disabled = currentPage === totalPages;
                            }
                        });
        </script>

    </body>
</html>
