<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #1a1d20;
            padding: 20px;
            color: white;
            position: fixed;
            border-radius: 0 10px 10px 0;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
        }
        .sidebar h3 {
            text-align: center;
            font-weight: bold;
            padding-bottom: 15px;
            border-bottom: 1px solid #444;
        }
        .sidebar .nav-item {
            margin: 10px 0;
        }
        .sidebar .nav-link {
            color: #ccc;
            padding: 10px;
            border-radius: 5px;
            transition: 0.3s;
            display: flex;
            align-items: center;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
        }
        .sidebar .nav-link:hover {
            background-color: #28a745;
            color: white;
        }
        .content {
            margin-left: 270px;
            padding: 20px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 2px 2px 15px rgba(0, 0, 0, 0.1);
        }
        .chart-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 2px 2px 15px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h3>Staff Dashboard</h3>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="Dashboard" class="nav-link"><i class="bi bi-house-door"></i> Dashboard</a></li>
            <li class="nav-item"><a href="OrderList" class="nav-link"><i class="bi bi-box-seam"></i> Order Management</a></li>
            <li class="nav-item"><a href="#" class="nav-link"><i class="bi bi-people"></i> Customer Management</a></li>
            <li class="nav-item"><a href="ViewProducts" class="nav-link"><i class="bi bi-chat-left-text"></i> Comments Management</a></li>
        </ul>
    </div>

    <div class="content">
        <h2 class="mb-4">Welcome, Staff!</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="card p-3 text-center">
                    <h5><i class="bi bi-cart-check"></i> Orders Today</h5>
                    <p class="fs-3 text-success">50</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 text-center">
                    <h5><i class="bi bi-box"></i> Products</h5>
                    <p class="fs-3 text-primary">120</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 text-center">
                    <h5><i class="bi bi-currency-dollar"></i> Revenue</h5>
                    <p class="fs-3 text-danger">$12,000</p>
                </div>
            </div>
        </div>

        <div class="chart-container">
            <canvas id="orderChart" width="400" height="150"></canvas>
        </div>
    </div>

    <script>
        var ctx = document.getElementById('orderChart').getContext('2d');
        var orderChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'Orders Per Day',
                    data: [12, 19, 3, 5, 2, 3, 10],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: false
                }]
            }
        });
    </script>
</body>
</html>
