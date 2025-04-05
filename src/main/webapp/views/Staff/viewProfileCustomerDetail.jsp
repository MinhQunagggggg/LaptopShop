<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model_Staff.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .profile-container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 30px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                background: #fff;
            }
            .profile-avatar {
                width: 250px;
                height: 400px;
                object-fit: cover;
                border-radius: 8px;
                border: 1px solid #ddd;
                transition: transform 0.3s ease;
            }
            .profile-avatar:hover {
                transform: scale(1.02);
            }
            .info-row {
                display: flex;
                align-items: center;
                padding: 12px 0;
                border-bottom: 1px solid #eee;
                font-size: 16px;
            }
            .info-label {
                font-weight: 600;
                width: 25%;
                color: #333;
            }
            .info-value {
                flex-grow: 1;
                padding: 8px 12px;
                background: #f5f6fa;
                border-radius: 6px;
                text-align: left;
            }
            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }
            .form-control:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            }
            .form-control[readonly] {
                background: #e9ecef;
                cursor: not-allowed;
            }
            .button-group {
                text-align: center;
                margin-top: 25px;
                display: flex;
                justify-content: center; /* Đảm bảo nút nằm chính giữa */
            }
            .button-group button {
                margin: 0 10px; /* Tạo khoảng cách giữa các nút */
            }

            .btn {
                padding: 10px 20px;
                border-radius: 6px;
                font-size: 16px;
                transition: all 0.3s ease;
            }
            .btn-primary {
                background-color: #007bff;
                border: none;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-success {
                background-color: #28a745;
                border: none;
            }
            .btn-success:hover {
                background-color: #218838;
            }
            .btn-secondary {
                background-color: #6c757d;
                border: none;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            .btn-danger {
                background-color: #dc3545;
                border: none;
            }
            .btn-danger:hover {
                background-color: #c82333;
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
            <ul class="navbar-nav ms-auto ms-md-10 me-3 me-lg-4">
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
                <div class="container mt-5">
                    <h2 class="text-center text-danger mb-4">Profile Detail</h2>
                    <div class="profile-container">
                        <%
                            User customer = (User) request.getAttribute("customer");
                            if (customer != null) {
                        %>
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <%
                                    byte[] avatarData = customer.getAvatarUrl();
                                    String avatarBase64 = (avatarData != null && avatarData.length > 0) 
                                        ? java.util.Base64.getEncoder().encodeToString(avatarData) 
                                        : "default-avatar.png";
                                %>
                                <img id="avatarPreview" src="data:image/jpeg;base64,<%= avatarBase64 %>" alt="Avatar" class="profile-avatar mb-3">
                            </div>
                            <div class="col-md-8">
                                <!-- Edit Form -->
                                <form id="editForm" action="UpdateCustomerProfile" method="POST" enctype="multipart/form-data" style="display: none;" onsubmit="return validateForm()">
                                    <input type="hidden" name="userId" value="<%= customer.getId() %>">
                                    <div class="info-row">
                                        <span class="info-label">Customer ID:</span>
                                        <span class="info-value"><%= customer.getId() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Full Name:</span>
                                        <input type="text" id="name" name="name" class="form-control" value="<%= customer.getName() %>" required>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Phone:</span>
                                        <input type="text" id="phone" name="phone" class="form-control" value="<%= customer.getPhone() %>" required pattern="[0-9]{10,11}" title="Phone number must be 10-11 digits">
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Email:</span>
                                        <input type="email" id="email" name="email" class="form-control" value="<%= customer.getEmail() %>" readonly>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Address:</span>
                                        <input type="text" id="address" name="address" class="form-control" value="<%= customer.getAddress() != null ? customer.getAddress() : "" %>" required>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Avatar:</span>
                                        <input type="file" id="avatarInput" name="avatar" class="form-control" accept="image/*" onchange="previewAvatar()">
                                    </div>
                                    <div class="button-group">
                                        <button type="submit" class="btn btn-success">Update</button>
                                        <button type="button" class="btn btn-secondary" onclick="cancelUpdate()">Cancel</button>
                                    </div>
                                </form>

                                <!-- View Mode -->
                                <div id="viewMode">
                                    <div class="info-row">
                                        <span class="info-label">Customer ID:</span>
                                        <span class="info-value"><%= customer.getId() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Full Name:</span>
                                        <span class="info-value"><%= customer.getName() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Phone:</span>
                                        <span class="info-value"><%= customer.getPhone() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Email:</span>
                                        <span class="info-value"><%= customer.getEmail() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Address:</span>
                                        <span class="info-value"><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></span>
                                    </div>
                                    <div class="button-group">
                                        <button id="editButton" class="btn btn-primary" onclick="toggleEditMode()">Edit</button>                                    
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% 
                            }
                        %>
                    </div>
                    <% if (customer == null) { %>
                    <p class="text-center text-danger mt-4">Customer not found.</p>
                    <% } %>
                </div>
            </div>
        </div>

        <script>
            function toggleEditMode() {
                const form = document.getElementById("editForm");
                const viewMode = document.getElementById("viewMode");
                const editButton = document.getElementById("editButton");

                if (form.style.display === "none") {
                    form.style.display = "block";
                    viewMode.style.display = "none";
                    editButton.style.display = "none";
                } else {
                    form.style.display = "none";
                    viewMode.style.display = "block";
                    editButton.style.display = "block";
                }
            }

            function previewAvatar() {
                const file = document.getElementById("avatarInput").files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onloadend = function () {
                        document.getElementById("avatarPreview").src = reader.result;
                    };
                    reader.readAsDataURL(file);
                }
            }

            function validateForm() {
                const phone = document.getElementById("phone").value;
                const phonePattern = /^[0-9]{10,11}$/;

                if (!phone.match(phonePattern)) {
                    alert("Invalid phone number. Please enter 10-11 digits.");
                    return false;
                }
                return true;
            }

            function cancelUpdate() {
                toggleEditMode(); // Switch back to view mode instead of navigating back
            }
        </script>
    </body>
</html>
