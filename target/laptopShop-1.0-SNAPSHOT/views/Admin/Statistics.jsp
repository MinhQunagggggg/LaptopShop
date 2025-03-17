<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/stylesAdmin.css" rel="stylesheet" />
        <style>
            body {
                background: #f9fafb;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                overflow-x: hidden;
            }
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 220px;
                height: 100%;
                background: #f1f5f9;
                color: #334155;
                padding-top: 30px;
                transition: all 0.3s ease;
            }
            .sidebar .nav-link {
                color: #334155;
                padding: 12px 25px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 1rem;
                font-weight: 500;
                border-radius: 0 25px 25px 0;
                transition: all 0.3s ease;
            }
            .sidebar .nav-link:hover {
                background: #fff;
                color: #2563eb;
            }
            .sidebar .nav-link.active {
                background: #fff;
                color: #2563eb;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }
            .content {
                margin-left: 220px;
                padding: 30px;
            }
            .header {
                background: #fff;
                padding: 15px 25px;
                border-radius: 12px;
                margin-bottom: 30px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }
            .header h2 {
                font-size: 1.8rem;
                color: #1e293b;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .form-section {
                background: #fff;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                margin-bottom: 30px;
            }
            .form-section .form-label {
                font-weight: 500;
                color: #334155;
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 1rem;
            }
            .form-section .form-control, .form-section .form-select {
                border: 1px solid #e2e8f0;
                border-radius: 8px;
                padding: 12px 15px;
                background: #f9fafb;
                font-size: 1rem;
                transition: all 0.3s ease;
            }
            .form-section .form-control:focus, .form-section .form-select:focus {
                border-color: #a5b4fc;
                box-shadow: 0 0 6px rgba(165, 180, 252, 0.3);
                background: #fff;
            }
            .form-section .btn {
                padding: 12px 25px;
                border-radius: 8px;
                font-weight: 500;
                font-size: 1rem;
                transition: all 0.3s ease;
            }
            .form-section .btn-primary {
                background: #a5b4fc;
                border: none;
                color: #1e3a8a;
            }
            .form-section .btn-primary:hover {
                background: #c7d2fe;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(165, 180, 252, 0.3);
            }
            .form-section .btn-secondary {
                background: #e2e8f0;
                border: none;
                color: #334155;
            }
            .form-section .btn-secondary:hover {
                background: #d1d5db;
                transform: translateY(-2px);
            }
            .nav-tabs {
                border: none;
                background: #fff;
                padding: 15px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                margin-bottom: 30px;
                display: flex;
                justify-content: space-around;
            }
            .nav-tabs .nav-link {
                color: #334155;
                padding: 12px 25px;
                border-radius: 8px;
                font-weight: 500;
                font-size: 1rem;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .nav-tabs .nav-link:hover {
                background: #f9fafb;
                color: #2563eb;
            }
            .nav-tabs .nav-link.active {
                color: #1e293b;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .nav-tabs .nav-link.tab-primary.active {
                background: #e0e7ff;
            }
            .nav-tabs .nav-link.tab-warning.active {
                background: #ffedd5;
            }
            .nav-tabs .nav-link.tab-success.active {
                background: #d1fae5;
            }
            .nav-tabs .nav-link.tab-danger.active {
                background: #ffe4e6;
            }
            .tab-content {
                transition: opacity 0.3s ease;
            }
            .tab-pane {
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            .tab-pane.show {
                opacity: 1;
            }
            .card {
                border: none;
                border-radius: 12px;
                background: #fff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                margin-bottom: 30px;
                transition: all 0.3s ease;
            }
            .card:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            .card-header {
                padding: 15px 20px;
                border-bottom: none;
                border-radius: 12px 12px 0 0;
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 500;
                font-size: 1.2rem;
            }
            .card-header.tab-primary {
                background: #e0e7ff;
                color: #1e3a8a;
            }
            .card-header.tab-warning {
                background: #ffedd5;
                color: #9a3412;
            }
            .card-header.tab-success {
                background: #d1fae5;
                color: #065f46;
            }
            .card-header.tab-danger {
                background: #ffe4e6;
                color: #9f1239;
            }
            .card-body {
                padding: 25px;
            }
            .chart-canvas {
                height: 300px !important;
                border-radius: 8px;
            }
            .table-container .card-header {
                background: #f9fafb;
                color: #334155;
            }
            .table {
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 1px 6px rgba(0, 0, 0, 0.03);
                margin-bottom: 0;
            }
            .table thead th {
                background: #f9fafb;
                color: #334155;
                font-weight: 500;
                padding: 12px 15px;
                font-size: 1rem;
                border-bottom: 1px solid #e2e8f0;
            }
            .table tbody td {
                padding: 12px 15px;
                color: #4b5563;
                font-size: 0.95rem;
            }
            .table tbody tr:hover {
                background: #f9fafb;
                transition: background 0.2s ease;
            }
            .footer {
                background: #fff;
                padding: 15px 25px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                text-align: center;
                color: #4b5563;
                font-size: 0.9rem;
                margin-top: 30px;
            }
        </style>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/Home">
                <img src="${pageContext.request.contextPath}/assets/img/logoDashboard.png" 
                     alt="Logo" width="120" height="120" 
                     style="display: block; margin: auto; margin-top: 50px; filter: brightness(1.3);">
            </a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <button class="btn btn-outline-secondary align-items-center fs-7 py-1 px-2 mt-5 me-1" 
                                type="button" id="userMenu" data-bs-toggle="dropdown">
                            <span class="fw-medium">${sessionScope.user.name} (Admin)</span>
                        </button>
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="statistics">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Thống Kê
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Thêm sản phẩm
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="add-product">Laptop</a>
                                    <a class="nav-link" href="AddMonitor">Màn hình</a>
                                    <a class="nav-link" href="AddMouse">Chuột</a>
                                    <a class="nav-link" href="AddKeyboard">Bàn phím</a>
                                    <a class="nav-link" href="AddHeadphone">Tai nghe</a>
                                </nav>
                            </div>
                            <a class="nav-link" href="list-products">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Danh sách sản phẩm
                            </a>
                            <a class="nav-link" href="staff-list">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Quản lí nhân viên
                            </a>
                            
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    
                                    
                                    
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="401.html">401 Page</a>
                                            <a class="nav-link" href="404.html">404 Page</a>
                                            <a class="nav-link" href="500.html">500 Page</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            
                        </div>
                    </div>
                    
                </nav>
            </div>
            <div id="layoutSidenav_content">
                    <main>
                        <!-- Content -->
                        <div class="content">
                            <div class="header">
                                <h2><i class="fas fa-chart-line"></i> Thống Kê Tổng Hợp</h2>
                            </div>

                            <!-- Form lọc -->
                            <div class="form-section">
                                <form id="statsForm" class="row g-3">
                                    <div class="col-md-4">
                                        <label for="year" class="form-label"><i class="fas fa-calendar-alt"></i> Năm</label>
                                        <input type="number" id="year" name="year" class="form-control" placeholder="Ví dụ: 2025" min="2000" max="2100">
                                    </div>
                                    <div class="col-md-4">
                                        <label for="month" class="form-label"><i class="fas fa-calendar-week"></i> Tháng</label>
                                        <select id="month" name="month" class="form-select">
                                            <option value="">Tất Cả Các Tháng</option>
                                            <option value="1">Tháng 1</option>
                                            <option value="2">Tháng 2</option>
                                            <option value="3">Tháng 3</option>
                                            <option value="4">Tháng 4</option>
                                            <option value="5">Tháng 5</option>
                                            <option value="6">Tháng 6</option>
                                            <option value="7">Tháng 7</option>
                                            <option value="8">Tháng 8</option>
                                            <option value="9">Tháng 9</option>
                                            <option value="10">Tháng 10</option>
                                            <option value="11">Tháng 11</option>
                                            <option value="12">Tháng 12</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-end gap-2">
                                        <button type="button" onclick="loadAllCharts()" class="btn btn-primary w-50"><i class="fas fa-eye"></i> Xem</button>
                                        <button type="button" onclick="resetForm()" class="btn btn-secondary w-50"><i class="fas fa-undo"></i> Đặt Lại</button>
                                    </div>
                                </form>
                            </div>

                            <!-- Tabs -->
                            <ul class="nav nav-tabs" id="statsTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active tab-primary" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button" role="tab"><i class="fas fa-shopping-cart"></i> Đơn Hàng</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link tab-warning" id="product-tab" data-bs-toggle="tab" data-bs-target="#product" type="button" role="tab"><i class="fas fa-box"></i> Sản Phẩm</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link tab-success" id="customer-tab" data-bs-toggle="tab" data-bs-target="#customer" type="button" role="tab"><i class="fas fa-users"></i> Khách Hàng</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link tab-primary" id="revenue-tab" data-bs-toggle="tab" data-bs-target="#revenue" type="button" role="tab"><i class="fas fa-wallet"></i> Doanh Thu</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link tab-danger" id="staff-tab" data-bs-toggle="tab" data-bs-target="#staff" type="button" role="tab"><i class="fas fa-user-tie"></i> Nhân Viên</button>
                                </li>
                            </ul>

                            <!-- Tab Content -->
                            <div class="tab-content" id="statsTabContent">
                                <div class="tab-pane fade show active" id="order" role="tabpanel">
                                    <div class="card">
                                        <div class="card-header tab-primary"><i class="fas fa-shopping-cart"></i> Thống Kê Đơn Hàng</div>
                                        <div class="card-body"><canvas id="orderChart" class="chart-canvas"></canvas></div>
                                    </div>
                                    <div class="card table-container">
                                        <div class="card-header"><i class="fas fa-table"></i> Chi Tiết</div>
                                        <div class="card-body">
                                            <table class="table table-striped table-bordered" id="orderTable">
                                                <thead><tr id="orderTableHeader"></tr></thead>
                                                <tbody id="orderTableBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="product" role="tabpanel">
                                    <div class="card">
                                        <div class="card-header tab-warning"><i class="fas fa-box"></i> Thống Kê Sản Phẩm Bán Chạy</div>
                                        <div class="card-body"><canvas id="productChart" class="chart-canvas"></canvas></div>
                                    </div>
                                    <div class="card table-container">
                                        <div class="card-header"><i class="fas fa-table"></i> Chi Tiết</div>
                                        <div class="card-body">
                                            <table class="table table-striped table-bordered" id="productTable">
                                                <thead><tr id="productTableHeader"></tr></thead>
                                                <tbody id="productTableBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="customer" role="tabpanel">
                                    <div class="card">
                                        <div class="card-header tab-success"><i class="fas fa-users"></i> Thống Kê Khách Hàng Mới</div>
                                        <div class="card-body"><canvas id="customerChart" class="chart-canvas"></canvas></div>
                                    </div>
                                    <div class="card table-container">
                                        <div class="card-header"><i class="fas fa-table"></i> Chi Tiết</div>
                                        <div class="card-body">
                                            <table class="table table-striped table-bordered" id="customerTable">
                                                <thead><tr id="customerTableHeader"></tr></thead>
                                                <tbody id="customerTableBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="revenue" role="tabpanel">
                                    <div class="card">
                                        <div class="card-header tab-primary"><i class="fas fa-wallet"></i> Thống Kê Doanh Thu</div>
                                        <div class="card-body"><canvas id="revenueChart" class="chart-canvas"></canvas></div>
                                    </div>
                                    <div class="card table-container">
                                        <div class="card-header"><i class="fas fa-table"></i> Chi Tiết</div>
                                        <div class="card-body">
                                            <table class="table table-striped table-bordered" id="revenueTable">
                                                <thead><tr id="revenueTableHeader"></tr></thead>
                                                <tbody id="revenueTableBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="staff" role="tabpanel">
                                    <div class="card">
                                        <div class="card-header tab-danger"><i class="fas fa-user-tie"></i> Thống Kê Nhân Viên Mới</div>
                                        <div class="card-body"><canvas id="staffChart" class="chart-canvas"></canvas></div>
                                    </div>
                                    <div class="card table-container">
                                        <div class="card-header"><i class="fas fa-table"></i> Chi Tiết</div>
                                        <div class="card-body">
                                            <table class="table table-striped table-bordered" id="staffTable">
                                                <thead><tr id="staffTableHeader"></tr></thead>
                                                <tbody id="staffTableBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Footer -->
                            <div class="footer">
                                Copyright © Your Website 2025 | <a href="#" class="text-muted">Privacy Policy</a> | <a href="#" class="text-muted">Terms & Conditions</a>
                            </div>
                        </div>


                    </main>
                    <footer class="py-4 bg-light mt-auto">
                        <div class="container-fluid px-4">
                            <div class="d-flex align-items-center justify-content-between small">
                                <div class="text-muted">Copyright © Your Website 2025</div>
                                <div>
                                    <a href="#">Privacy Policy</a>
                                    ·
                                    <a href="#">Terms & Conditions</a>
                                </div>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
            <script src="js/scripts.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
            <script src="assets/demo/chart-area-demo.js"></script>
            <script src="assets/demo/chart-bar-demo.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
            <script src="js/datatables-simple-demo.js"></script>
            <script>
                                            let charts = {};

                                            function formatTime(month, year) {
                                                const monthStr = month < 10 ? '0' + month : month;
                                                return 'Tháng ' + monthStr + '/' + year;
                                            }

                                            function createGradient(ctx, colorStart, colorEnd) {
                                                const gradient = ctx.createLinearGradient(0, 0, 0, 300);
                                                gradient.addColorStop(0, colorStart);
                                                gradient.addColorStop(1, colorEnd);
                                                return gradient;
                                            }

                                            const chartOptions = {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                animation: {duration: 1200, easing: 'easeOutCubic'},
                                                scales: {
                                                    y: {
                                                        beginAtZero: true,
                                                        title: {display: true, color: '#334155', font: {size: 14, weight: '500'}},
                                                        ticks: {
                                                            color: '#4b5563',
                                                            font: {size: 12},
                                                            callback: function (value) {
                                                                return Math.round(value); // Làm tròn số để loại bỏ thập phân
                                                            },
                                                            stepSize: 1,
                                                            precision: 0 // Đảm bảo không có thập phân
                                                        },
                                                        grid: {color: 'rgba(0, 0, 0, 0.03)'}
                                                    },
                                                    x: {
                                                        title: {display: true, text: 'Thời Gian', color: '#334155', font: {size: 14, weight: '500'}},
                                                        ticks: {autoSkip: false, maxRotation: 45, minRotation: 45, color: '#4b5563', font: {size: 12}},
                                                        grid: {display: false}
                                                    }
                                                },
                                                plugins: {
                                                    legend: {labels: {color: '#334155', font: {size: 14}}},
                                                    tooltip: {
                                                        backgroundColor: '#fff',
                                                        titleColor: '#334155',
                                                        bodyColor: '#4b5563',
                                                        borderColor: '#e2e8f0',
                                                        borderWidth: 1,
                                                        cornerRadius: 8,
                                                        padding: 10,
                                                        callbacks: {
                                                            label: function (context) {
                                                                let label = context.dataset.label || '';
                                                                if (label)
                                                                    label += ': ';
                                                                let value = Math.round(context.parsed.y); // Làm tròn số trong tooltip
                                                                return label + value.toLocaleString('vi-VN');
                                                            }
                                                        }
                                                    }
                                                }
                                            };

                                            async function loadChart(type, chartId, tableId, endpoint, title, yTitle, chartType, color) {
                                                const year = document.getElementById('year').value || '';
                                                const month = document.getElementById('month').value || '';
                                                const url = '<%=request.getContextPath()%>' + '/' + endpoint + '?' + (year ? 'year=' + year : '') + (month ? '&month=' + month : '');
                                                console.log('Fetching: ' + url);

                                                try {
                                                    const response = await fetch(url);
                                                    if (!response.ok)
                                                        throw new Error('Network response not ok');
                                                    const data = await response.json();
                                                    console.log(endpoint + ' data:', data);

                                                    if (!data || data.length === 0) {
                                                        console.warn('No data for ' + title);
                                                        clearChartAndTable(chartId, tableId);
                                                        return;
                                                    }

                                                    if (charts[chartId])
                                                        charts[chartId].destroy();

                                                    const ctx = document.getElementById(chartId).getContext('2d');
                                                    let labels, values, tableData;

                                                    if (type === 'products') {
                                                        labels = data.map(stat => formatTime(stat.month, stat.year) + ' - ' + (stat.productName || 'Unknown'));
                                                        values = data.map(stat => Math.round(stat.totalQuantity)); // Làm tròn số lượng
                                                        tableData = data.map(stat => [formatTime(stat.month, stat.year), stat.productName || 'Unknown', Math.round(stat.totalQuantity)]);
                                                    } else if (type === 'revenue') {
                                                        labels = data.map(stat => formatTime(stat.month, stat.year));
                                                        values = data.map(stat => Math.round(stat.totalRevenue)); // Làm tròn doanh thu
                                                        tableData = data.map(stat => [formatTime(stat.month, stat.year), Math.round(stat.totalRevenue).toLocaleString('vi-VN')]);
                                                    } else {
                                                        labels = data.map(stat => formatTime(stat.month, stat.year));
                                                        values = data.map(stat => Math.round(stat.count || 0)); // Làm tròn số đếm
                                                        tableData = data.map(stat => [formatTime(stat.month, stat.year), Math.round(stat.count || 0)]);
                                                    }

                                                    let chartConfig = {
                                                        type: chartType,
                                                        data: {
                                                            labels: labels,
                                                            datasets: [{
                                                                    label: title,
                                                                    data: values,
                                                                    borderColor: color,
                                                                    borderWidth: 2,
                                                                    borderRadius: 8
                                                                }]
                                                        },
                                                        options: {
                                                            ...chartOptions,
                                                            scales: {
                                                                ...chartOptions.scales,
                                                                y: {
                                                                    ...chartOptions.scales.y,
                                                                    title: {...chartOptions.scales.y.title, text: yTitle}
                                                                }
                                                            }
                                                        }
                                                    };

                                                    if (chartType === 'line') {
                                                        chartConfig.data.datasets[0].fill = true;
                                                        chartConfig.data.datasets[0].backgroundColor = createGradient(ctx, color + '80', color + '10');
                                                        chartConfig.data.datasets[0].tension = 0.4;
                                                    } else {
                                                        chartConfig.data.datasets[0].backgroundColor = color + '80';
                                                    }

                                                    charts[chartId] = new Chart(ctx, chartConfig);
                                                    updateTable(tableId, type === 'products' ? ['Thời Gian', 'Tên Sản Phẩm', 'Số Lượng Bán'] : ['Thời Gian', yTitle], tableData);
                                                } catch (error) {
                                                    console.error('Error loading ' + endpoint + ':', error);
                                                    clearChartAndTable(chartId, tableId);
                                                }
                                            }

                                            function updateTable(tableId, headers, data) {
                                                const headerRow = document.getElementById(tableId + 'Header');
                                                const body = document.getElementById(tableId + 'Body');
                                                headerRow.innerHTML = '';
                                                body.innerHTML = '';

                                                headers.forEach(header => {
                                                    const th = document.createElement('th');
                                                    th.textContent = header;
                                                    headerRow.appendChild(th);
                                                });

                                                data.forEach(row => {
                                                    const tr = document.createElement('tr');
                                                    row.forEach(cell => {
                                                        const td = document.createElement('td');
                                                        if (typeof cell === 'number') {
                                                            td.textContent = Math.round(cell).toLocaleString('vi-VN'); // Làm tròn và định dạng
                                                        } else {
                                                            td.textContent = cell;
                                                        }
                                                        tr.appendChild(td);
                                                    });
                                                    body.appendChild(tr);
                                                });
                                            }

                                            function clearChartAndTable(chartId, tableId) {
                                                if (charts[chartId])
                                                    charts[chartId].destroy();
                                                document.getElementById(tableId + 'Header').innerHTML = '';
                                                const tableBody = document.getElementById(tableId + 'Body');
                                                if (tableBody) {
                                                    tableBody.innerHTML = '<tr><td colspan="' + (tableId === 'productTable' ? 3 : 2) + '" class="text-center">Không có dữ liệu</td></tr>';
                                                }
                                            }

                                            async function loadAllCharts() {
                                                const chartPromises = [
                                                    loadChart('orders', 'orderChart', 'orderTable', 'order-stats', 'Số Đơn Hàng', 'Số Đơn Hàng', 'line', '#a5b4fc'),
                                                    loadChart('products', 'productChart', 'productTable', 'product-stats', 'Sản Phẩm Bán Chạy', 'Số Lượng Bán', 'bar', '#fed7aa'),
                                                    loadChart('customers', 'customerChart', 'customerTable', 'customer-stats', 'Khách Hàng Mới', 'Số Khách Hàng', 'bar', '#a7f3d0'),
                                                    loadChart('revenue', 'revenueChart', 'revenueTable', 'revenue-stats', 'Doanh Thu', 'Doanh Thu (VNĐ)', 'bar', '#a5b4fc'),
                                                    loadChart('staff', 'staffChart', 'staffTable', 'staff-stats', 'Nhân Viên Mới', 'Số Nhân Viên', 'bar', '#f9a8d4')
                                                ];
                                                await Promise.all(chartPromises);
                                            }

                                            function resetForm() {
                                                document.getElementById('year').value = '';
                                                document.getElementById('month').value = '';
                                                loadAllCharts();
                                            }

                                            window.onload = function () {
                                                loadAllCharts();
                                            };
            </script>
    </body>
</html>