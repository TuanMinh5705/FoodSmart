<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ Merchant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .dashboard-card {
            position: relative; /* Để stretched-link hoạt động */
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 250px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .dashboard-card .card-body {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }
        .card-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .card-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }
        .card-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 0;
        }
        .divider {
            border-top: 1px solid rgba(0,0,0,0.1);
            margin: 10px 0;
        }
        .detail-link {
            font-weight: bold;
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .detail-link:hover {
            color: #23c723;
        }
        .row.g-4 {
            margin-bottom: 30px;
        }
        /* Màu nền gradient pastel cho các card */
        .bg-blue   { background: linear-gradient(135deg, #89f7fe, #66a6ff); }
        .bg-green  { background: linear-gradient(135deg, #e0ffe1, #a0f1d0); }
        .bg-purple { background: linear-gradient(135deg, #fbc2eb, #a6c1ee); }
        .bg-pink   { background: linear-gradient(135deg, #ffdde1, #ee9ca7); }
        .bg-orange { background: linear-gradient(135deg, #fda085, #f6d365); }
        .bg-yellow { background: linear-gradient(135deg, #fff9c4, #ffe082); }
    </style>
</head>
<body>
<div class="container mt-4">
    <!-- Sử dụng justify-content-center để căn giữa các mục -->
    <div class="row g-4 justify-content-center">
        <!-- Card Quản lý món ăn -->
        <div class="col-sm-6 col-md-4">
            <div class="dashboard-card bg-purple">
                <!-- Link stretched-link -->
                <a href="/manageFoods" class="stretched-link"></a>
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-utensils card-icon"></i>
                        <div class="card-title">Quản lý món ăn</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="/manageFoods" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card Quản lý đơn hàng -->
        <div class="col-sm-6 col-md-4">
            <div class="dashboard-card bg-pink">
                <!-- Link stretched-link -->
                <a href="/manageOrder" class="stretched-link"></a>
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-cart-shopping card-icon"></i>
                        <div class="card-title">Quản lý đơn hàng</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="/manageOrder" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card Thống kê doanh số -->
        <div class="col-sm-6 col-md-4">
            <div class="dashboard-card bg-blue">
                <!-- Link stretched-link -->
                <a href="/statistical" class="stretched-link"></a>
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-chart-line card-icon"></i>
                        <div class="card-title">Thống kê doanh số</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="/statistical" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card Mã giảm giá -->
        <div class="col-sm-6 col-md-4">
            <div class="dashboard-card bg-orange">
                <!-- Link stretched-link -->
                <a href="/manageCoupons" class="stretched-link"></a>
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-tags card-icon"></i>
                        <div class="card-title">Mã giảm giá</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="/manageCoupons" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card Thông tin cửa hàng -->
        <div class="col-sm-6 col-md-4">
            <div class="dashboard-card bg-green">
                <!-- Link stretched-link -->
                <a href="/manageStore?action=showInfoStore" class="stretched-link"></a>
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-store card-icon"></i>
                        <div class="card-title">Thông tin cửa hàng</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="/manageStore?action=showInfoStore" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card Xử lý khiếu nại -->
        <div class="col-sm-6 col-md-4">
            <div class="dashboard-card bg-yellow">
                <!-- Link stretched-link -->
                <a href="/manageComplaint" class="stretched-link"></a>
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-exclamation-circle card-icon"></i>
                        <div class="card-title">Xử lý khiếu nại</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="/manageComplaint" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
