<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Page</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">

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
            .register-card {
                width: 100%;
                max-width: 500px;
                padding: 30px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                background: white;
            }
            .btn-register {
                background-color: #ff6600;
                color: white;
                font-size: 16px;
                padding: 10px;
                border-radius: 6px;
                border: none;
                width: 100%;
            }
            .btn-register:hover {
                background-color: #e65c00;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <a href="/Home" class="btn btn-outline-light">Exit</a>
        </div>

        <div class="register-card">
            <h3 class="text-center">Register</h3>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger text-center">
                <%= errorMessage %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/Register" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username">Username *</label>
                    <input type="text" class="form-control" id="username" name="username" value="${username}" required>
                </div>
                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" class="form-control" id="name" name="name" value="${name}" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number *</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${phone}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email *</label>
                    <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                </div>

                <div class="form-group">
                    <label for="password">Password *</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <div class="form-group">
                    <label for="remake_password">Confirm Password *</label>
                    <input type="password" class="form-control" id="remake_password" name="remake_password" required>
                </div>

                <button type="submit" class="btn btn-register">REGISTER</button>
            </form>
            <div class="text-center mt-3">
                <a href="/Login">Back to Login</a>
            </div>
        </div>

        <script>
            function validateForm() {
                var password = document.getElementById("password").value;
                var remakePassword = document.getElementById("remake_password").value;
                var phone = document.getElementById("phone").value;
                var phoneRegex = /^[0-9]{10}$/;

                if (!phoneRegex.test(phone)) {
                    alert("Phone number must be 10 digits.");
                    return false;
                }

                if (password !== remakePassword) {
                    alert("Passwords do not match.");
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>
