<!DOCTYPE html>
<html lang="vi">
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
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-color: #f8f9fa;
            }
            .register-container {
                display: flex;
                flex: 1;
                width: 100%;
                height: 100vh;
            }
            .register-section {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: white;
            }
            .register-card {
                width: 100%;
                max-width: 400px;
                padding: 40px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                background: white;
            }
            .register-card h3 {
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
                background-image: url('<%= request.getContextPath() %>/assets/img/loginimage.png');
                background-size: cover;
                background-position: center;
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp" />

        <div class="register-container">
            <div class="register-section">
                <div class="register-card">
                    <h3>Sign Up</h3>

                    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                    <% if (errorMessage != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Registration failed!</strong> <%= errorMessage %>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/Register" method="post" onsubmit="return validateForm()">

                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="text" class="form-control" id="phone" name="phone" 
                                   value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username" 
                                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <div class="form-group">
                            <label for="remake_password">Re-enter Password</label>
                            <input type="password" class="form-control" id="remake_password" name="remake_password" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Register</button>
                    </form>
                </div>
            </div>

            <div class="image-section"></div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            function validateForm() {
                var password = document.getElementById("password").value;
                var remakePassword = document.getElementById("remake_password").value;
                var phone = document.getElementById("phone").value;
                var phoneRegex = /^[0-9]{10}$/; // Ch? ch?p nh?n 10 s?

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
