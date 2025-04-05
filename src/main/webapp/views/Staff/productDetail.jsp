<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Base64" %>
<%@ page import="Model_Staff.Comment" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Sản Phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                color: #333;
            }
            .container {
                margin-top: 40px;
                background: #fff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            }
            h1, h2 {
                font-weight: 700;
                color: #dc3545;
                text-align: center;
                margin-bottom: 30px;
            }
            h1 i, h2 i {
                margin-right: 10px;
                color: #ff4d4d;
            }
            .product-details {
                display: flex;
                justify-content: center;
                gap: 50px;
                margin-bottom: 40px;
            }
            .product-img {
                flex: 1;
                text-align: center;
            }
            .product-img img {
                width: 100%;
                max-width: 400px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            .product-info {
                flex: 2;
            }
            .product-info h2 {
                font-size: 34px;
                color: #222;
            }
            .product-info p {
                font-size: 20px;
                margin: 10px 0;
            }
            .product-info .price {
                font-size: 26px;
                font-weight: 600;
                color: #dc3545;
            }
            .specifications {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-size: 18px;
            }
            .specifications th, .specifications td {
                padding: 15px;
                border: 2px solid #d1d3e2;
            }
            .specifications th {
                background-color: #ff4d4d;
                color: #fff;
                text-align: left;
                font-weight: 600;
            }
            .specifications td i {
                margin-right: 8px;
                color: #6c757d;
            }
            .specifications tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .specifications tr:hover {
                background-color: #ffe6e6;
            }
            .form-select {
                width: auto;
                display: inline-block;
                margin-bottom: 20px;
            }

            /* Cải thiện giao diện phần bình luận */
            .comments-section {
                margin-top: 20px;
            }

            .comment {
                position: relative;
                padding: 15px;
                margin: 10px 0;
                border-radius: 8px;
                background-color: #f8f9fa;
            }

            /* Bình luận gốc - không có khung */
            .comment.level-0 {
                background-color: #f8f9fa;
                border: none; /* Bỏ khung cho bình luận gốc */
            }

            /* Bình luận reply - có khung */
            .comment:not(.level-0) {
                margin-left: 40px;
                border-radius: 8px;
            }

            /* Level 1 - viền đậm */
            .comment.level-1 {
                border: 2px solid #6c757d; /* Viền đậm cho level 1 */
            }

            /* Level 2 trở lên - viền nhạt */
            .comment.level-2,
            .comment.level-3,
            .comment.level-4,
            .comment.level-5,
            .comment.level-6,
            .comment.level-7,
            .comment.level-8,
            .comment.level-9,
            .comment.level-10 {
                border: 1px solid #ced4da; /* Viền nhạt cho level 2 trở lên */
            }

            .comment .user-info {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
            }

            .comment .user-info img {
                border: 2px solid #ddd;
                margin-right: 10px;
                border-radius: 50%;
                width: 40px;
                height: 40px;
            }

            .comment .user-info strong {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .comment .user-info .text-muted {
                font-size: 13px;
                margin-left: 10px;
                color: #888;
            }

            .comment .content {
                font-size: 15px;
                line-height: 1.5;
                margin-bottom: 10px;
                color: #444;
            }

            .comment .parent-content {
                font-size: 14px;
                color: #555;
                background-color: #e9ecef;
                padding: 8px 12px;
                border-radius: 5px;
                margin-bottom: 10px;
                border-left: 3px solid #007bff;
            }

            .comment .parent-content strong {
                color: #007bff;
                font-weight: 600;
            }

            .comment-actions {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
            }

            .btn-sm {
                padding: 6px 12px;
                font-size: 14px;
                border-radius: 5px;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
                color: #fff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .btn-danger {
                background-color: #dc3545;
                border: none;
                color: #fff;
            }

            .btn-danger:hover {
                background-color: #c82333;
            }

            .btn-success {
                background-color: #28a745;
                border: none;
                color: #fff;
            }

            .btn-success:hover {
                background-color: #218838;
            }

            .reply-form {
                margin-top: 10px;
                padding: 10px;
                background-color: #f1f3f5;
                border-radius: 5px;
            }

            .reply-form textarea {
                resize: none;
                font-size: 14px;
                width: 100%;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 8px;
            }

            .reply-form textarea:focus {
                border-color: #007bff;
                outline: none;
            }

            /* Hiệu ứng đặc biệt cho tên của Staff */
            .text-purple {
                color: #6f42c1;
                font-weight: 600;
                text-shadow: 0 0 5px rgba(111, 66, 193, 0.7), 0 0 10px rgba(111, 66, 193, 0.5); /* Hiệu ứng phát sáng */
                animation: glow 1.5s ease-in-out infinite alternate; /* Hiệu ứng nhấp nháy nhẹ */
            }

            /* Keyframes cho hiệu ứng nhấp nháy */
            @keyframes glow {
                from {
                    text-shadow: 0 0 5px rgba(111, 66, 193, 0.7), 0 0 10px rgba(111, 66, 193, 0.5);
                }
                to {
                    text-shadow: 0 0 10px rgba(111, 66, 193, 0.9), 0 0 20px rgba(111, 66, 193, 0.7);
                }
            }
        </style>
    </head>
    <body>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <script>
                // Lấy giá trị từ EL và đảm bảo là string
                const fullName = "${user.name != null ? user.name : 'Guest'}"; // Thêm dấu nháy và xử lý null
                const lastName = fullName.split(" ").pop(); // Lấy tên cuối
                console.log(lastName); // Kết quả: "Minh" nếu fullName là "Tran Nhat Minh"

                // Kiểm tra độ dài lastName và quyết định giá trị hiển thị
                const displayText = lastName.length > 15 ? "Hello, Staff" : "Hello, " + lastName;

                // Gán giá trị vào HTML
                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelector(".navbar-brand p").textContent = displayText;
                });
            </script>
            <a class="navbar-brand ps-3" href="Dashboard"><p></p></a> <!-- Ban đầu để trống -->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <ul class="navbar-nav ms-auto ms-md-10 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <form action="CustomerProfileDetail" method="post" style="display: inline;">
                            <input type="hidden" name="userId" value="${user.id}">
                            <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 6px 12px; text-align: left; width: 100%; color: inherit; cursor: pointer;">My Profile</button>
                        </form>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="Logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="Dashboard"><div class="sb-nav-link-icon"><i class="fas fa-chart-line"></i></div>Dashboard</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/OrderList"><div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>Order List</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewProducts"><div class="sb-nav-link-icon"><i class="fas fa-box-open"></i></div>View Products</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/CustomerList"><div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>View Customer List</a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarranty"><div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>View Warranty</a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">                 
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard /View ProductDetail</li>
                        </ol>

                        <div class="container">
                            <h1><i class="fas fa-box"></i> Product Detail</h1>

                            <!-- Product Details -->
                            <div class="product-details">
                                <div class="product-img">
                                    <c:choose>
                                        <c:when test="${not empty imageBase64}">
                                            <img src="${imageBase64}" alt="Sản phẩm">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/images/default-product.jpg" alt="Ảnh mặc định">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="product-info">
                                    <h2><c:out value="${product.name}" /></h2>
                                    <p><strong><i class="fas fa-info-circle"></i> Describe:</strong> <c:out value="${product.description}" /></p>
                                    <p class="price"><i class="fas fa-tag"></i> Price: <fmt:formatNumber value="${product.price}" pattern="#,###" /> VND</p>
                                    <h3 class="text-warning"><i class="fas fa-star"></i> 
                                        <c:choose>
                                            <c:when test="${empty averageRating or averageRating == 0}">0 / 5</c:when>
                                            <c:otherwise><fmt:formatNumber value="${averageRating}" pattern="#.0" /> / 5</c:otherwise>
                                        </c:choose>
                                    </h3>
                                </div>
                            </div>

                            <!-- Specifications -->
                            <h2><i class="fas fa-cogs"></i> Specifications</h2>
                            <table class="specifications">
                                <% int catalogId = (int) request.getAttribute("catalog_id"); %>
                                <% if (catalogId == 1) { %>
                                <tr><th><i class="fas fa-microchip"></i> CPU</th><td>${productSpec.cpu}</td></tr>
                                <tr><th><i class="fas fa-hdd"></i> Storage</th><td>${productSpec.storage}</td></tr>
                                <tr><th><i class="fas fa-desktop"></i> Resolution</th><td>${productSpec.resolution}</td></tr>
                                <tr><th><i class="fas fa-video"></i> Graphics Card</th><td>${productSpec.graphics}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Ports</th><td>${productSpec.ports}</td></tr>
                                <tr><th><i class="fas fa-wifi"></i> Wireless</th><td>${productSpec.wireless}</td></tr>
                                <tr><th><i class="fas fa-camera"></i> Camera</th><td>${productSpec.camera}</td></tr>
                                <tr><th><i class="fas fa-battery-full"></i> Battery</th><td>${productSpec.battery}</td></tr>
                                <tr><th><i class="fas fa-ruler"></i> Dimensions</th><td>${productSpec.dimensions}</td></tr>
                                <tr><th><i class="fas fa-weight"></i> Weight</th><td>${productSpec.weight}</td></tr>
                                <tr><th><i class="fas fa-keyboard"></i> Keyboard</th><td>${productSpec.keyboard}</td></tr>
                                <tr><th><i class="fas fa-cube"></i> Material</th><td>${productSpec.material}</td></tr>
                                <tr><th><i class="fas fa-laptop"></i> Operating System</th><td>${productSpec.os}</td></tr>
                                <tr><th><i class="fas fa-check-circle"></i> Condition</th><td>${productSpec.condition}</td></tr>
                                <tr><th><i class="fas fa-sync"></i> Refresh Rate</th><td>${productSpec.refreshRate}</td></tr>
                                <tr><th><i class="fas fa-memory"></i> RAM</th><td>${productSpec.ram}</td></tr>
                                        <% } else if (catalogId == 2) { %>
                                <tr><th><i class="fas fa-tv"></i> Model</th><td>${productSpec.model}</td></tr>
                                <tr><th><i class="fas fa-ruler"></i> Size</th><td>${productSpec.size} inch</td></tr>
                                <tr><th><i class="fas fa-layer-group"></i> Panel Type</th><td>${productSpec.panelType}</td></tr>
                                <tr><th><i class="fas fa-desktop"></i> Resolution</th><td>${productSpec.resolution}</td></tr>
                                <tr><th><i class="fas fa-sun"></i> Brightness</th><td>${productSpec.brightness} nits</td></tr>
                                <tr><th><i class="fas fa-sync"></i> Refresh Rate</th><td>${productSpec.refreshRate} Hz</td></tr>
                                <tr><th><i class="fas fa-eye"></i> HDR</th><td>${productSpec.hdr}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Ports</th><td>${productSpec.ports}</td></tr>
                                <tr><th><i class="fas fa-volume-up"></i> Audio Output</th><td>${productSpec.audioOut ? 'Yes' : 'No'}</td></tr>
                                        <% } else if (catalogId == 3) { %>
                                <tr><th><i class="fas fa-trademark"></i> Brand</th><td>${productSpec.brand}</td></tr>
                                <tr><th><i class="fas fa-link"></i> Connection</th><td>${productSpec.connectionType}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Wired</th><td>${productSpec.wired ? 'Yes' : 'No'}</td></tr>
                                <tr><th><i class="fas fa-tachometer-alt"></i> DPI</th><td>${productSpec.dpi}</td></tr>
                                <tr><th><i class="fas fa-toggle-on"></i> Switch Type</th><td>${productSpec.switchType}</td></tr>
                                <tr><th><i class="fas fa-lightbulb"></i> LED</th><td>${productSpec.mouseLed}</td></tr>
                                        <% } else if (catalogId == 4) { %>
                                <tr><th><i class="fas fa-trademark"></i> Brand</th><td>${productSpec.brand}</td></tr>
                                <tr><th><i class="fas fa-link"></i> Connection</th><td>${productSpec.connectionType}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Wired</th><td>${productSpec.wired ? 'Yes' : 'No'}</td></tr>
                                <tr><th><i class="fas fa-cube"></i> Keycap Material</th><td>${empty productSpec.keycapMaterial ? 'No data' : productSpec.keycapMaterial}</td></tr>
                                <tr><th><i class="fas fa-toggle-on"></i> Switch Type</th><td>${empty productSpec.switchType ? 'No data' : productSpec.switchType}</td></tr>
                                <tr><th><i class="fas fa-palette"></i> Color</th><td>${empty productSpec.color ? 'No data' : productSpec.color}</td></tr>
                                <tr><th><i class="fas fa-lightbulb"></i> LED</th><td>${empty productSpec.ledColor ? 'No' : productSpec.ledColor}</td></tr>
                                <tr><th><i class="fas fa-ruler"></i> Dimensions</th><td>${empty productSpec.dimensions ? 'No data' : productSpec.dimensions}</td></tr>
                                <tr><th><i class="fas fa-weight"></i> Weight</th><td><c:out value="${not empty productSpec.weight ? productSpec.weight : 'No data'}" /> kg</td></tr>
                                <tr><th><i class="fas fa-battery-full"></i> Battery Capacity</th><td><c:out value="${not empty productSpec.batteryCapacity ? productSpec.batteryCapacity : 'No'}" /> mAh</td></tr>
                                <tr><th><i class="fas fa-keyboard"></i> Keycap Profile</th><td><c:out value="${not empty productSpec.keycapProfile ? productSpec.keycapProfile : 'No data'}" /></td></tr>
                                        <% } else if (catalogId == 5) { %>
                                <tr><th><i class="fas fa-trademark"></i> Brand</th><td>${productSpec.brand}</td></tr>
                                <tr><th><i class="fas fa-link"></i> Connection</th><td>${productSpec.connectionType}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Wired</th><td>${productSpec.wired ? 'Yes' : 'No'}</td></tr>
                                <tr><th><i class="fas fa-palette"></i> Color</th><td>${productSpec.color}</td></tr>
                                <tr><th><i class="fas fa-lightbulb"></i> LED</th><td>${productSpec.ledColor}</td></tr>
                                <tr><th><i class="fas fa-wave-square"></i> Frequency Range</th><td>${productSpec.frequencyRange}</td></tr>
                                <tr><th><i class="fas fa-headphones"></i> Driver Size</th><td>${productSpec.driverSize} mm</td></tr>
                                        <% } else { %>
                                <tr><td colspan="2" class="text-danger text-center"><i class="fas fa-exclamation-circle"></i> No specifications available for this product.</td></tr>
                                <% } %>
                            </table>
                            <!-- Ratings -->
                            <h2><i class="fas fa-star"></i> Rating Summary</h2>
                            <div class="text-center mb-4">
                                <h3 class="text-warning"><i class="fas fa-star"></i> 
                                    <c:choose>
                                        <c:when test="${empty averageRating or averageRating == 0}">0 / 5</c:when>
                                        <c:otherwise><fmt:formatNumber value="${averageRating}" pattern="#.0" /> / 5</c:otherwise>
                                    </c:choose>
                                </h3>
                                <p class="text-muted">(${totalRatings} ratings | ${numbercmt} comments)</p>
                            </div>

                            <h2><i class="fas fa-list"></i> Review List</h2>
                            <select id="filterRating" class="form-select" onchange="filterRatings()">
                                <option value="all">All</option>
                                <option value="5">5 stars</option>
                                <option value="4">4 stars</option>
                                <option value="3">3 stars</option>
                                <option value="2">2 stars</option>
                                <option value="1">1 star</option>
                            </select>
                            <c:forEach var="rate" items="${ratings}" varStatus="status">
                                <div class="rating p-3 border rounded mb-2 rating-item ${status.index < 5 ? 'visible' : ''}" data-rating="${rate.rating}">
                                    <div class="d-flex align-items-center">
                                        <c:choose>
                                            <c:when test="${not empty rate.imageUser}">
                                                <img src="data:image/png;base64,${Base64.getEncoder().encodeToString(rate.imageUser)}" class="rounded-circle me-2" width="40" height="40" alt="User">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/default-avatar.png" class="rounded-circle me-2" width="40" height="40" alt="User">
                                            </c:otherwise>
                                        </c:choose>
                                        <strong class="text-primary"><c:out value="${rate.name}" /></strong>
                                    </div>
                                    <p class="mt-1">Rating: 
                                        <c:forEach begin="1" end="${rate.rating}"><i class="fas fa-star text-warning"></i></c:forEach>
                                        <c:forEach begin="${rate.rating + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                                        </p>
                                    </div>
                            </c:forEach>
                            <c:if test="${empty ratings}">
                                <p class="text-muted text-center"><i class="fas fa-exclamation-circle"></i> No reviews yet.</p>
                            </c:if>
                            <button id="toggleReviews" class="btn btn-link mt-2"><i class="fas fa-angle-down"></i> See more reviews</button>

                            <!-- Comments -->
                            <h2><i class="fas fa-comments"></i> Comment</h2>
                            <div class="comments-section">
                                <c:if test="${empty comments}">
                                    <p class="text-muted text-center"><i class="fas fa-exclamation-circle"></i> No comments yet.</p>
                                </c:if>
                                <c:if test="${not empty comments}">
                                    <%-- Hàm đệ quy để hiển thị bình luận --%>
                                    <%!
                                        public void renderComment(JspWriter out, Comment comment, int level, java.util.List<Comment> allComments) throws java.io.IOException {
                                            if (comment == null) return; // Kiểm tra null cho comment

                                            String indentClass = "level-" + level;
                                            String userClass = "text-primary"; // Mặc định cho user (role_id = 1)
                                            if (comment.getRole_id() == 3) userClass = "text-danger"; // Admin
                                            if (comment.getRole_id() == 2) userClass = "text-purple"; // Staff

                                            out.println("<div class='comment " + indentClass + "' id='comment-" + comment.getCommentId() + "'>");
                                            out.println("<div class='user-info'>");
                                            if (comment.getImageUser() != null && comment.getImageUser().length > 0) {
                                                out.println("<img src='data:image/png;base64," + Base64.getEncoder().encodeToString(comment.getImageUser()) + "' class='rounded-circle me-2' width='40' height='40' alt='User'>");
                                            } else {
                                                out.println("<img src='${pageContext.request.contextPath}/images/default-avatar.png' class='rounded-circle me-2' width='40' height='40' alt='User'>");
                                            }
                                            out.println("<strong class='" + userClass + "'>" + (comment.getUserName() != null ? comment.getUserName() : "Ẩn danh") + "</strong>");
                                            out.println("<span class='text-muted ms-2'>(" + (comment.getCreatedAt() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(comment.getCreatedAt()) : "Không rõ thời gian") + ")</span>");
                                            out.println("</div>");

                                            // Hiển thị nội dung bình luận hoặc "Bình luận đã bị xóa" nếu bị xóa
                                            out.println("<p class='content'>" + (comment.isDeleted() ? "<span class='text-muted fst-italic'>(Bình luận đã bị xóa)</span>" : (comment.getContent() != null ? comment.getContent() : "")) + "</p>");

                                            // Nếu là reply, hiển thị nội dung bình luận gốc
                                            if (comment.getParentCommentId() != null) {
                                                String parentUserName = "(Comment is deleted)";
                                                String parentContent = "(Comment is deleted)";
                                                if (allComments != null) {
                                                    for (Comment c : allComments) {
                                                        if (c != null && c.getCommentId() == comment.getParentCommentId()) {
                                                            parentUserName = c.getUserName() != null ? c.getUserName() : "???";
                                                            parentContent = c.isDeleted() ? "(Comment is deleted)" : (c.getContent() != null ? c.getContent() : "");
                                                            break;
                                                        }
                                                    }
                                                }
                                                out.println("<p class='parent-content'><strong class='text-info'>@" + parentUserName + ":</strong> \"" + parentContent + "\"</p>");
                                            }

                                            // Chỉ hiển thị nút Reply/Delete nếu bình luận chưa bị xóa
                                            if (!comment.isDeleted()) {
                                                out.println("<div class='comment-actions'>");
                                                out.println("<button class='btn btn-primary btn-sm reply-btn' data-comment-id='" + comment.getCommentId() + "'><i class='fas fa-reply'></i> Reply</button>");
                                                out.println("<button class='btn btn-danger btn-sm delete-btn' data-comment-id='" + comment.getCommentId() + "'><i class='fas fa-trash'></i> Delete</button>");
                                                out.println("</div>");
                                                out.println("<div class='reply-form mt-2 d-none' id='reply-form-" + comment.getCommentId() + "'>");
                                                out.println("<textarea class='form-control' rows='2' placeholder='Enter...'></textarea>");
                                                out.println("<button class='btn btn-success btn-sm mt-2 submit-reply' data-parent-id='" + comment.getCommentId() + "'><i class='fas fa-paper-plane'></i> Submit</button>");
                                                out.println("</div>");
                                            }

                                            // Đệ quy để hiển thị replies, ngay cả khi comment bị xóa
                                            if (comment.getReplies() != null && !comment.getReplies().isEmpty()) {
                                                for (Comment reply : comment.getReplies()) {
                                                    renderComment(out, reply, level + 1, allComments);
                                                }
                                            }
                                            out.println("</div>");
                                        }
                                    %>
                                    <% 
                                        java.util.List<Comment> allComments = (java.util.List<Comment>) request.getAttribute("allComments");
                                        java.util.List<Comment> rootComments = (java.util.List<Comment>) request.getAttribute("comments");
                                        if (rootComments != null && allComments != null) {
                                            for (Comment comment : rootComments) {
                                                renderComment(out, comment, 0, allComments);
                                            }
                                        } else {
                                            out.println("<p class='text-muted text-center'><i class='fas fa-exclamation-circle'></i> Eror loading comment.</p>");
                                        }
                                    %>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Modal Popup Xóa Bình Luận -->
        <div class="modal fade" id="deleteCommentModal" tabindex="-1" aria-labelledby="deleteCommentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteCommentModalLabel"><i class="fas fa-trash-alt"></i> Do you want to delete comment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                         Do you want to delete comment
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="fas fa-times"></i>Cancle</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn"><i class="fas fa-trash"></i> OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/Staffacj/js/datatables-simple-demo.js"></script>
        <script>
    function filterRatings() {
        let selectedRating = document.getElementById('filterRating').value;
        document.querySelectorAll('.rating-item').forEach(item => {
            item.style.display = (selectedRating === 'all' || item.getAttribute('data-rating') === selectedRating) ? 'block' : 'none';
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        var expanded = false;
        document.getElementById('toggleReviews').addEventListener('click', function () {
            expanded = !expanded;
            document.querySelectorAll('.rating-item').forEach((item, index) => {
                if (index >= 5)
                    item.style.display = expanded ? 'block' : 'none';
            });
            this.innerHTML = expanded ? '<i class="fas fa-angle-up"></i> Collapse review' : '<i class="fas fa-angle-down"></i> See more reviews';
        });

        // Toggle reply form
        document.addEventListener("click", function (event) {
            if (event.target.classList.contains("reply-btn") || event.target.parentElement.classList.contains("reply-btn")) {
                let commentId = event.target.getAttribute("data-comment-id") || event.target.parentElement.getAttribute("data-comment-id");
                let replyForm = document.getElementById("reply-form-" + commentId);
                if (replyForm)
                    replyForm.classList.toggle("d-none");
            }
        });

        // Submit reply
        document.addEventListener("click", function (event) {
            if (event.target.classList.contains("submit-reply") || event.target.parentElement.classList.contains("submit-reply")) {
                let parentId = event.target.getAttribute("data-parent-id") || event.target.parentElement.getAttribute("data-parent-id");
                let replyForm = document.getElementById("reply-form-" + parentId);
                let textarea = replyForm.querySelector("textarea");
                let content = textarea.value.trim();

                if (content.length === 0) {
                    alert("Feedback content cannot be blank!");
                    return;
                }

                let userId = "${user.id}";
                let urlParams = new URLSearchParams(window.location.search);
                let productId = urlParams.get('product_id');

                fetch("/ViewProductDetails", {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: "action=addComment&productId=" + productId + "&userId=" + userId + "&parentCommentId=" + parentId + "&content=" + encodeURIComponent(content)
                })
                        .then(response => response.text())
                        .then(result => {
                            if (result === "success") {
                                location.reload(); // Tạm thời reload, có thể cải thiện sau
                            } else {
                                alert("Error! Cannot add feedback.");
                            }
                        })
                        .catch(error => console.error("Lỗi:", error));
            }
        });

        // Delete comment with modal
        let commentIdToDelete = null;
        document.addEventListener("click", function (event) {
            if (event.target.classList.contains("delete-btn") || event.target.parentElement.classList.contains("delete-btn")) {
                commentIdToDelete = event.target.getAttribute("data-comment-id") || event.target.parentElement.getAttribute("data-comment-id");
                let modal = new bootstrap.Modal(document.getElementById('deleteCommentModal'));
                modal.show();
            }
        });

        document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
            if (commentIdToDelete) {
                fetch("/ViewProductDetails", {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: "action=deleteComment&commentId=" + commentIdToDelete
                })
                        .then(response => response.text())
                        .then(result => {
                            if (result === "success") {
                                removeCommentAndReplies(commentIdToDelete);
                            } else {
                                alert("Lỗi! Không thể xóa bình luận.");
                            }
                        })
                        .catch(error => console.error("Lỗi:", error));
            }
            bootstrap.Modal.getInstance(document.getElementById('deleteCommentModal')).hide();
        });

        // Hàm xóa bình luận và các replies khỏi giao diện
        function removeCommentAndReplies(commentId) {
            let commentElement = document.getElementById('comment-' + commentId);
            if (commentElement) {
                commentElement.remove(); // Xóa hoàn toàn phần tử khỏi DOM
            }
        }
    });
        </script>
    </body>
</html>