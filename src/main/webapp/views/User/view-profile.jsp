<%-- 
    Document   : view-profile
    Created on : Feb 24, 2025, 4:41:02 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <style>body {
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 10px;
        }

        .card-header {
            font-size: 1.2rem;
            font-weight: bold;
        }

        .form-control {
            background-color: #f8f9fa;
            font-size: 1rem;
        }

        .btn-warning {
            font-weight: bold;
            border-radius: 5px;
        }
    </style>
    <body>
        <jsp:include page="menu.jsp" />

        <section class="main_content_area mt-4">
            <div class="container">   
                <div class="row">
                    <!-- Sidebar -->
                    <div class="col-md-3">
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action active">Profile</a>
                            <a href="user?action=logout" class="list-group-item list-group-item-action text-danger">Logout</a>
                        </div>    
                    </div>

                    <!-- Profile Content -->
                    <div class="col-md-9">
                        <div class="card shadow-lg">
                            <div class="card-header bg-primary text-white text-center">
                                <h4>Profile Information</h4>
                            </div>
                            <div class="card-body">
                                <div class="text-center">
                                    <img src="${sessionScope.user.avatar_url}" class="rounded-circle mb-3" width="120" height="120" alt="Avatar">
                                </div>

                                <form>
                                    <div class="form-group">
                                        <label>Username</label>
                                        <input type="text" class="form-control" value="${sessionScope.user.username}" readonly>
                                    </div>

                                    <div class="form-group">
                                        <label>Full Name</label>
                                        <input type="text" class="form-control" value="${sessionScope.user.name}" readonly>
                                    </div>

                                    <div class="form-group">
                                        <label>Phone</label>
                                        <input type="text" class="form-control" value="${sessionScope.user.phone}" readonly>
                                    </div>

                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="email" class="form-control" value="${sessionScope.user.email}" readonly>
                                    </div>

                                    <div class="text-center">
                                        <a href="editProfile.jsp" class="btn btn-warning">Edit Profile</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>  
            </div>        	
        </section>

        <jsp:include page="footer.jsp" />
    </body>
</html>
