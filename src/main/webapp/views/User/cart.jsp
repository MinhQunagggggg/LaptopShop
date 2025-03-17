<%-- 
    Document   : cart
    Created on : Feb 22, 2025, 8:08:23 PM
    Author     : CE182250
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Your Shopping Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* ✅ Fix column width */
            .cart-table th, .cart-table td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                white-space: normal;
                word-wrap: break-word;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            /* ✅ Adjust column width */
            .cart-table th:nth-child(1), .cart-table td:nth-child(1) {
                width: 5%;
            } /* Checkbox */
            .cart-table th:nth-child(2), .cart-table td:nth-child(2) {
                width: 10%;
            } /* Image */
            .cart-table th:nth-child(3), .cart-table td:nth-child(3) {
                width: 30%;
            } /* Product Name */
            .cart-table th:nth-child(4), .cart-table td:nth-child(4) {
                width: 15%;
            } /* Price */
            .cart-table th:nth-child(5), .cart-table td:nth-child(5) {
                width: 10%;
            } /* Quantity */
            .cart-table th:nth-child(6), .cart-table td:nth-child(6) {
                width: 15%;
            } /* Total */
            .cart-table th:nth-child(7), .cart-table td:nth-child(7) {
                width: 10%;
            } /* Action */

            /* ✅ Prevent table from shrinking */
            .cart-table {
                width: 100%;
                table-layout: fixed;
            }

            /* ✅ Adjust image */
            .cart-table img {
                border-radius: 5px;
                max-width: 50px;
                height: auto;
            }

            /* ✅ Shorter quantity input */
            .quantity-input {
                width: 50px;
                text-align: center;
                border: 1px solid #ccc;
                border-radius: 5px;
                padding: 5px;
            }

            /* ✅ Improve button appearance */
            .btn-danger, .btn-primary {
                transition: 0.3s ease-in-out;
            }

            .btn-danger:hover {
                background-color: #dc3545;
                transform: scale(1.05);
            }

            .btn-primary:hover {
                transform: scale(1.05);
            }

            /* ✅ Display notification */
            .alert-message {
                display: none;
                position: fixed;
                top: 80px;
                right: 20px;
                z-index: 1000;
                padding: 15px;
                border-radius: 5px;
                background-color: #28a745;
                color: white;
                font-weight: bold;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }

        </style>
    </head>
    <body>

        <jsp:include page="menu.jsp"/>

        <div class="container mt-5">
            <h2 class="text-primary text-center">🛒 Your Shopping Cart</h2>
            <c:if test="${not empty sessionScope.cartError}">
                <div class="alert alert-danger text-center">
                    ${sessionScope.cartError}
                </div>
                <c:remove var="cartError" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.cartMessage}">
                <div class="alert alert-success text-center alert-message" id="cartAlert">
                    ${sessionScope.cartMessage}
                </div>
                <c:remove var="cartMessage" scope="session"/>
            </c:if>

            <c:if test="${empty cartItems}">
                <p class="text-center text-muted">Your cart is empty.</p>
                <div class="text-center">
                    <a href="index.jsp" class="btn btn-primary">🔍 Continue Shopping</a>
                </div>
            </c:if>

            <c:if test="${not empty cartItems}">
                <form action="Checkout" method="POST" id="checkoutForm">
                    <table class="table table-striped cart-table">
                        <thead>
                            <tr>
                                <th>Select <input type="checkbox" id="selectAll" onclick="toggleAll(this)"></th>
                                <th>Image</th>
                                <th>Product Name</th>
                                <th>RAM</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td>
                                        <input type="checkbox" name="selectedItems" value="${item.variantId}" class="product-checkbox">
                                    </td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/ProductImage?id=${item.productId}" width="80" height="80" onerror="this.onerror=null; this.src='default-image.jpg';">
                                        <c:if test="${item.stock == 0}">
                                            <div style="color: red" class="out-of-stock-overlay">--Out of Stock--</div>
                                        </c:if>
                                    </td>
                                    <td>${item.productName}</td>
                                    <td>${item.ram}</td>
                                    <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> VND</td>
                                    <td>
                                        <input type="number" name="quantity_${item.variantId}" value="${item.quantity}" min="1" class="quantity-input">
                                    </td>
                                    <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /> VND</td>
                                    <td>
                                        <form action="RemoveFromCart" method="POST">
                                            <input type="hidden" name="variantId" value="${item.variantId}">
                                            <button type="submit" class="btn btn-danger btn-sm">🗑</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="text-center mt-3">
                        <button type="submit" class="btn btn-success fs-5 px-4">💳 Checkout</button>
                    </div>
                </form>
            </c:if>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
