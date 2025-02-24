<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password</title>
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

            .reset-card {
                width: 100%;
                max-width: 400px;
                padding: 40px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                background: white;
                position: relative;
                z-index: 10;
            }

            .reset-container {
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
            <a href="/Login" class="btn btn-outline-primary">Exit</a>
        </div>

        <div class="reset-container">
            <div class="reset-card">
                <h3 class="text-center">Reset Password</h3>

                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) {%>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error!</strong> <%= errorMessage%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <% }%>

                <% String successMessage = (String) request.getAttribute("successMessage"); %>
                <% if (successMessage != null) {%>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success!</strong> <%= successMessage%>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <% }%>

                <form action="ResetPassword" method="post">
                    <div class="form-group">
                        <label for="email">email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${email}"readonly required>
                    </div>
                    <div class="form-group">
                        <label for="password">New Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <div class="form-group">
                        <label for="confirm-password">Confirm Password</label>
                        <input type="password" class="form-control" id="confirm-password" name="confirm-password" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block">Reset Password</button>
                    <div class="text-center mt-3">
                        <a href="/Login">Back to Login</a>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
