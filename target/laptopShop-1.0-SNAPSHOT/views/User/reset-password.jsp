<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Reset Password</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            font-family: 'Arial', sans-serif;
            background: #f5f7fa;
            display: flex;
            flex-direction: column; /* Thêm để header và container xếp chồng */
            align-items: center;
            overflow: auto;
        }

        /* Thanh header */
        header {
            width: 100%;
            background: #ffffff; /* Nền trắng cho header */
            padding: 15px 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            z-index: 1000;
            position: relative;
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            height: 70px; /* Kích thước hợp lý cho logo */
            width: auto;
            transition: transform 0.3s ease; /* Hiệu ứng phóng to khi hover */
        }

        .logo:hover {
            transform: scale(1.1); /* Phóng to nhẹ khi hover */
        }

        .header-title {
            font-size: 24px;
            color: #4a00e0; /* Màu chữ tím để đồng bộ với giao diện */
            font-weight: bold;
            margin-left: 20px;
            display: none; /* Ẩn trên màn hình nhỏ */
        }

        .reset-container {
            display: flex;
            width: 1400px;
            height: 800px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            position: relative;
            margin-top: 20px; /* Khoảng cách từ header */
        }

        .image-section {
            width: 700px;
            background: url('${pageContext.request.contextPath}/assets/img/login-poster.png') no-repeat center;
            background-size: cover;
        }

        .reset-form {
            width: 700px;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .reset-form h3 {
            font-size: 32px;
            font-weight: bold;
            color: #4a00e0;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-control {
            border-radius: 5px;
            padding: 12px;
            font-size: 18px;
            border: 1px solid #ddd;
            background: #f9f9f9;
            width: 100%;
        }

        .btn-reset {
            background: #4a00e0;
            border: none;
            padding: 14px;
            font-size: 20px;
            border-radius: 5px;
            color: white;
            transition: background 0.3s;
            margin-top: 20px;
        }

        .btn-reset:hover {
            background: #3a00b0;
        }

        .back-link,
        .login-link a {
            color: #4a00e0;
            text-decoration: none;
        }

        .back-link:hover,
        .login-link a:hover {
            color: #3a00b0;
            text-decoration: none;
        }

        .back-link {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 16px;
            transition: color 0.3s;
            z-index: 10;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
        }

        .message {
            margin-bottom: 20px;
        }

        @media (max-width: 1400px) {
            .reset-container {
                width: 90%;
                height: auto;
                flex-direction: column;
            }

            .image-section,
            .reset-form {
                width: 100%;
            }

            .image-section {
                height: 400px;
                background-size: cover;
            }

            .reset-form {
                padding: 40px;
                height: auto;
            }

            .reset-form h3 {
                font-size: 26px;
            }

            .form-group {
                margin-bottom: 10px;
            }

            .form-control {
                padding: 10px;
                font-size: 16px;
            }

            .btn-reset {
                padding: 12px;
                font-size: 18px;
                margin-top: 15px;
            }

            .login-link {
                margin-top: 20px;
                font-size: 16px;
            }

            .message {
                margin-bottom: 20px;
            }

            .back-link {
                top: 10px;
                right: 10px;
                font-size: 14px;
            }

            header {
                padding: 10px;
            }

            .logo {
                height: 35px; /* Thu nhỏ logo trên màn hình nhỏ */
            }

            .header-title {
                font-size: 20px;
            }
        }

        @media (max-width: 768px) {
            .header-title {
                display: none;
            }
            .header-container {
                justify-content: center;
            }
            .logo {
                height: 30px; /* Thu nhỏ thêm trên màn hình rất nhỏ */
            }
        }
    </style>
</head>
<body>
    <!-- Thanh header -->
    <header>
        <div class="header-container">
            <img src="${pageContext.request.contextPath}/assets/img/logo.jpg" alt="TPF Shop Logo" class="logo">
            <span class="header-title">TPF Shop</span>
        </div>
    </header>

    <div class="reset-container">
        <a href="/Home" class="back-link">Back to Home</a>
        <div class="image-section"></div>
        <div class="reset-form">
            <h3>RESET PASSWORD</h3>

            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <div class="message">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Error!</strong> <%= errorMessage %>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                </div>
            <% } %>

            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (successMessage != null) { %>
                <div class="message">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>Success!</strong> <%= successMessage %>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/ResetPassword" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${email}" readonly required>
                </div>
                <div class="form-group">
                    <label for="password">New Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" class="form-control" id="confirm-password" name="confirm-password" required>
                </div>
                <button type="submit" class="btn btn-reset btn-block">Reset Password</button>
            </form>

            <div class="login-link">
                <a href="/Login">Back to Login</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm-password").value;
            var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

            if (!passwordRegex.test(password)) {
                alert("Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character (@$!%*?&).");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>