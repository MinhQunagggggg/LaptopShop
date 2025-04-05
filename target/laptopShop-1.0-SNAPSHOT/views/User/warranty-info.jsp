<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Warranty Info</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
        <style>
            .warranty-status-nav {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
                margin: 20px 0;
                border-bottom: 2px solid #ddd;
            }

            .warranty-status-nav li {
                margin: 0 20px;
            }

            .warranty-status-nav a {
                text-decoration: none;
                font-weight: 600;
                font-size: 18px;
                color: #333;
                padding: 12px 18px;
                transition: all 0.3s ease;
                border-bottom: 3px solid transparent;
            }

            .warranty-status-nav a:hover {
                color: #007bff;
            }

            .warranty-status-nav .active {
                color: #dc3545 !important;
                border-bottom: 4px solid #dc3545;
                font-weight: bold;
                font-size: 20px;
            }

            .table th, .table td {
                vertical-align: middle;
            }

            .status-active {
                color: green;
                font-weight: bold;
            }

            .status-expired {
                color: red;
                font-weight: bold;
            }

            .remaining-time {
                color: #e76f51;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>

        <div class="container mt-5">
            <h2 class="text-primary text-center">📜 Warranty Info</h2>

            <!-- Thanh chọn trạng thái bảo hành -->
            <ul class="warranty-status-nav">
                <li>
                    <a class="${empty param.status ? 'active' : ''}" href="WarrantyInfo">All</a>
                </li>
                <li>
                    <a class="${param.status == 'active' ? 'active' : ''}" href="WarrantyInfo?status=active">Active</a>
                </li>
                <li>
                    <a class="${param.status == 'expired' ? 'active' : ''}" href="WarrantyInfo?status=expired">Expired</a>
                </li>
            </ul>

            <c:if test="${empty warrantyItems}">
                <p class="text-center text-muted">You have no warranty items in this category.</p>
            </c:if>

            <c:if test="${not empty warrantyItems}">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>RAM</th>
                            <th>Warranty Start Date</th>
                            <th>Warranty End Date</th>
                            <th>Warranty Status</th>
                            <th>Remaining Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${warrantyItems}">
                            <tr>
                                <td>
                                    <a href="${pageContext.request.contextPath}/WarrantyDetail?id=${item.orderdetailId}">
                                        <img src="${pageContext.request.contextPath}/ProductImage?id=${item.variantId}" 
                                             width="60" alt="Product Image" 
                                             onerror="this.src='${pageContext.request.contextPath}/images/default-product.jpg';">
                                    </a>
                                </td>
                                <td>${item.productName}</td>
                                <td>${item.ram}</td>
                                <td>
                                    <fmt:formatDate value="${item.warrantyStartDate}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td>
                                    <fmt:formatDate value="${item.warrantyEndDate}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.warrantyEndDate > currentDate}">
                                            <span class="status-active">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-expired">Expired</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.warrantyEndDate > currentDate}">
                                            <c:set var="remainingDays" value="${(item.warrantyEndDate.time - currentDate.time) / (1000 * 60 * 60 * 24)}" />
                                            <c:set var="remainingMonths" value="${fn:substringBefore(remainingDays / 30, '.')}"/>
                                            <span class="remaining-time">${remainingMonths} months</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-expired">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>

        <jsp:include page="footer.jsp"/>    
    </body>
</html>