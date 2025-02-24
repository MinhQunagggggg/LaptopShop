<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                background-image: url('${pageContext.request.contextPath}/assets/img/logoimage.png');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }

            .header {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                background: rgba(0, 0, 0, 0.7);
                padding: 10px 20px;
                display: flex;
                justify-content: flex-end;
            }

            .header a {
                color: white;
                text-decoration: none;
                font-size: 18px;
                font-weight: bold;
            }

            .login-card {
                width: 100%;
                max-width: 400px;
                padding: 40px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                background: white;
                position: relative;
                z-index: 10;
            }

            .login-container {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                height: 100vh;
            }

            .btn {
                font-size: 16px;
                padding: 12px;
                border-radius: 6px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <a href="/Home" class="btn btn-outline-light">Exit</a>
        </div>

        <div class="login-container">
            <div class="login-card">
                <h3 class="text-center">Sign In</h3>

                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) {%>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Login failed!</strong> <%= errorMessage%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
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

                    <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                    <div class="text-center mt-3">
                        <a href="/RequestPassword">Forgot Password?</a> | 
                        <a href="views/User/register.jsp">Create an account</a>
                    </div>
                </form>

                <hr>

                <div class="text-center">
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/Googlelogin&response_type=code&client_id=477587688262-srlo90s1bvkumuu67oud60pqfngvqcpo.apps.googleusercontent.com&approval_prompt=force">
                        <img src="${pageContext.request.contextPath}/assets/img/logogg.webp" alt="Sign in with Google" width="40">
                    </a>
                </div>
            </div>
        </div>
                    
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
