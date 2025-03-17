<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Base64" %>

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
        .comment {
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
        }
        .comment-root {
            font-weight: 600;
        }
        .comment-reply {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            margin-left: 40px;
        }
        .text-muted.fst-italic {
            color: #6c757d;
            font-size: 14px;
            padding-left: 10px;
            border-left: 3px solid #ddd;
            margin-bottom: 10px;
        }
        .text-purple {
            color: #6f42c1;
            font-weight: 600;
            text-shadow: 0 0 5px #9b59b6;
        }
        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .form-select {
            width: auto;
            display: inline-block;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="Dashboard"><p>Xin chào, ${user.name}</p></a>
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
        <ul class="navbar-nav ms-auto ms-md-10 me-3 me-lg-4">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="CustomerProfileDetail?userId=${user.id}">My Profile</a></li>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarrantyServelet"><div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>View Warranty</a>
                    </div>
                </div>
            </nav>
        </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">                 
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard / Chi Tiết Sản Phẩm</li>
                    </ol>

                    <div class="container">
                        <h1><i class="fas fa-box"></i> Chi Tiết Sản Phẩm</h1>

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
                                <p><strong><i class="fas fa-info-circle"></i> Mô tả:</strong> <c:out value="${product.description}" /></p>
                                <p class="price"><i class="fas fa-tag"></i> Giá: <fmt:formatNumber value="${product.price}" pattern="#,###" /> VND</p>
                                <h3 class="text-warning"><i class="fas fa-star"></i> 
                                    <c:choose>
                                        <c:when test="${empty averageRating or averageRating == 0}">0 / 5</c:when>
                                        <c:otherwise><fmt:formatNumber value="${averageRating}" pattern="#.0" /> / 5</c:otherwise>
                                    </c:choose>
                                </h3>
                            </div>
                        </div>

                        <!-- Specifications -->
                        <h2><i class="fas fa-cogs"></i> Thông số kỹ thuật</h2>
                        <table class="specifications">
                            <% int catalogId = (int) request.getAttribute("catalog_id"); %>
                            <% if (catalogId == 1) { %>
                                <tr><th><i class="fas fa-microchip"></i> CPU</th><td>${productSpec.cpu}</td></tr>
                                <tr><th><i class="fas fa-hdd"></i> Lưu trữ</th><td>${productSpec.storage}</td></tr>
                                <tr><th><i class="fas fa-desktop"></i> Độ phân giải</th><td>${productSpec.resolution}</td></tr>
                                <tr><th><i class="fas fa-video"></i> Card đồ họa</th><td>${productSpec.graphics}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Cổng kết nối</th><td>${productSpec.ports}</td></tr>
                                <tr><th><i class="fas fa-wifi"></i> Không dây</th><td>${productSpec.wireless}</td></tr>
                                <tr><th><i class="fas fa-camera"></i> Camera</th><td>${productSpec.camera}</td></tr>
                                <tr><th><i class="fas fa-battery-full"></i> Pin</th><td>${productSpec.battery}</td></tr>
                                <tr><th><i class="fas fa-ruler"></i> Kích thước</th><td>${productSpec.dimensions}</td></tr>
                                <tr><th><i class="fas fa-weight"></i> Trọng lượng</th><td>${productSpec.weight}</td></tr>
                                <tr><th><i class="fas fa-keyboard"></i> Bàn phím</th><td>${productSpec.keyboard}</td></tr>
                                <tr><th><i class="fas fa-cube"></i> Chất liệu</th><td>${productSpec.material}</td></tr>
                                <tr><th><i class="fas fa-laptop"></i> Hệ điều hành</th><td>${productSpec.os}</td></tr>
                                <tr><th><i class="fas fa-check-circle"></i> Tình trạng</th><td>${productSpec.condition}</td></tr>
                                <tr><th><i class="fas fa-sync"></i> Tần số quét</th><td>${productSpec.refreshRate}</td></tr>
                                <tr><th><i class="fas fa-memory"></i> RAM</th><td>${productSpec.ram}</td></tr>
                            <% } else if (catalogId == 2) { %>
                                <tr><th><i class="fas fa-tv"></i> Model</th><td>${productSpec.model}</td></tr>
                                <tr><th><i class="fas fa-ruler"></i> Kích thước</th><td>${productSpec.size} inch</td></tr>
                                <tr><th><i class="fas fa-layer-group"></i> Tấm nền</th><td>${productSpec.panelType}</td></tr>
                                <tr><th><i class="fas fa-desktop"></i> Độ phân giải</th><td>${productSpec.resolution}</td></tr>
                                <tr><th><i class="fas fa-sun"></i> Độ sáng</th><td>${productSpec.brightness} nits</td></tr>
                                <tr><th><i class="fas fa-sync"></i> Tần số quét</th><td>${productSpec.refreshRate} Hz</td></tr>
                                <tr><th><i class="fas fa-eye"></i> HDR</th><td>${productSpec.hdr}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Cổng kết nối</th><td>${productSpec.ports}</td></tr>
                                <tr><th><i class="fas fa-volume-up"></i> Loa</th><td>${productSpec.audioOut ? 'Có' : 'Không'}</td></tr>
                            <% } else if (catalogId == 3) { %>
                                <tr><th><i class="fas fa-trademark"></i> Thương hiệu</th><td>${productSpec.brand}</td></tr>
                                <tr><th><i class="fas fa-link"></i> Kết nối</th><td>${productSpec.connectionType}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Có dây</th><td>${productSpec.wired ? 'Có' : 'Không'}</td></tr>
                                <tr><th><i class="fas fa-tachometer-alt"></i> DPI</th><td>${productSpec.dpi}</td></tr>
                                <tr><th><i class="fas fa-toggle-on"></i> Loại switch</th><td>${productSpec.switchType}</td></tr>
                                <tr><th><i class="fas fa-lightbulb"></i> LED</th><td>${productSpec.mouseLed}</td></tr>
                            <% } else if (catalogId == 4) { %>
                                <tr><th><i class="fas fa-trademark"></i> Thương hiệu</th><td>${productSpec.brand}</td></tr>
                                <tr><th><i class="fas fa-link"></i> Kết nối</th><td>${productSpec.connectionType}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Có dây</th><td>${productSpec.wired ? 'Có' : 'Không'}</td></tr>
                                <tr><th><i class="fas fa-cube"></i> Chất liệu keycap</th><td>${empty productSpec.keycapMaterial ? 'Không có dữ liệu' : productSpec.keycapMaterial}</td></tr>
                                <tr><th><i class="fas fa-toggle-on"></i> Loại switch</th><td>${empty productSpec.switchType ? 'Không có dữ liệu' : productSpec.switchType}</td></tr>
                                <tr><th><i class="fas fa-palette"></i> Màu sắc</th><td>${empty productSpec.color ? 'Không có dữ liệu' : productSpec.color}</td></tr>
                                <tr><th><i class="fas fa-lightbulb"></i> LED</th><td>${empty productSpec.ledColor ? 'Không có' : productSpec.ledColor}</td></tr>
                                <tr><th><i class="fas fa-ruler"></i> Kích thước</th><td>${empty productSpec.dimensions ? 'Không có dữ liệu' : productSpec.dimensions}</td></tr>
                                <tr><th><i class="fas fa-weight"></i> Trọng lượng</th><td><c:out value="${not empty productSpec.weight ? productSpec.weight : 'Không có dữ liệu'}" /> kg</td></tr>
                                <tr><th><i class="fas fa-battery-full"></i> Dung lượng pin</th><td><c:out value="${not empty productSpec.batteryCapacity ? productSpec.batteryCapacity : 'Không có'}" /> mAh</td></tr>
                                <tr><th><i class="fas fa-keyboard"></i> Keycap Profile</th><td><c:out value="${not empty productSpec.keycapProfile ? productSpec.keycapProfile : 'Không có dữ liệu'}" /></td></tr>
                            <% } else if (catalogId == 5) { %>
                                <tr><th><i class="fas fa-trademark"></i> Thương hiệu</th><td>${productSpec.brand}</td></tr>
                                <tr><th><i class="fas fa-link"></i> Kết nối</th><td>${productSpec.connectionType}</td></tr>
                                <tr><th><i class="fas fa-plug"></i> Có dây</th><td>${productSpec.wired ? 'Có' : 'Không'}</td></tr>
                                <tr><th><i class="fas fa-palette"></i> Màu sắc</th><td>${productSpec.color}</td></tr>
                                <tr><th><i class="fas fa-lightbulb"></i> LED</th><td>${productSpec.ledColor}</td></tr>
                                <tr><th><i class="fas fa-wave-square"></i> Dải tần số</th><td>${productSpec.frequencyRange}</td></tr>
                                <tr><th><i class="fas fa-headphones"></i> Kích thước driver</th><td>${productSpec.driverSize} mm</td></tr>
                            <% } else { %>
                                <tr><td colspan="2" class="text-danger text-center"><i class="fas fa-exclamation-circle"></i> Không có thông số kỹ thuật cho sản phẩm này.</td></tr>
                            <% } %>
                        </table>

                        <!-- Ratings -->
                        <h2><i class="fas fa-star"></i> Thống Kê Đánh Giá</h2>
                        <div class="text-center mb-4">
                            <h3 class="text-warning"><i class="fas fa-star"></i> 
                                <c:choose>
                                    <c:when test="${empty averageRating or averageRating == 0}">0 / 5</c:when>
                                    <c:otherwise><fmt:formatNumber value="${averageRating}" pattern="#.0" /> / 5</c:otherwise>
                                </c:choose>
                            </h3>
                            <p class="text-muted">(${totalRatings} đánh giá | ${numbercmt} bình luận)</p>
                        </div>

                        <h2><i class="fas fa-list"></i> Danh Sách Đánh Giá</h2>
                        <select id="filterRating" class="form-select" onchange="filterRatings()">
                            <option value="all">Tất cả</option>
                            <option value="5">5 sao</option>
                            <option value="4">4 sao</option>
                            <option value="3">3 sao</option>
                            <option value="2">2 sao</option>
                            <option value="1">1 sao</option>
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
                                <p class="mt-1">Đánh giá: 
                                    <c:forEach begin="1" end="${rate.rating}"><i class="fas fa-star text-warning"></i></c:forEach>
                                    <c:forEach begin="${rate.rating + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                                </p>
                            </div>
                        </c:forEach>
                        <c:if test="${empty ratings}">
                            <p class="text-muted text-center"><i class="fas fa-exclamation-circle"></i> Chưa có đánh giá nào.</p>
                        </c:if>
                        <button id="toggleReviews" class="btn btn-link mt-2"><i class="fas fa-angle-down"></i> Xem thêm đánh giá</button>

                        <!-- Comments -->
                        <h2><i class="fas fa-comments"></i> Bình Luận</h2>
                        <div class="comments-section">
                            <c:forEach var="comment" items="${comments}">
                                <c:set var="userClass" value="text-primary" />
                                <c:if test="${comment.role_id == 3}"><c:set var="userClass" value="text-danger" /></c:if>
                                <c:if test="${comment.role_id == 2}"><c:set var="userClass" value="text-purple" /></c:if>

                                <div class="comment ${comment.parentCommentId == null ? 'comment-root' : 'comment-reply'}" id="comment-${comment.commentId}">
                                    <div class="d-flex align-items-center">
                                        <c:choose>
                                            <c:when test="${not empty comment.imageUser}">
                                                <img src="data:image/png;base64,${Base64.getEncoder().encodeToString(comment.imageUser)}" class="rounded-circle me-2" width="40" height="40" alt="User">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/default-avatar.png" class="rounded-circle me-2" width="40" height="40" alt="User">
                                            </c:otherwise>
                                        </c:choose>
                                        <strong class="${userClass}"><c:out value="${comment.userName}" /></strong>
                                    </div>
                                    <span class="text-muted">(<fmt:formatDate value="${comment.createdAt}" pattern="dd/MM/yyyy HH:mm" />)</span>
                                    <c:if test="${comment.parentCommentId != null}">
                                        <c:set var="parentUserName" value="(Comment đã được xóa)" />
                                        <c:set var="parentContent" value="(Comment đã được xóa)" />
                                        <c:forEach var="parentComment" items="${comments}">
                                            <c:if test="${parentComment.commentId == comment.parentCommentId}">
                                                <c:set var="parentUserName" value="${parentComment.userName}" />
                                                <c:set var="parentContent" value="${parentComment.content}" />
                                            </c:if>
                                        </c:forEach>
                                        <p class="mt-1"><strong class="text-info">@<c:out value="${parentUserName}" />:</strong></p>
                                        <p class="text-muted fst-italic">"${parentContent}"</p>
                                        <p class="mt-1"><c:out value="${comment.content}" /></p>
                                    </c:if>
                                    <c:if test="${comment.parentCommentId == null}">
                                        <p class="mt-1">
                                            <c:choose>
                                                <c:when test="${empty comment.content}"><span class="text-muted fst-italic">(Comment đã được xóa)</span></c:when>
                                                <c:otherwise><c:out value="${comment.content}" /></c:otherwise>
                                            </c:choose>
                                        </p>
                                    </c:if>
                                    <div class="comment-actions">
                                        <button class="btn btn-primary btn-sm reply-btn" data-comment-id="${comment.commentId}"><i class="fas fa-reply"></i> Reply</button>
                                        <button class="btn btn-danger btn-sm delete-btn" data-comment-id="${comment.commentId}"><i class="fas fa-trash"></i> Delete</button>
                                    </div>
                                    <div class="reply-form mt-2 d-none" id="reply-form-${comment.commentId}">
                                        <textarea class="form-control" rows="2" placeholder="Nhập câu trả lời..."></textarea>
                                        <button class="btn btn-success btn-sm mt-2 submit-reply" data-parent-id="${comment.commentId}"><i class="fas fa-paper-plane"></i> Gửi</button>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty comments}">
                                <p class="text-muted text-center"><i class="fas fa-exclamation-circle"></i> Chưa có bình luận nào.</p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Modal Popup Xóa Bình Luận -->
                <div class="modal fade" id="deleteCommentModal" tabindex="-1" aria-labelledby="deleteCommentModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteCommentModalLabel"><i class="fas fa-trash-alt"></i> Xác nhận xóa bình luận</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Bạn có chắc chắn muốn xóa bình luận này không? Hành động này không thể hoàn tác.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="fas fa-times"></i> Hủy</button>
                                <button type="button" class="btn btn-danger" id="confirmDeleteBtn"><i class="fas fa-trash"></i> Xác nhận</button>
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
                                if (index >= 5) item.style.display = expanded ? 'block' : 'none';
                            });
                            this.innerHTML = expanded ? '<i class="fas fa-angle-up"></i> Thu gọn đánh giá' : '<i class="fas fa-angle-down"></i> Xem thêm đánh giá';
                        });

                        // Toggle reply form
                        document.addEventListener("click", function (event) {
                            if (event.target.classList.contains("reply-btn") || event.target.parentElement.classList.contains("reply-btn")) {
                                let commentId = event.target.getAttribute("data-comment-id") || event.target.parentElement.getAttribute("data-comment-id");
                                let replyForm = document.getElementById("reply-form-" + commentId);
                                if (replyForm) replyForm.classList.toggle("d-none");
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
                                    alert("Nội dung phản hồi không được để trống!");
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
                                    if (result === "success") location.reload();
                                    else alert("Lỗi! Không thể thêm phản hồi.");
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
                                    if (result === "success") location.reload();
                                    else alert("Lỗi! Không thể xóa bình luận.");
                                })
                                .catch(error => console.error("Lỗi:", error));
                            }
                            bootstrap.Modal.getInstance(document.getElementById('deleteCommentModal')).hide();
                        });
                    });
                </script>
            </main>
        </div>
    </div>
</body>
</html>
