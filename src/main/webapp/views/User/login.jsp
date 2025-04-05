<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
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
                background: #ffffff;
                padding: 10px 20px;
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
                height: 50px;
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

            .login-container {
                display: flex;
                width: 1200px;
                height: 700px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                position: relative;
                margin-top: 20px;
            }

            .image-section {
                width: 600px;
                background: url('${pageContext.request.contextPath}/assets/img/login-poster.png') no-repeat center;
                background-size: cover;
            }

            .login-form {
                width: 600px;
                padding: 80px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-form h3 {
                font-size: 32px;
                font-weight: bold;
                color: #4a00e0;
                margin-bottom: 40px;
                text-align: center;
            }

            .google-login {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background: #fff;
                text-decoration: none;
                color: #333;
                font-size: 18px;
                margin-bottom: 30px;
                transition: color 0.3s;
            }

            .google-login img {
                width: 25px;
                margin-right: 10px;
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
                font-size: 18px;
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
                font-size: 18px;
                color: #333;
                margin-bottom: 8px;
            }

            .form-control {
                border-radius: 5px;
                padding: 12px;
                font-size: 18px;
                border: 1px solid #ddd;
                background: #f9f9f9;
            }

            .form-options {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 20px 0;
                font-size: 16px;
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
                padding: 14px;
                font-size: 20px;
                border-radius: 5px;
                color: white;
                transition: background 0.3s;
            }

            .btn-login:hover {
                background: #3a00b0;
            }

            .register-link {
                margin-top: 30px;
                font-size: 18px;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            .register-text {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .back-link {
                color: #4a00e0;
                font-size: 16px;
                text-decoration: none;
                transition: color 0.3s;
                margin-top: 8px;
                align-self: flex-end; /* Đẩy Back to Home sang phải */
            }

            .back-link i {
                margin-right: 8px;
            }

            .back-link:hover {
                color: #3a00b0;
                text-decoration: none;
            }

            @media (max-width: 1400px) {
                .login-container {
                    width: 90%;
                    height: auto;
                }
                .image-section, .login-form {
                    width: 100%;
                }
                .image-section {
                    height: 350px;
                    background-size: cover;
                }
                .login-form {
                    padding: 40px;
                }
                .back-link {
                    font-size: 14px;
                    margin-top: 6px;
                }
                header {
                    padding: 8px;
                }
                .logo {
                    height: 30px;
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
                    height: 25px;
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
                    <div class="register-text">
                        <span>Don't have an account?</span>
                        <a href="views/User/register.jsp">Register</a>
                    </div>
                    <a href="/Home" class="back-link"><i class="fas fa-arrow-left"></i> Back to Home</a>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>