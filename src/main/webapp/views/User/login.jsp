<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"> <!-- Prevent zooming -->
        <title>TPF Shop Login</title>
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

            .login-container {
                display: flex;
                width: 1400px;
                height: 800px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                position: relative;
                margin-top: 20px;
            }

            .image-section {
                width: 700px;
                background: url('${pageContext.request.contextPath}/assets/img/login-poster.png') no-repeat center;
                background-size: cover;
            }

            .login-form {
                width: 700px;
                padding: 100px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-form h2 {
                font-size: 36px;
                font-weight: bold;
                color: #000;
                margin-bottom: 10px;
            }

            .login-form h3 {
                font-size: 32px;
                font-weight: bold;
                color: #4a00e0;
                margin-bottom: 40px;
            }

            .google-login {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                padding: 16px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background: #fff;
                text-decoration: none;
                color: #333;
                font-size: 20px;
                margin-bottom: 40px;
                transition: color 0.3s;
            }

            .google-login img {
                width: 30px;
                margin-right: 15px;
            }

            .google-login:hover {
                color: #3a00b0;
                text-decoration: none;
            }

            .divider {
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 20px 0;
                color: #999;
                font-size: 20px;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: #ddd;
                margin: 0 15px;
            }

            .form-group label {
                font-size: 20px;
                color: #333;
                margin-bottom: 10px;
            }

            .form-control {
                border-radius: 5px;
                padding: 16px;
                font-size: 20px;
                border: 1px solid #ddd;
                background: #f9f9f9;
            }

            .form-options {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 30px 0;
                font-size: 20px;
            }

            .form-options a,
            .back-link,
            .register-link a {
                color: #4a00e0;
                text-decoration: none;
            }

            .form-options a:hover,
            .back-link:hover,
            .register-link a:hover {
                color: #3a00b0;
                text-decoration: none;
            }

            .btn-login {
                background: #4a00e0;
                border: none;
                padding: 18px;
                font-size: 22px;
                border-radius: 5px;
                color: white;
                transition: background 0.3s;
            }

            .btn-login:hover {
                background: #3a00b0;
            }

            .register-link {
                text-align: center;
                margin-top: 40px;
                font-size: 20px;
            }

            .back-link {
                position: absolute;
                bottom: 20px; /* Đặt ở dưới cùng, cách 20px */
                right: 20px;  /* Đặt ở bên phải, cách 20px */
                color: #4a00e0;
                font-size: 16px;
                text-decoration: none;
                transition: color 0.3s;
                z-index: 10;
            }

            .back-link i {
                margin-right: 8px; /* Khoảng cách giữa icon và văn bản */
            }

            .back-link:hover {
                color: #3a00b0;
                text-decoration: none;
            }

            @media (max-width: 1400px) {
                .login-container {
                    width: 90%;
                    height: auto;
                    flex-direction: column;
                }
                .image-section, .login-form {
                    width: 100%;
                }
                .image-section {
                    height: 400px;
                    background-size: cover;
                }
                .login-form {
                    padding: 50px;
                }
                .back-link {
                    bottom: 10px; /* Điều chỉnh khoảng cách dưới trên màn hình nhỏ */
                    right: 10px;  /* Điều chỉnh khoảng cách phải trên màn hình nhỏ */
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

        <div class="login-container">
            <div class="image-section"></div>
            <div class="login-form">
                <h3>Welcome to TPF SHOP</h3>

                <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/Googlelogin&response_type=code&client_id=477587688262-srlo90s1bvkumuu67oud60pqfngvqcpo.apps.googleusercontent.com&approval_prompt=force" class="google-login">
                    <img src="${pageContext.request.contextPath}/assets/img/logogg.webp" alt="Google Logo">
                    Login with Google
                </a>

                <div class="divider">OR</div>

                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) {%>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Login Failed!</strong> <%= errorMessage%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <% }%>

                <form action="Login" method="post">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <div class="form-options">
                        <div>
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember">Remember Me</label>
                        </div>
                        <a href="/RequestPassword">Forgot Password?</a>
                    </div>

                    <button type="submit" class="btn btn-login btn-block">Login</button>
                </form>

                <div class="register-link">
                    Don't have an account? <a href="views/User/register.jsp">Register</a>
                </div>
            </div>
            <a href="/Home" class="back-link"><i class="fas fa-arrow-left"></i> Back to Home</a>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>