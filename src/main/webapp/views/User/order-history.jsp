<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Order History</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">

        <style>
            body {
                background: #f5f5f5;
                font-family: 'Arial', sans-serif;
                min-height: 100vh;
            }

            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 10px;
            }

            .order-status-nav {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
                margin: 20px 0;
                border-bottom: 1px solid #ddd;
                background: #fff;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .order-status-nav li {
                margin: 0 15px;
            }

            .order-status-nav a {
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                color: #333;
                padding: 10px 15px;
                transition: all 0.3s ease;
            }

            .order-status-nav a:hover {
                color: #6f42c1;
            }

            .order-status-nav .active {
                color: #6f42c1 !important;
                border-bottom: 2px solid #6f42c1;
            }

            .order-section {
                margin-bottom: 20px;
                background: #fff;
                border: 1px solid #e5e5e5;
                border-radius: 5px;
                padding: 10px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .order-header {
                font-size: 16px;
                font-weight: 600;
                color: #333;
                margin-bottom: 10px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }

            .order-id {
                color: #ff4d4f;
            }

            .order-date {
                font-size: 12px;
                color: #757575;
            }

            .order-status {
                font-size: 12px;
                font-weight: 600;
                margin-top: 5px;
            }

            .status-pending {
                color: #856404;
            }

            .status-processing {
                color: #0c5460;
            }

            .status-delivered {
                color: #155724;
            }

            .status-canceled {
                color: #721c24;
            }

            .order-item {
                border-top: 1px solid #e5e5e5;
                padding: 10px 0;
            }

            .order-item:first-child {
                border-top: none;
            }

            .order-item:hover {
                background: #f8f9fa;
            }

            .product-item {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .order-image {
                width: 80px;
                height: 80px;
                object-fit: contain;
                margin-right: 10px;
            }

            .order-details {
                flex-grow: 1;
            }

            .product-name {
                font-size: 14px;
                font-weight: 600;
                color: #222;
                margin-bottom: 5px;
            }

            .variant-info {
                font-size: 12px;
                color: #757575;
                margin-bottom: 5px;
            }

            .price-info {
                font-size: 14px;
            }

            .original-price {
                color: #757575;
                text-decoration: line-through;
                margin-right: 5px;
            }

            .discounted-price {
                color: #ff4d4f;
                font-weight: 600;
            }

            .quantity {
                font-size: 12px;
                color: #757575;
                margin-top: 5px;
            }

            .order-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-top: 10px;
                border-top: 1px solid #e5e5e5;
            }

            .total {
                font-size: 16px;
                color: #ff4d4f;
                font-weight: 600;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
            }

            .action-btn {
                background: #ff4d4f;
                color: #fff;
                border: none;
                padding: 5px 15px;
                border-radius: 5px;
                font-size: 12px;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .action-btn:hover {
                background: #e63946;
            }

            .action-btn.disabled {
                background: #e5e5e5;
                color: #757575;
                cursor: not-allowed;
            }

            .action-btn.disabled:hover {
                background: #e5e5e5;
            }

            .text-muted {
                font-size: 14px;
            }

            @media (max-width: 768px) {
                .order-item {
                    padding: 10px 0;
                }

                .product-item {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .order-image {
                    width: 60px;
                    height: 60px;
                    margin-bottom: 10px;
                }

                .product-name {
                    font-size: 13px;
                }

                .variant-info {
                    font-size: 11px;
                }

                .price-info {
                    font-size: 13px;
                }

                .quantity {
                    font-size: 11px;
                }

                .total {
                    font-size: 14px;
                }

                .order-header {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .order-date, .order-status {
                    margin-top: 5px;
                }

                .action-btn {
                    padding: 4px 12px;
                    font-size: 11px;
                }

                .action-buttons {
                    flex-direction: column;
                    gap: 5px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>
        <div class="container">
            <h2 class="text-primary text-center mb-4">📜 Order History</h2>

            <!-- Navigation for order statuses -->
            <div class="order-status-nav-wrapper">
                <form action="ViewOrder" method="GET" id="orderStatusForm">
                    <ul class="order-status-nav">
                        <li>
                            <a class="${empty param.status_id ? 'active' : ''}" href="ViewOrder" onclick="submitForm(event, '');">All</a>
                        </li>
                        <li>
                            <a class="${param.status_id == '1' ? 'active' : ''}" href="ViewOrder?status_id=1" onclick="submitForm(event, '1');">Pending Confirmation</a>
                        </li>
                        <li>
                            <a class="${param.status_id == '2' ? 'active' : ''}" href="ViewOrder?status_id=2" onclick="submitForm(event, '2');">Processing</a>
                        </li>
                        <li>
                            <a class="${param.status_id == '3' ? 'active' : ''}" href="ViewOrder?status_id=3" onclick="submitForm(event, '3');">Delivered</a>
                        </li>
                        <li>
                            <a class="${param.status_id == '4' ? 'active' : ''}" href="ViewOrder?status_id=4" onclick="submitForm(event, '4');">Canceled</a>
                        </li>
                    </ul>
                    <input type="hidden" name="status_id" id="statusIdInput">
                </form>
            </div>

            <c:if test="${empty orders}">
                <p class="text-center text-muted">You have no orders in this category.</p>
            </c:if>

            <c:if test="${not empty orders}">
                <c:set var="currentOrderId" value="-1" />
                <c:forEach var="order" items="${orders}" varStatus="loop">
                    <!-- Kiểm tra trạng thái chỉ khi bắt đầu một order mới -->
                    <c:if test="${order.order_id != currentOrderId}">
                        <c:set var="displayOrder" value="${empty param.status_id or order.status_id == param.status_id}" />
                    </c:if>

                    <c:if test="${displayOrder}">
                        <!-- Start new order section if order_id changes -->
                        <c:if test="${order.order_id != currentOrderId or loop.first}">
                            <c:if test="${currentOrderId != -1 and not loop.first}">
                                <!-- Close previous order section -->
                                <div class="order-footer">
                                    <div class="total">Total: <fmt:formatNumber value="${orderTotal}" pattern="#,###" /> VND</div>
                                    <div class="action-buttons">
                                        <c:if test="${currentStatusId == 3 or currentStatusId == 4}">
                                            <a href="${pageContext.request.contextPath}/BuyAgain?order_id=${currentOrderId}" class="action-btn">Buy Again</a>
                                        </c:if>
                                        <c:if test="${currentStatusId == 1}">
                                            <button type="button" class="action-btn" data-bs-toggle="modal" data-bs-target="#confirmCancelModal_${currentOrderId}">
                                                Cancel Order
                                            </button>
                                            <div class="modal fade" id="confirmCancelModal_${currentOrderId}" tabindex="-1" aria-labelledby="modalLabel_${currentOrderId}" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title text-danger" id="modalLabel_${currentOrderId}">Confirm Cancellation</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Are you sure you want to cancel this order?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                                            <form action="CancelOrder" method="post" class="d-inline">
                                                                <input type="hidden" name="orderId" value="${currentOrderId}" />
                                                                <button type="submit" class="btn btn-danger">Yes</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${currentStatusId != 1}">
                                            <button type="button" class="action-btn disabled" disabled>Cancel Order</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div> 
                        </c:if>

                        <div class="order-section">
                            <div class="order-header">
                                <span>Order ID: <span class="order-id">${order.order_id}</span></span>
                                <span class="order-date">Placed on: <fmt:formatDate value="${order.createdAt}" pattern="dd-MM-yyyy HH:mm:ss" /></span>
                                <span class="order-status ${statusClass}">
                                    <c:choose>
                                        <c:when test="${order.status_id == 1}">Pending Confirmation</c:when>
                                        <c:when test="${order.status_id == 2}">Processing</c:when>
                                        <c:when test="${order.status_id == 3}">Delivered</c:when>
                                        <c:when test="${order.status_id == 4}">Canceled</c:when>
                                        <c:otherwise>Unknown Status</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <c:set var="orderTotal" value="0" />
                            <c:set var="currentOrderId" value="${order.order_id}" />
                            <c:set var="currentStatusId" value="${order.status_id}" />
                            <c:set var="statusClass" value="${order.status_id == 1 ? 'status-pending' : order.status_id == 2 ? 'status-processing' : order.status_id == 3 ? 'status-delivered' : 'status-canceled'}" />
                        </c:if>

                        <!-- Add to total for the current order -->
                        <c:set var="orderTotal" value="${orderTotal + (order.price * order.quantity)}" />

                        <!-- Display product item -->
                        <div class="order-item">
                            <div class="product-item">
                                <a href="${pageContext.request.contextPath}/ViewOrderDetail?order_id=${order.order_id}">
                                    <img src="${pageContext.request.contextPath}/ProductImage?id=${order.variantId}" alt="Product Image" class="order-image">
                                </a>
                                <div class="order-details">
                                    <div class="product-name">${order.productName}</div>
                                    <div class="variant-info">${order.ram}</div>
                                    <div class="price-info">
                                        <span class="discounted-price"><fmt:formatNumber value="${order.price}" pattern="#,###" /> VND</span>
                                    </div>
                                    <div class="quantity">x${order.quantity}</div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>

                <!-- Close the last order section -->
                <c:if test="${currentOrderId != -1}">
                    <div class="order-footer">
                        <div class="total">Total: <fmt:formatNumber value="${orderTotal}" pattern="#,###" /> VND</div>
                        <div class="action-buttons">
                            <c:if test="${currentStatusId == 3 or currentStatusId == 4}">
                                <a href="${pageContext.request.contextPath}/BuyAgain?order_id=${currentOrderId}" class="action-btn">Buy Again</a>
                            </c:if>
                            <c:if test="${currentStatusId == 1}">
                                <button type="button" class="action-btn" data-bs-toggle="modal" data-bs-target="#confirmCancelModal_${currentOrderId}">
                                    Cancel Order
                                </button>
                                <div class="modal fade" id="confirmCancelModal_${currentOrderId}" tabindex="-1" aria-labelledby="modalLabel_${currentOrderId}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title text-danger" id="modalLabel_${currentOrderId}">Confirm Cancellation</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Are you sure you want to cancel this order?</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                                <form action="CancelOrder" method="post" class="d-inline">
                                                    <input type="hidden" name="orderId" value="${currentOrderId}" />
                                                    <button type="submit" class="btn btn-danger">Yes</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${currentStatusId != 1}">
                                <button type="button" class="action-btn disabled" disabled>Cancel Order</button>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div> <!-- Close the last order-section -->
        </c:if>


        <jsp:include page="footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    function submitForm(event, statusId) {
                                        event.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ <a>
                                        document.getElementById('statusIdInput').value = statusId; // Gán giá trị status_id
                                        document.getElementById('orderStatusForm').submit(); // Gửi form
                                    }
        </script>
    </body>
</html>