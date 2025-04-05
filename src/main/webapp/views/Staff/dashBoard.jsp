<%@ page import="java.util.List" %>
<%@ page import="Model_Staff.Order" %>
<%@ page import="java.util.Map, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Staff Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Staffacj/css/styles.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">      
            <script>
                // L?y giá tr? t? EL và ??m b?o là string
                const fullName = "${user.name != null ? user.name : 'Guest'}"; // Thêm d?u nháy và x? lý null
                const lastName = fullName.split(" ").pop(); // L?y tên cu?i
                console.log(lastName); // K?t qu?: "Minh" n?u fullName là "Tran Nhat Minh"

                // Ki?m tra ?? dài lastName và quy?t ??nh giá tr? hi?n th?
                const displayText = lastName.length > 15 ? "Hello, Staff" : "Hello, " + lastName;

                // Gán giá tr? vào HTML
                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelector(".navbar-brand p").textContent = displayText;
                });
            </script>
            <a class="navbar-brand ps-3" href="Dashboard"><p></p></a> <!-- Ban ??u ?? tr?ng -->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <ul class="navbar-nav ms-auto ms-md-10 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li>
                            <form action="CustomerProfileDetail" method="post" style="display: inline;">
                                <input type="hidden" name="userId" value="${user.id}">
                                <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 6px 12px; text-align: left; width: 100%; color: inherit; cursor: pointer;">My Profile</button>
                            </form>
                        </li>
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

                            <a class="nav-link" href="Dashboard">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-line"></i></div>
                                Dashboard
                            </a>

                            <a class="nav-link" href="${pageContext.request.contextPath}/OrderList">
                                <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                                Order List
                            </a>

                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewProducts">
                                <div class="sb-nav-link-icon"><i class="fas fa-box-open"></i></div>
                                View Products
                            </a>

                            <a class="nav-link" href="${pageContext.request.contextPath}/CustomerList">
                                <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                                View Customer List
                            </a>

                            <a class="nav-link" href="${pageContext.request.contextPath}/ViewWarranty">
                                <div class="sb-nav-link-icon"><i class="fas fa-shield-alt"></i></div>
                                View Warranty
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Staff Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol>

                        <!-- 6 Information Boxes without View Details -->
                        <div class="row">
                            <div class="col-xl-2 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">
                                        <div class="sb-nav-link-icon"><i class="fas fa-boxes"></i></div>
                                        Total Products
                                        <h4>${totalProducts}</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-2 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body">
                                        <div class="sb-nav-link-icon"><i class="fas fa-exclamation-triangle"></i></div>
                                        Low Stock Products
                                        <h4>${lowStockProducts}</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-2 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body">
                                        <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                                        Total Customers
                                        <h4>${totalCustomers}</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-2 col-md-6">
                                <div class="card bg-info text-white mb-4">
                                    <div class="card-body">
                                        <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                                        Today's Orders
                                        <h4>${todayOrders}</h4>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-2 col-md-6">
                                <div class="card bg-secondary text-white mb-4">
                                    <div class="card-body">
                                        <div class="sb-nav-link-icon"><i class="fas fa-dollar-sign"></i></div>
                                        Today's Revenue
                                        <h4 id="todayRevenue"></h4>
                                    </div>

                                    <script>
                                        // Gi? s? todayRevenue ?ã có giá tr?
                                        let todayRevenue = ${todayRevenue};

                                        // Chuy?n ??i todayRevenue thành d?ng chu?i có phân cách hàng nghìn
                                        const formattedRevenue = todayRevenue.toLocaleString('vi-VN');

                                        // ??a giá tr? ?ã ???c ??nh d?ng vào trong ph?n t? có id="todayRevenue"
                                        document.getElementById('todayRevenue').innerHTML = formattedRevenue + " VND";
                                    </script>
                                </div>
                            </div>
                            <div class="col-xl-2 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body">
                                        <div class="sb-nav-link-icon"><i class="fas fa-tools"></i></div>
                                        Pending Warranty
                                        <h4>${pendingWarranty}</h4>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Weekly Charts -->
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        Weekly Order Chart
                                    </div>
                                    <div class="card-body"><canvas id="weeklyOrderChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        Weekly Revenue Chart
                                    </div>
                                    <div class="card-body"><canvas id="weeklyRevenueChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4">
                            <div class="content">
                                <div class="container">
                                    <h2 class="header text-center">Order List</h2> <!-- ??t tiêu ?? vào gi?a -->
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>User ID</th>
                                                <th>Name</th>
                                                <th>Phone</th>
                                                <th>Order ID</th>
                                                <th>Status</th>
                                                <th>Created At</th>
                                                <th>Total Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% List<Order> orders = (List<Order>) request.getAttribute("listorder"); %>
                                            <% if (orders != null && !orders.isEmpty()) { %>
                                            <% for (Order order : orders) { 
                                                String statusClass = "";
                                                String statusText = order.getStatus();

                                                if (statusText.equals("Pending Confirmation")) {
                                                    statusClass = "badge bg-warning"; // Yellow
                                                    statusText = "Pending";
                                                } else if (statusText.equals("Processing")) {
                                                    statusClass = "badge bg-primary"; // Blue (Processing)
                                                } else if (statusText.equals("Completed")) {
                                                    statusClass = "badge bg-success"; // Green
                                                } else if (statusText.equals("Canceled")) { 
                                                    statusClass = "badge bg-danger"; // Red (Canceled)
                                                }
                                            %>
                                            <tr>
                                                <td><%= order.getUserId() %></td>
                                                <td><%= order.getName() %></td>
                                                <td><%= order.getPhone() %></td>
                                                <td><%= order.getOrderId() %></td>
                                                <td><span class="<%= statusClass %>"><%= statusText %></span></td>
                                                <td><%= order.getCreateAt() %></td>
                                                <td><%= String.format("%,.0f", order.getTotalPrice()) %> VND</td>
                                            </tr>

                                            <% } %>
                                            <% } else { %>
                                            <tr>
                                                <td colspan="7" class="text-center">No orders found.</td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>


                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
                        <script src="/Staffacj/js/scripts.js"></script>
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
                        <script src="/Staffacj/assets/demo/chart-area-demo.js"></script>
                        <script src="/Staffacj/assets/demo/chart-bar-demo.js"></script>
                        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
                        <script src="/Staffacj/js/datatables-simple-demo.js"></script>
                        <!-- Custom chart scripts -->

                        <script>
                                        // ? Kh?i t?o m?ng r?ng
                                        const orderLabels = [];
                                        const orderData = [];
                                        const revenueData = [];

                            <% 
                                List<Map<String, Object>> weeklyOrders = (List<Map<String, Object>>) request.getAttribute("weeklyOrders");
                                List<Map<String, Object>> weeklyRevenue = (List<Map<String, Object>>) request.getAttribute("weeklyRevenue");

                                // ? L?y d? li?u cho s? l??ng ??n hàng
                                if (weeklyOrders != null) {
                                    for (Map<String, Object> order : weeklyOrders) {
                            %>
                                        orderLabels.push('<%= order.get("day_of_week") %>');
                                        orderData.push(<%= order.get("order_count") %>);
                            <% 
                                    }
                                }

                                // ? L?y d? li?u cho doanh thu
                                if (weeklyRevenue != null) {
                                    for (Map<String, Object> revenue : weeklyRevenue) {
                            %>
                                        revenueData.push(<%= revenue.get("total_revenue") %>);
                            <% 
                                    }
                                }
                            %>

                                        // ? Ki?m tra d? li?u ?? debug
                                        console.log("Order Labels: ", orderLabels);
                                        console.log("Order Data: ", orderData);
                                        console.log("Revenue Data: ", revenueData);

                                        // ? Bi?u ?? s? l??ng ??n hàng
                                        window.onload = function () {
                                            var ctx1 = document.getElementById("weeklyOrderChart");
                                            var ctx2 = document.getElementById("weeklyRevenueChart");

                                            // ? Bi?u ?? s? l??ng ??n hàng
                                            if (ctx1) {
                                                var weeklyOrderChart = new Chart(ctx1.getContext('2d'), {
                                                    type: 'line',
                                                    data: {
                                                        labels: orderLabels,
                                                        datasets: [{
                                                                label: "Number of Orders",
                                                                data: orderData,
                                                                backgroundColor: "rgba(54, 162, 235, 0.2)",
                                                                borderColor: "rgba(54, 162, 235, 1)",
                                                                borderWidth: 2,
                                                                pointRadius: 3,
                                                                pointHoverRadius: 5,
                                                                tension: 0.4
                                                            }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        plugins: {
                                                            legend: {
                                                                display: true,
                                                                position: 'top'
                                                            },
                                                            tooltip: {
                                                                enabled: true
                                                            }
                                                        },
                                                        scales: {
                                                            x: {
                                                                title: {
                                                                    display: true,
                                                                    text: 'Day of Week'
                                                                }
                                                            },
                                                            y: {
                                                                title: {
                                                                    display: true,
                                                                    text: 'Number of Orders'
                                                                },
                                                                beginAtZero: true
                                                            }
                                                        }
                                                    }
                                                });
                                            } else {
                                                console.error("Không tìm th?y canvas cho Order Chart");
                                            }

                                            // ? Bi?u ?? doanh thu
                                            if (ctx2) {
                                                var weeklyRevenueChart = new Chart(ctx2.getContext('2d'), {
                                                    type: 'bar',
                                                    data: {
                                                        labels: orderLabels,
                                                        datasets: [{
                                                                label: "Revenue",
                                                                data: revenueData,
                                                                backgroundColor: "rgba(75, 192, 192, 0.2)",
                                                                borderColor: "rgba(75, 192, 192, 1)",
                                                                borderWidth: 2
                                                            }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        plugins: {
                                                            legend: {
                                                                display: true,
                                                                position: 'top'
                                                            },
                                                            tooltip: {
                                                                enabled: true
                                                            }
                                                        },
                                                        scales: {
                                                            x: {
                                                                title: {
                                                                    display: true,
                                                                    text: 'Day of Week'
                                                                }
                                                            },
                                                            y: {
                                                                title: {
                                                                    display: true,
                                                                    text: 'Total Revenue (VND)'
                                                                },
                                                                beginAtZero: true
                                                            }
                                                        }
                                                    }
                                                });
                                            } else {
                                                console.error("Không tìm th?y canvas cho Revenue Chart");
                                            }
                                        };
                        </script>

                        </body>
                        </html>