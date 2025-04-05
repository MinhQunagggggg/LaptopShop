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
            flex-direction: column;
            align-items: center;
            overflow: auto;
        }

        /* Thanh header */
        header {
            width: 100%;
            background: #ffffff;
            padding: 10px 20px; /* Giảm từ 15px xuống 10px */
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
            height: 50px; /* Giảm từ 70px xuống 50px */
            width: auto;
            transition: transform 0.3s ease;
        }

        .logo:hover {
            transform: scale(1.1);
        }

        .header-title {
            font-size: 24px;
            color: #4a00e0;
            font-weight: bold;
            margin-left: 20px;
            display: none;
        }

        .reset-container {
            display: flex;
            width: 1200px; /* Giảm từ 1400px xuống 1200px */
            height: 700px; /* Giảm từ 800px xuống 700px */
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            position: relative;
            margin-top: 20px;
        }

        .image-section {
            width: 600px; /* Giảm từ 700px xuống 600px */
            background: url('${pageContext.request.contextPath}/assets/img/login-poster.png') no-repeat center;
            background-size: cover;
        }

        .reset-form {
            width: 600px; /* Giảm từ 700px xuống 600px */
            padding: 80px; /* Tăng từ 60px lên 80px để đồng bộ với login */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .reset-form h3 {
            font-size: 32px;
            font-weight: bold;
            color: #4a00e0;
            margin-bottom: 40px; /* Tăng từ 20px lên 40px để đồng bộ */
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 18px; /* Đồng bộ với login */
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 5px;
            padding: 12px; /* Đồng bộ với login */
            font-size: 18px; /* Đồng bộ với login */
            border: 1px solid #ddd;
            background: #f9f9f9;
            width: 100%;
        }

        .btn-reset {
            background: #4a00e0;
            border: none;
            padding: 14px; /* Đồng bộ với login */
            font-size: 20px; /* Đồng bộ với login */
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
            bottom: 20px; /* Đặt ở góc dưới cùng */
            right: 20px; /* Đặt ở góc phải */
            font-size: 16px;
            transition: color 0.3s;
            z-index: 10;
        }

        .back-link i {
            margin-right: 8px;
        }

        .login-link {
            margin-top: 30px; /* Đồng bộ với login */
            font-size: 18px; /* Đồng bộ với login */
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .login-text {
            display: flex;
            align-items: center;
            gap: 8px;
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
                height: 350px; /* Giảm từ 400px xuống 350px để đồng bộ với login */
                background-size: cover;
            }

            .reset-form {
                padding: 40px; /* Đồng bộ với login */
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

            .back-link {
                bottom: 10px; /* Điều chỉnh cho màn hình nhỏ */
                right: 10px;
                font-size: 14px;
            }

            header {
                padding: 8px; /* Đồng bộ với login */
            }

            .logo {
                height: 30px; /* Đồng bộ với login */
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
                height: 25px; /* Đồng bộ với login */
            }
        }
    </style>
</head>
<body>
    <!-- Thanh header -->
    <header>
        <a href="/Home" style="text-decoration: none; color: inherit;">
            <div class="header-container">
                <img src="${pageContext.request.contextPath}/assets/img/logo.jpg" alt="TPF Shop Logo" class="logo">
                <span class="header-title">TPF Shop</span>
            </div>
        </a>
    </header>

    <div class="reset-container">
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
                    <label for="username">Username</label>
                    <input type="username" class="form-control" id="username" name="username" value="${username}" readonly required>
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
                <div class="login-text">
                    <span>Already have an account?</span>
                    <a href="/Login">Back to Login</a>
                </div>
            </div>
        </div>
        <a href="/Home" class="back-link"><i class="fas fa-arrow-left"></i> Back to Home</a>
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