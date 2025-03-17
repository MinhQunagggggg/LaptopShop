<%-- 
    Document   : checkout
    Created on : Feb 24, 2025, 2:13:30 AM
    Author     : CE182250
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Checkout</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>

        <jsp:include page="menu.jsp"/>

        <div class="container mt-5">
            <h2 class="text-primary text-center">💳 Checkout</h2>

            <c:if test="${empty sessionScope.checkoutItems}">
                <p class="text-center text-muted">No items to checkout.</p>
            </c:if>

            <c:if test="${not empty sessionScope.checkoutItems}">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>RAM</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.checkoutItems}">
                            <tr>
                                <td><img src="${pageContext.request.contextPath}/ProductImage?id=${item.productId}" width="60"></td>
                                <td>${item.productName}</td>
                                <td>${item.ram}</td>
                                <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> VND</td>
                                <td>${item.quantity}</td>
                                <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /> VND</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <form id="checkoutForm" action="${pageContext.request.contextPath}/ConfirmOrderServlet" method="POST">
                    <h4 class="text-danger">Total Amount: 
                        <fmt:formatNumber value="${sessionScope.totalAmount}" pattern="#,###" /> VND
                    </h4>

                    <h3>Shipping Information:</h3>
                    <label>Full Name:</label>
                    <input type="text" name="customerName" required class="form-control"><br>

                    <label>Shipping Address:</label>
                    <input type="text" name="shippingAddress" required class="form-control"><br>

                    <label>Phone Number:</label>
                    <input type="text" name="phone" required class="form-control"><br>

                    <h3>Select Payment Method:</h3>
<input type="radio" name="paymentMethod" value="COD" checked onclick="togglePaymentOptions()"> Cash on Delivery (COD) 💵<br>
<input type="radio" name="paymentMethod" value="BankTransfer" onclick="togglePaymentOptions()"> Bank Transfer 🏦<br>
<input type="radio" name="paymentMethod" value="VNPay" onclick="togglePaymentOptions()"> VNPay Payment 📱<br>

<!-- ✅ Thông tin chuyển khoản ngân hàng -->
<div id="bankTransferInfo" style="display: none; margin-top: 15px; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
    <h5>🏦 Bank Transfer Details:</h5>
    <p><strong>Bank Name:</strong> ABC Bank</p>
    <p><strong>Account Number:</strong> 1234567890</p>
    <p><strong>Account Holder:</strong> Your Company Name</p>
    <p><strong>Note:</strong> Please include your order ID in the transaction note.</p>
</div>

<!-- ✅ Chuyển hướng đến VNPay -->
<input type="hidden" id="vnPayRedirectUrl" value="${pageContext.request.contextPath}/VNPayPayment">


                    <!-- ✅ Send purchased product list -->
                    <c:forEach var="item" items="${sessionScope.checkoutItems}">
                        <input type="hidden" name="selectedItems" value="${item.variantId}">
                        <input type="hidden" name="quantity_${item.variantId}" value="${item.quantity}">
                    </c:forEach>

                    <button type="submit" class="btn btn-success fs-5 px-4 mt-3">✔ Confirm Payment</button>
                </form>

            </c:if>
        </div>

        <jsp:include page="footer.jsp"/>

        <script>
            
    function togglePaymentOptions() {
        let paymentMethod = document.querySelector("input[name='paymentMethod']:checked").value;
        let bankInfo = document.getElementById("bankTransferInfo");

        if (paymentMethod === "BankTransfer") {
            bankInfo.style.display = "block";
        } else {
            bankInfo.style.display = "none";
        }
    }

    document.getElementById("checkoutForm").addEventListener("submit", function (event) {
        let paymentMethod = document.querySelector("input[name='paymentMethod']:checked").value;

        if (paymentMethod === "VNPay") {
            event.preventDefault(); // Ngăn form gửi bình thường
            let redirectUrl = document.getElementById("vnPayRedirectUrl").value;
            window.location.href = redirectUrl; // Chuyển hướng đến VNPay
        }
    });

            document.getElementById("checkoutForm").addEventListener("submit", function (event) {
                console.log("📤 Form is being submitted...");
                let items = document.querySelectorAll("input[name='selectedItems']");
                items.forEach(item => {
                    let quantity = document.querySelector("input[name='quantity_" + item.value + "']").value;
                    console.log("🛒 Sending Variant ID:", item.value, "Quantity:", quantity);
                });
            });
      
    document.getElementById("checkoutForm").addEventListener("submit", function (event) {
        let paymentMethod = document.querySelector("input[name='paymentMethod']:checked").value;

        if (paymentMethod === "VNPay") {
            event.preventDefault(); // Ngăn form gửi bình thường
            let redirectUrl = document.getElementById("vnPayRedirectUrl").value;
            console.log("✅ Chuyển hướng đến VNPay: " + redirectUrl);
            window.location.href = redirectUrl; // Chuyển hướng đến VNPay
        }
    });
</script>


    </body>
</html>

