<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- FontAwesome for Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-color: #f8f9fa;
            }

            .login-container {
                display: flex;
                flex: 1;
                width: 100%;
                height: 100vh;
            }

            .login-section {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: white;
            }

            .login-card {
                width: 100%;
                max-width: 400px;
                padding: 40px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                background: white;
            }

            .login-card h3 {
                font-size: 26px;
                font-weight: bold;
                margin-bottom: 25px;
                text-align: center;
            }

            .form-group label {
                font-size: 16px;
                font-weight: bold;
            }

            .btn {
                font-size: 16px;
                padding: 12px;
                border-radius: 6px;
            }

            .text-links a {
                font-size: 14px;
                text-decoration: none;
                color: #007bff;
            }

            .text-links a:hover {
                text-decoration: underline;
            }

            .image-section {
                flex: 1;
                background-image: url('${pageContext.request.contextPath}/assets/img/loginimage.png');
                background-size: cover;
                background-position: center;
            }

            .footer {
                width: 100%;
                background: #f1f1f1;
                text-align: center;
                padding: 10px 0;
                margin-top: auto;
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp" />

        <div class="login-container">
            <div class="login-section">
                <div class="login-card">
                    <h3>Sign In</h3>

                    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                    <% if (errorMessage != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Login failed!</strong> <%= errorMessage %>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <% } %>

                    <form action="Login" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Sign In</button>

                        <div class="text-center mt-3 text-links">
                            <a href="forgot-password.jsp">Forgot Password?</a> | 
                            <a href="views/User/register.jsp">Create an account</a>
                        </div>
                    </form>

                    <hr>

                    <div class="text-center">
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/Login&response_type=code&client_id=477587688262-srlo90s1bvkumuu67oud60pqfngvqcpo.apps.googleusercontent.com&approval_prompt=force">
                            <img src="${pageContext.request.contextPath}/assets/img/logogg.webp" alt="Sign in with Google" width="40">
                        </a>
                    </div>
                </div>
            </div>

            <div class="image-section"></div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
