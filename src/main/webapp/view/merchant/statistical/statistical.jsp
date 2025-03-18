<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Merchant</title>
    <!-- Bootstrap & Font Awesome -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .stat-card {
            border-radius: 10px;
            padding: 15px;
            transition: transform 0.2s, box-shadow 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
        .stat-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 1.5rem;
            color: white;
            margin-right: 15px;
        }
        .bg-primary {
            background-color: #007bff;
        }
        .bg-success {
            background-color: #28a745;
        }
        .stat-content {
            flex-grow: 1;
        }
        .card-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .card-text {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .stat-link {
            font-size: 0.9rem;
            color: #007bff;
            text-decoration: none;
        }
        .stat-link:hover {
            text-decoration: underline;
        }
        /* CSS cho biểu đồ top 5 sản phẩm */
        .top-products {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-top: 20px;
        }
        .product-item {
            display: flex;
            align-items: center;
            width: 100%;
            margin-bottom: 10px;
        }
        .product-label {
            min-width: 180px;
            font-weight: bold;
            font-size: 16px;
        }
        .product-bar {
            position: relative;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }
        /* Màu sắc và kích thước thanh theo thứ hạng */
        .gold   { background: linear-gradient(to right, #FFD700, #FFA500); height: 40px; }
        .silver { background: linear-gradient(to right, #C0C0C0, #A9A9A9); height: 40px; }
        .bronze { background: linear-gradient(to right, #CD7F32, #8B4513); height: 40px; }
        .normal { background: #4CAF50; height: 40px; }
        .low    { background: #2196F3; height: 40px; }
        /* Tooltip khi di chuột vào */
        .product-bar:hover::after {
            content: attr(data-units) " sản phẩm";
            position: absolute;
            top: -28px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 5px 8px;
            border-radius: 5px;
            font-size: 12px;
            white-space: nowrap;
        }
    </style>
</head>
<body class="bg-light p-4">
<div class="container">
    <!-- Phần thống kê tổng -->
    <div class="row mb-4">
        <!-- Tổng Đơn Hàng Đã Bán -->
        <div class="col-md-6">
            <div class="card shadow-sm stat-card">
                <div class="card-body d-flex align-items-center">
                    <div class="stat-icon bg-primary">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-content">
                        <h5 class="card-title">Tổng Đơn Hàng Đã Bán</h5>
                        <h2 class="card-text">${totalOrders}</h2>
                        <a href="/manageOrder" class="stat-link">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Tổng Doanh Thu Thu Được -->
        <div class="col-md-6">
            <div class="card shadow-sm stat-card">
                <div class="card-body d-flex align-items-center">
                    <div class="stat-icon bg-success">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stat-content">
                        <h5 class="card-title">Tổng Doanh Thu Thu Được</h5>
                        <h2 class="card-text">
                            <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/> VNĐ
                        </h2>
                        <a href="#" class="stat-link" onclick="scrollToRevenue()">Xem doanh thu</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Biểu đồ Top 5 Sản Phẩm Bán Chạy Nhất -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title">Top 5 Sản Phẩm Bán Chạy Nhất</h5>
            <div class="top-products">
                <c:forEach items="${topProducts}" var="product" varStatus="status">
                    <c:set var="sold" value="${topSales[status.index]}"/>
                    <c:choose>
                        <c:when test="${status.index == 0}">
                            <c:set var="barClass" value="gold" />
                            <c:set var="extraPadding" value="0px" />
                        </c:when>
                        <c:when test="${status.index == 1}">
                            <c:set var="barClass" value="silver" />
                            <c:set var="extraPadding" value="0px" />
                        </c:when>
                        <c:when test="${status.index == 2}">
                            <c:set var="barClass" value="bronze" />
                            <c:set var="extraPadding" value="0px" />
                        </c:when>
                        <c:when test="${status.index == 3}">
                            <c:set var="barClass" value="normal" />
                            <c:set var="extraPadding" value="25px" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="barClass" value="low" />
                            <c:set var="extraPadding" value="25px" />
                        </c:otherwise>
                    </c:choose>
                    <div class="product-item">
            <span class="product-label" style="padding-left: ${extraPadding};">
                <c:if test="${status.index == 0}">
                    <i class="fas fa-crown" style="color: gold;"></i>
                </c:if>
                <c:if test="${status.index == 1}">
                    <i class="fas fa-crown" style="color: silver;"></i>
                </c:if>
                <c:if test="${status.index == 2}">
                    <i class="fas fa-crown" style="color: #cd7f32;"></i>
                </c:if>
                ${product}
            </span>
                        <div class="product-bar ${barClass}" data-units="${sold}" style="width: ${100 - status.index * 20}%; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">
                                ${sold} sản phẩm
                        </div>
                    </div>
                </c:forEach>
            </div>



        </div>
    </div>

    <!-- Biểu đồ Thống Kê Doanh Thu -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title">Thống Kê Doanh Thu</h5>
            <div id="revenueSection"  class="btn-group mb-3" role="group">
                <button type="button" class="btn btn-secondary" onclick="updateRevenueChart('week')">Tuần</button>
                <button type="button" class="btn btn-secondary" onclick="updateRevenueChart('month')">Tháng</button>
                <button type="button" class="btn btn-secondary" onclick="updateRevenueChart('year')">Năm</button>
            </div>
            <canvas id="revenueChart" width="400" height="200"></canvas>
            </div>
    </div>
</div>

<script>
    // Chuyển dữ liệu doanh thu từ JSTL sang biến JavaScript
    var weeklyDays = [
        <c:forEach items="${weeklyDays}" var="day" varStatus="status">
        "${day}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    var weeklyRevenue = [
        <c:forEach items="${weeklyRevenue}" var="rev" varStatus="status">
        ${rev}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    var monthlyDays = [
        <c:forEach items="${monthlyDays}" var="day" varStatus="status">
        "${day}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    var monthlyRevenue = [
        <c:forEach items="${monthlyRevenue}" var="rev" varStatus="status">
        ${rev}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    var yearlyMonths = [
        <c:forEach items="${yearlyMonths}" var="month" varStatus="status">
        "${month}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    var yearlyRevenue = [
        <c:forEach items="${yearlyRevenue}" var="rev" varStatus="status">
        ${rev}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    var ctxRevenue = document.getElementById('revenueChart').getContext('2d');
    var revenueChart = new Chart(ctxRevenue, {
        type: 'line',
        data: {
            labels: weeklyDays,
            datasets: [{
                label: 'Doanh Thu',
                data: weeklyRevenue,
                borderColor: 'rgba(75, 192, 192, 1)',
                tension: 0.1,
                fill: false
            }]
        },
        options: {
            responsive: true,
            scales: { y: { beginAtZero: true } }
        }
    });

    function updateRevenueChart(period) {
        var labels = [];
        var data = [];
        if (period === 'week') {
            labels = weeklyDays;
            data = weeklyRevenue;
        } else if (period === 'month') {
            labels = monthlyDays;
            data = monthlyRevenue;
        } else if (period === 'year') {
            labels = yearlyMonths;
            data = yearlyRevenue;
        }
        revenueChart.data.labels = labels;
        revenueChart.data.datasets[0].data = data;
        revenueChart.update();
    }
    // Khởi tạo với dữ liệu theo tuần
    updateRevenueChart('week');
    function scrollToRevenue() {
        document.getElementById('revenueSection').scrollIntoView({ behavior: 'smooth' });
    }
</script>

<!-- jQuery và Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
