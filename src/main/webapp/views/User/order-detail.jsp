<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Order Details</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #ffffff; /* Match the image's white background */
                font-family: 'Arial', sans-serif;
                min-height: 100vh;
                color: #333;
            }

            .container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 20px;
            }

            .order-date {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 15px;
                text-align: center;
                margin-top: 30px;
                font-size: 16px;
                color: #555;
            }

            .order-status-container {
                text-align: center;
                padding: 20px;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                margin-top: 30px;
            }

            .order-status-container h5 {
                font-size: 20px;
                font-weight: 600;
                color: #28a745;
                margin-bottom: 20px;
            }

            .progress-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: relative;
                margin-top: 20px;
                width: 80%;
                margin-left: auto;
                margin-right: auto;
            }

            .progress-line {
                position: absolute;
                top: 50%;
                left: 16%;
                height: 6px;
                background: linear-gradient(to right, #28a745, #007bff);
                z-index: 0;
                transition: width 0.5s ease-in-out;
                border-radius: 3px;
            }

            .status-item {
                position: relative;
                width: 33.33%;
                text-align: center;
                z-index: 1;
            }

            .status-item.centered {
                width: 100%;
                margin: 0 auto;
            }

            .status-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #e9ecef;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 10px;
                color: #fff;
                font-size: 18px;
                transition: all 0.3s ease;
            }

            .status-item.active .status-icon {
                background-color: #28a745;
            }

            .status-item.canceled .status-icon {
                background-color: #dc3545;
            }

            .status-item p {
                font-size: 14px;
                color: #6c757d;
                margin: 0;
                transition: color 0.3s ease;
            }

            .status-item.active p {
                color: #28a745;
                font-weight: 600;
            }

            .status-item.canceled p {
                color: #dc3545;
                font-weight: 600;
            }

            .status-item.inactive {
                opacity: 0.5;
            }

            .order-table {
                width: 100%;
                margin-top: 30px;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            .order-table img {
                max-width: 80px;
                height: auto;
                object-fit: contain;
                border-radius: 5px;
                transition: transform 0.2s ease; /* Add hover effect */
            }

            .order-table img:hover {
                transform: scale(1.05); /* Slight scale on hover */
                cursor: pointer; /* Indicate clickability */
            }

            .order-table td {
                vertical-align: middle;
                padding: 10px;
                border-bottom: 1px solid #eee;
            }

            .order-table td:first-child {
                width: 10%;
            }

            .order-table td:nth-child(2) {
                width: 40%;
            }

            .order-table .product-name {
                font-size: 18px;
                font-weight: 600;
                color: #007bff; /* Bold blue for product name */
                margin-bottom: 5px;
            }

            .order-table .product-description {
                font-size: 14px;
                color: #666; /* Muted gray for description */
                margin-bottom: 5px;
            }

            .order-table .price {
                font-size: 16px;
                font-weight: 500;
                color: #28a745; /* Green for price */
            }

            .order-table .quantity {
                font-size: 16px;
                color: #333; /* Dark gray for quantity */
            }

            .order-table .total {
                font-size: 16px;
                font-weight: 500;
                color: #dc3545; /* Red for total */
            }

            .order-table td:nth-child(3),
            .order-table td:nth-child(4),
            .order-table td:nth-child(5) {
                text-align: right;
                width: 15%;
            }

            .order-summary {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                height: 100%; /* Ensure it stretches to match the height of shipping-info */
            }

            .order-summary div {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                font-size: 16px;
            }

            .order-summary .total {
                font-weight: 600;
                color: #dc3545;
                font-size: 18px;
            }

            .shipping-info {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 20px;
                height: 100%; /* Ensure it stretches to match the height of order-summary */
            }

            .shipping-info h4 {
                font-size: 18px;
                font-weight: 600;
                color: #007bff; /* Blue for heading */
                margin-bottom: 15px;
            }

            .shipping-info .info-item {
                font-size: 16px;
                margin-bottom: 10px;
                color: #333;
            }

            .shipping-info .info-item strong {
                color: #28a745; /* Green for labels */
            }

            .error-msg {
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                color: #dc3545;
                margin-top: 20px;
            }

            @media (max-width: 768px) {
                .container {
                    margin: 20px auto;
                    padding: 10px;
                }

                .order-table img {
                    max-width: 60px;
                }

                .order-table td {
                    padding: 5px;
                    font-size: 14px;
                }

                .order-table .product-name {
                    font-size: 16px;
                }

                .order-table .product-description {
                    font-size: 12px;
                }

                .order-table .price,
                .order-table .quantity,
                .order-table .total {
                    font-size: 14px;
                }

                .order-table td:nth-child(2) {
                    width: 50%;
                }

                .progress-container {
                    width: 95%;
                    flex-direction: column;
                    gap: 20px;
                }

                .progress-line {
                    display: none;
                }

                .status-item {
                    width: 100%;
                }

                .order-summary div,
                .shipping-info .info-item {
                    font-size: 14px;
                }

                .shipping-info,
                .order-summary {
                    margin-top: 30px;
                    height: auto; /* Reset height for stacking on mobile */
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>

        <!-- Order Status Bar -->
        <div class="order-status-container">
            <h5 class="text-success text-center">Order Status</h5>
            <c:choose>
                <c:when test="${orderDetails[0].status_id == 4}">
                    <div class="status-item canceled centered">
                        <div class="status-icon"><i class="fas fa-times-circle"></i></div>
                        <p>Order has been cancelled</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="progress-container">
                        <div class="progress-line" style="width: ${(orderDetails[0].status_id - 1) * 34}%;"></div>
                        <div class="status-item ${orderDetails[0].status_id >= 1 ? 'active' : ''}"> 
                            <div class="status-icon"><i class="fas fa-check-circle"></i></div>
                            <p>Pending Confirmation</p>
                        </div>
                        <div class="status-item ${orderDetails[0].status_id >= 2 ? 'active' : ''} ${orderDetails[0].status_id == 4 ? 'inactive' : ''}">
                            <div class="status-icon"><i class="fas fa-truck"></i></div>
                            <p>In Transit</p>
                        </div>
                        <div class="status-item ${orderDetails[0].status_id == 3 ? 'active' : ''} ${orderDetails[0].status_id == 4 ? 'canceled' : ''}">
                            <div class="status-icon"><i class="fas fa-check"></i></div>
                            <p>Delivered</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>



        <div class="container mt-5">
            <strong>Order Date:</strong> <span class="text-dark">${orderDetails[0].createdAt}</span>
            <c:choose>
                <c:when test="${not empty orderDetails}">
                    <!-- Order Items Table -->
                    <div class="order-table">
                        <table>
                            <tbody>
                                <c:forEach var="order" items="${orderDetails}">
                                    <tr>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/ProductDetail?id=${order.product_id}">
                                                <img src="${pageContext.request.contextPath}/ProductImage?id=${order.product_id}" alt="${order.productName}">
                                            </a>
                                        </td>
                                        <td>
                                            <div class="product-name">${order.productName}</div>
                                            <c:if test="${not empty order.ram}">
                                                <div class="product-description">RAM: ${order.ram}</div>
                                            </c:if>
                                            <!-- Add color/size if available -->
                                            <c:if test="${not empty order.description}">
                                                <div class="product-description">${order.description}</div>
                                            </c:if>
                                        </td>
                                        <td><span class="price"><fmt:formatNumber value="${order.price}" pattern="#,###" /> VND</span></td>
                                        <td><span class="quantity">${order.quantity}</span></td>
                                        <td><span class="total"><fmt:formatNumber value="${order.price * order.quantity}" pattern="#,###" /> VND</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Shipping Information and Order Summary Side by Side -->
                    <div class="row mt-4">
                        <!-- Shipping Information (Left) -->
                        <div class="col-md-6">
                            <div class="shipping-info">
                                <h4>📦 Shipping Information</h4>
                                <hr>
                                <div class="info-item">
                                    <strong>👤 Name:</strong> <span class="text-dark">${orderDetails[0].consigneeName}</span>
                                </div>
                                <div class="info-item">
                                    <strong>📍 Address:</strong> <span class="text-dark">${orderDetails[0].consigneeAddress}</span>
                                </div>
                                <div class="info-item">
                                    <strong>📞 Phone:</strong> <span class="text-dark">${orderDetails[0].consigneePhone}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Order Summary (Right) -->
                        <div class="col-md-6">
                            <div class="order-summary">
                                <div><span>Total Products:</span><span><fmt:formatNumber value="${orderDetails[0].totalPrice}" pattern="#,###" /> VND</span></div>
                                <div><span>Discount :</span><span class="text-danger">- <fmt:formatNumber value="0" pattern="#,###" /> VND</span></div>
                                <div><span>Promotion:</span><span class="text-danger">- <fmt:formatNumber value="0" pattern="#,###" /> VND</span></div>
                                <div class="total"><span>Total:</span><span><fmt:formatNumber value="${orderDetails[0].totalPrice}" pattern="#,###" /> VND</span></div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="error-msg">No order details available.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>