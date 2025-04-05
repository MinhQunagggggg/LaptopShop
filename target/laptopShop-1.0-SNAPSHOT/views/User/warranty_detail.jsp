<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Warranty Detail</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
        <!-- Load Bootstrap CSS and JS in the head to ensure they are available -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .warranty-container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .warranty-content {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 30px;
            }

            .product-image-wrapper {
                flex: 1;
                min-width: 300px;
                text-align: center;
            }

            .product-image {
                max-width: 300px;
                width: 100%;
                border-radius: 8px;
            }

            .warranty-info {
                flex: 1;
                min-width: 300px;
            }

            .warranty-info h3 {
                margin: 0 0 15px;
                color: #f4a261;
                font-weight: 600;
            }

            .product-name {
                font-size: 18px;
                color: #333;
                margin-bottom: 15px;
            }

            .warranty-status {
                font-size: 16px;
                color: #2a9d8f;
                margin-bottom: 10px;
            }

            .repair-status {
                font-size: 16px;
                margin-bottom: 10px;
            }

            .status-waiting {
                color: #f4a261; /* Đang đợi xác nhận */
            }

            .status-confirmed {
                color: #2a9d8f; /* Đã xác nhận và đang bảo hành */
            }

            .status-success {
                color: #2a9d8f; /* Bảo hành thành công */
            }

            .status-rejected {
                color: #e76f51; /* Từ chối bảo hành */
            }

            .remaining-time {
                font-weight: bold;
                margin-bottom: 15px;
            }

            .remaining-time-green {
                color: #2a9d8f; /* Xanh nếu trên 6 tháng */
            }

            .remaining-time-red {
                color: #e76f51; /* Đỏ nếu dưới 6 tháng */
            }

            .timeline {
                position: relative;
                height: 40px;
                margin: 20px 0;
            }

            .timeline-line {
                height: 4px;
                background: #ddd;
                position: absolute;
                top: 50%;
                left: 0;
                right: 0;
                transform: translateY(-50%);
            }

            .timeline-progress {
                height: 100%;
                background: #2a9d8f;
                position: absolute;
                top: 0;
                left: 0;
            }

            .timeline-dot {
                width: 12px;
                height: 12px;
                background: #2a9d8f;
                border: 2px solid #fff;
                border-radius: 50%;
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                z-index: 1;
            }

            .timeline-dot-current {
                background: #f4a261;
            }

            .timeline-label {
                position: absolute;
                top: 100%;
                font-size: 14px;
                color: #666;
                white-space: nowrap;
            }

            .repair-form {
                margin-top: 30px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 8px;
            }

            .repair-form label {
                font-weight: 500;
                color: #333;
            }

            .repair-form .note {
                font-size: 14px;
                color: #666;
                margin-bottom: 15px;
                font-style: italic;
            }

            .btn-custom {
                background-color: #2a9d8f;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
            }

            .btn-custom:hover {
                background-color: #264653;
            }

            .btn-custom:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }

            @media (max-width: 768px) {
                .warranty-container {
                    padding: 15px;
                }
                .warranty-content {
                    flex-direction: column;
                    align-items: center;
                }
                .product-image {
                    max-width: 250px;
                }
                .product-name {
                    font-size: 16px;
                }
                .warranty-status, .repair-status {
                    font-size: 14px;
                }
                .timeline {
                    height: 30px;
                }
                .timeline-label {
                    font-size: 12px;
                }
            }

            @media (max-width: 576px) {
                .product-image {
                    max-width: 200px;
                }
                .warranty-info h3 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>

        <div class="container">
            <div class="warranty-container">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" id="errorAlert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" id="successAlert">
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty warrantyDetail}">
                        <div class="alert alert-warning text-center" role="alert">
                            No warranty information found for this item.
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/WarrantyInfo" class="btn btn-secondary">Back to Warranty List</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="warranty-content">
                            <div class="product-image-wrapper">
                                <img src="${pageContext.request.contextPath}/ProductImage?id=${warrantyDetail.variantId}" 
                                     class="product-image img-fluid" 
                                     alt="Product Image" 
                                     onerror="this.src='${pageContext.request.contextPath}/images/default-product.jpg';">
                            </div>
                            <div class="warranty-info">
                                <h3>Warranty & Services</h3>
                                <div class="product-name">
                                    ${warrantyDetail.productName}
                                    <c:if test="${not empty warrantyDetail.ram}">
                                        (${warrantyDetail.ram})
                                    </c:if>
                                </div>
                                <div class="warranty-status">
                                    Warranty Status: 
                                    <c:choose>
                                        <c:when test="${warrantyDetail.warrantyEndDate.time > currentDate.time}">
                                            <span style="color: #2a9d8f;">In Warranty</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #e76f51;">Expired</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Hiển thị trạng thái sửa chữa nếu warrantyId không null -->
                                <c:if test="${not empty warrantyDetail.warrantyId}">
                                    <div class="repair-status">
                                        <c:choose>
                                            <c:when test="${warrantyDetail.statusId == 1}">
                                                <span class="status-waiting">Repair Status: Device is waiting for confirmation.</span>
                                            </c:when>
                                            <c:when test="${warrantyDetail.statusId == 2}">
                                                <span class="status-confirmed">Repair Status: The device has been verified and is under warranty.</span>
                                            </c:when>
                                            <c:when test="${warrantyDetail.statusId == 3}">
                                                <span class="status-success">Repair Status: Warranty device successful.</span>
                                            </c:when>
                                            <c:when test="${warrantyDetail.statusId == 4}">
                                                <span class="status-rejected">Repair Status: Warranty claim denied.</span>
                                            </c:when>
                                            <c:otherwise>                                               
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:if>

                                <c:if test="${warrantyDetail.warrantyEndDate.time > currentDate.time}">
                                    <div class="remaining-time">
                                        <c:set var="remainingDays" value="${(warrantyDetail.warrantyEndDate.time - currentDate.time) / (1000 * 60 * 60 * 24)}" />
                                        <c:set var="remainingMonths" value="${fn:substringBefore(remainingDays / 30, '.')}"/>
                                        Current Service & Support Status: ${remainingMonths} months remaining
                                        <c:choose>
                                            <c:when test="${remainingMonths < 6}">
                                                <span class="remaining-time-red"><c:if test="${remainingMonths < 7}">⚠</c:if></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="remaining-time-green"><c:if test="${remainingMonths < 7}">⚠</c:if></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:if>

                                <!-- Thanh trạng thái bảo hành -->
                                <div class="timeline">
                                    <div class="timeline-line">
                                        <div class="timeline-progress" style="width:
                                             <c:choose>
                                                 <c:when test="${warrantyDetail.warrantyEndDate.time > currentDate.time}">
                                                     ${((currentDate.time - warrantyDetail.warrantyStartDate.time) * 100) / (warrantyDetail.warrantyEndDate.time - warrantyDetail.warrantyStartDate.time)}%
                                                 </c:when>
                                                 <c:otherwise>100%</c:otherwise>
                                             </c:choose>">
                                        </div>
                                        <div class="timeline-dot" style="left: 0;"></div>
                                        <div class="timeline-dot timeline-dot-current" style="left:
                                             <c:choose>
                                                 <c:when test="${warrantyDetail.warrantyEndDate.time > currentDate.time}">
                                                     ${((currentDate.time - warrantyDetail.warrantyStartDate.time) * 100) / (warrantyDetail.warrantyEndDate.time - warrantyDetail.warrantyStartDate.time)}%
                                                 </c:when>
                                                 <c:otherwise>100%</c:otherwise>
                                             </c:choose>">
                                        </div>
                                        <div class="timeline-dot" style="right: 0;"></div>
                                    </div>
                                    <div class="timeline-label" style="left: 0;">
                                        Started: <fmt:formatDate value="${warrantyDetail.warrantyStartDate}" pattern="MMM yyyy"/>
                                    </div>
                                    <div class="timeline-label" style="right: 0;">
                                        End: <fmt:formatDate value="${warrantyDetail.warrantyEndDate}" pattern="MMM yyyy"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form gửi yêu cầu sửa chữa -->
                        <c:set var="canSubmitRepair"
                               value="${
                               warrantyDetail.warrantyEndDate.time > currentDate.time
                                   and
                                   (warrantyDetail.statusId != 1 and warrantyDetail.statusId != 2)
                               }" />
                        <c:if test="${warrantyDetail.warrantyEndDate.time > currentDate.time}">
                            <div class="repair-form">
                                <h4 class="text-primary">Request Repair</h4>
                                <p class="note">Note: Please ensure all information is correct and provide a clear reason for the repair request. We will contact you within 24 hours to confirm your request.</p>
                                <form action="${pageContext.request.contextPath}/SubmitRepairRequest" method="post">
                                    <input type="hidden" name="orderDetailId" value="${warrantyDetail.orderdetailId}">
                                    <div class="mb-3">
                                        <label for="customerName" class="form-label">Customer Name:</label>
                                        <input type="text" class="form-control" id="customerName" name="customerName" required
                                               <c:if test="${not canSubmitRepair}">disabled</c:if>>
                                        </div>
                                        <div class="mb-3">  
                                            <label for="phone" class="form-label">Phone Number:</label>
                                            <input type="text" class="form-control" id="phone" name="phone" required
                                            <c:if test="${not canSubmitRepair}">disabled</c:if>>
                                        </div>
                                        <div class="mb-3">
                                            <label for="address" class="form-label">Address:</label>
                                            <textarea class="form-control" id="address" name="address" rows="3" required
                                            <c:if test="${not canSubmitRepair}">disabled</c:if>></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="repairLocation" class="form-label">Repair Location:</label>
                                            <select class="form-control" id="repairLocation" name="repairLocation" required
                                            <c:if test="${not canSubmitRepair}">disabled</c:if>>
                                                <option value="" disabled selected>Select a location</option>
                                                <option value="Hà Nội">Ha Noi</option>
                                                <option value="Cần Thơ">Can Tho</option>
                                                <option value="Hồ Chí Minh">Ho Chi Minh</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="repairReason" class="form-label">Reason for Repair:</label>
                                            <textarea class="form-control" id="repairReason" name="repairReason" rows="3" required
                                                      placeholder="Please describe the issue with your product..."
                                            <c:if test="${not canSubmitRepair}">disabled</c:if>></textarea>
                                        </div>
                                        <button type="submit" class="btn-custom" <c:if test="${not canSubmitRepair}">disabled</c:if>>Submit Request</button>
                                    </form>
                                </div>
                        </c:if>

                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/WarrantyInfo" 
                               class="btn btn-secondary">Back to Warranty List</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <!-- Script để ẩn thông báo sau 5 giây -->
        <script>
            // Ẩn thông báo success sau 5 giây
            const successAlert = document.getElementById('successAlert');
            if (successAlert) {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(successAlert);
                    bsAlert.close();
                }, 5000);
            }

            // Ẩn thông báo error sau 5 giây
            const errorAlert = document.getElementById('errorAlert');
            if (errorAlert) {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(errorAlert);
                    bsAlert.close();
                }, 5000);
            }
        </script>
    </body>
</html>