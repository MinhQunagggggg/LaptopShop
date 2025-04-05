<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #fff;
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
        }

        .profile-container {
            max-width: 1000px;
            margin: 40px auto;
            display: flex;
            padding: 20px;
            gap: 20px;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #e9ecef;
        }

        .user-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin: 0 auto 15px;
            display: block;
            border: 2px solid #007bff;
        }

        .sidebar h5 {
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .sidebar .list-group-item {
            background: transparent;
            border: none;
            color: #555;
            font-weight: 600;
            padding: 12px 15px;
            border-radius: 5px;
        }

        .sidebar .list-group-item:hover,
        .sidebar .list-group-item.active {
            background: #007bff;
            color: white;
        }

        .sidebar a {
            color: inherit;
            text-decoration: none;
            display: block;
        }

        /* Profile Card */
        .profile-card {
            flex-grow: 1;
            border-radius: 10px;
            padding: 30px;
            background: #fff;
            border: 1px solid #e9ecef;
        }

        .profile-card h4 {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            text-align: center;
            margin-bottom: 25px;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        .form-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #007bff;
            font-size: 16px;
        }

        .form-control {
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 5px;
            padding: 10px 10px 10px 35px;
            font-size: 16px;
            color: #555;
        }

        .btn-edit {
            background: #007bff;
            border: none;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            color: white;
            width: 100%;
            margin-top: 20px;
        }

        .btn-edit:hover {
            background: #0056b3;
        }

        .alert {
            border-radius: 5px;
            padding: 12px;
            font-size: 15px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .profile-container {
                flex-direction: column;
                padding: 15px;
            }

            .sidebar {
                width: 100%;
                margin-bottom: 20px;
            }

            .user-avatar {
                width: 80px;
                height: 80px;
            }

            .sidebar h5 {
                font-size: 18px;
            }

            .profile-card {
                padding: 20px;
            }

            .profile-card h4 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <div class="container profile-container">
        <!-- Sidebar -->
        <div class="sidebar text-center">
            <c:choose>
                <c:when test="${not empty sessionScope.user.avatarData}">
                    <img src="UserImage?id=${sessionScope.user.id}" alt="User Avatar" class="user-avatar">
                </c:when>
                <c:otherwise>
                    <img src="assets/img/user.png" alt="User Avatar" class="user-avatar">
                </c:otherwise>
            </c:choose>
            <h5>${sessionScope.user.username}</h5>
            <ul class="list-group">
                <li class="list-group-item active"><a href="ViewProfile">Account Details</a></li>
                <li class="list-group-item"><a href="ChangePassword">Change Password</a></li>
                <li class="list-group-item"><a href="EditProfile">Edit Profile</a></li>
                <li class="list-group-item"><a href="Logout">Logout</a></li>
            </ul>
        </div>

        <!-- Profile Card -->
        <div class="profile-card">
            <h4>ACCOUNT DETAILS</h4>

            <% String success = request.getParameter("success"); %>
            <% String error = request.getParameter("error"); %>
            <% if ("true".equals(success)) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success!</strong> Profile updated successfully!
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
            <% } else if ("true".equals(error)) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error!</strong> Failed to update profile. Please try again.
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
            <% } %>

            <form>
                <div class="form-group">
                    <i class="fas fa-user"></i>
                    <input type="text" class="form-control" value="${sessionScope.user.username}" placeholder="User Name" readonly>
                </div>
                <div class="form-group">
                    <i class="fas fa-envelope"></i>
                    <input type="email" class="form-control" value="${sessionScope.user.email}" placeholder="Email" readonly>
                </div>
                <div class="form-group">
                    <i class="fas fa-id-card"></i>
                    <input type="text" class="form-control" value="${sessionScope.user.name}" placeholder="Name" readonly>
                </div>
                <div class="form-group">
                    <i class="fas fa-phone"></i>
                    <input type="text" class="form-control" value="${sessionScope.user.phone}" placeholder="Phone Number" readonly>
                </div>
                <div class="form-group">
                    <i class="fas fa-map-marker-alt"></i>
                    <input type="text" class="form-control" value="${sessionScope.user.address}" placeholder="Address" readonly>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>