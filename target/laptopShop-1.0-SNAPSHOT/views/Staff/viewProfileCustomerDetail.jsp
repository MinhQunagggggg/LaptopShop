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
                width: 100%;
                margin: auto;
                padding: 40px;
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                background: white;
            }
            .profile-avatar {
                width: 300px;
                height: 500px;
                object-fit: cover;
                border-radius: 5px;
                border: 1px solid #ddd;
            }
            .info-row {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 15px;
                border-bottom: 1px solid #ddd;
                font-size: 18px;
            }
            .info-label {
                font-weight: bold;
                width: 30%;
            }
            .info-value {
                flex-grow: 1;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 5px;
                text-align: center;
            }
            .button-group {
                text-align: center;
                margin-top: 20px;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="Dashboard"><p>Xin chào, ${user.name}</p></a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
      
            <!-- Navbar-->
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
                <div class="container mt-5">
                    <h2 class="text-center text-danger">Hồ Sơ Khách Hàng</h2>
                    <div class="profile-container">
                        <%
                            User customer = (User) request.getAttribute("customer");                         
                            if (customer != null) {
                        %>
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <%
                                    byte[] avatarData = customer.getAvatarUrl();
                                    String avatarBase64 = null;
                                    if (avatarData != null && avatarData.length > 0) {
                                        avatarBase64 = java.util.Base64.getEncoder().encodeToString(avatarData);
                                    } else {
                                        avatarBase64 = "default-avatar.png";
                                    }
                                %>
                                <img id="avatarPreview" src="data:image/jpeg;base64,<%= avatarBase64 %>" alt="Avatar" class="profile-avatar mb-3">
                            </div>
                            <div class="col-md-8">
                                <form id="editForm" action="UpdateCustomerProfile" method="POST" enctype="multipart/form-data" style="display: none;" onsubmit="return validateForm()">
                                    <input type="hidden" name="userId" value="<%= customer.getId() %>">
                                    <div class="info-row">
                                        <label>Mã khách hàng:</label>
                                        <span class="info-value"><%= customer.getId() %></span>
                                    </div>
                                    <div class="info-row">
                                        <label>Họ và tên:</label>
                                        <input type="text" id="name" name="name" class="form-control" value="<%= customer.getName() %>" required>
                                    </div>
                                    <div class="info-row">
                                        <label>Số điện thoại:</label>
                                        <input type="text" id="phone" name="phone" class="form-control" value="<%= customer.getPhone() %>" required pattern="[0-9]{10,11}" title="Số điện thoại phải có 10-11 chữ số">
                                    </div>
                                    <div class="info-row">
                                        <label>Email:</label>
                                        <input type="email" id="email" name="email" class="form-control" value="<%= customer.getEmail() %>" required>
                                    </div>
                                    <div class="info-row">
                                        <label>Địa chỉ:</label>
                                        <input type="text" id="address" name="address" class="form-control" value="<%= customer.getAddress() != null ? customer.getAddress() : "" %>" required>
                                    </div>

                                    <!-- Avatar Input -->
                                    <div class="info-row">
                                        <label>Ảnh đại diện:</label>
                                        <input type="file" id="avatarInput" name="avatar" class="form-control" accept="image/*" onchange="previewAvatar()">
                                    </div>

                                    <div class="button-group">
                                        <button type="submit" class="btn btn-success mt-3">Update</button>
                                        <button type="button" class="btn btn-secondary mt-3" onclick="cancelUpdate()">Cancel</button>
                                    </div>
                                </form>
                                <div id="viewMode">
                                    <div class="info-row">
                                        <span class="info-label">Mã khách hàng:</span>
                                        <span class="info-value"><%= customer.getId() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Họ và tên:</span>
                                        <span class="info-value"><%= customer.getName() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Số điện thoại:</span>
                                        <span class="info-value"><%= customer.getPhone() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Email:</span>
                                        <span class="info-value"><%= customer.getEmail() %></span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">Địa chỉ:</span>
                                        <span class="info-value"><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></span>
                                    </div>
                                    <div class="button-group">
                                        <button id="editButton" class="btn btn-primary" onclick="toggleEditMode()">Edit Profile</button>
                                        <form action="DeleteCustomerProfile" method="GET" style="display: inline-block;">
                                            <input type="hidden" name="userId" value="<%= customer.getId() %>">
                                            <button type="submit" class="btn btn-danger ml-2" onclick="return confirm('Are you sure you want to delete this profile?')">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% 
                            }
                        %>
                    </div>
                </div>

                <% if (customer == null) { %>
                <p class="text-center text-danger">Không tìm thấy khách hàng.</p>
                <% } %>

            </div>
        </div>

        <script>
            function toggleEditMode() {
                let form = document.getElementById("editForm");
                let viewMode = document.getElementById("viewMode");
                let editButton = document.getElementById("editButton");
                let avatarUpload = document.getElementById("avatarUpload");

                if (form.style.display === "none") {
                    form.style.display = "block";
                    viewMode.style.display = "none";
                    editButton.style.display = "none";
                    avatarUpload.style.display = "block";
                } else {
                    form.style.display = "none";
                    viewMode.style.display = "block";
                    editButton.style.display = "block";
                    avatarUpload.style.display = "none";
                }
            }

            function previewAvatar() {
                let file = document.getElementById("avatarInput").files[0];
                let reader = new FileReader();

                reader.onloadend = function () {
                    document.getElementById("avatarPreview").src = reader.result;
                };

                if (file) {
                    reader.readAsDataURL(file);
                }
            }

            function validateForm() {
                var phone = document.getElementById("phone").value;
                var email = document.getElementById("email").value;

                var phonePattern = /^[0-9]{10,11}$/;
                if (!phone.match(phonePattern)) {
                    alert("Số điện thoại không hợp lệ");
                    return false;
                }

                var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!email.match(emailPattern)) {
                    alert("Email không hợp lệ");
                    return false;
                }

                return true;
            }

            // Chức năng Cancel để quay lại trang cũ mà không thay đổi
            function cancelUpdate() {
                window.history.back();  // Quay lại trang trước đó mà không thay đổi gì
            }
        </script>
    </body>
</html>
