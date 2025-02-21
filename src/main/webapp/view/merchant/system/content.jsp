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
            border-top: 1px solid #ddd;
            margin: 10px 0;
        }
        .detail-link {
            font-weight: bold;
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .detail-link:hover {
            color: #45a049;
        }
        .row.g-4 {
            margin-bottom: 30px;
        }
        /* Màu nền pastel cho các card */
        .bg-blue   { background-color: #B3E5FC; }
        .bg-green  { background-color: #C8E6C9; }
        .bg-purple { background-color: #E1BEE7; }
        .bg-pink   { background-color: #F8BBD0; }
        .bg-orange { background-color: #FFCCBC; }
        .bg-yellow { background-color: #FFF9C4; }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="row g-4">
        <div class="col-md-6">
            <div class="dashboard-card bg-purple">
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

        <div class="col-md-6">
            <div class="dashboard-card bg-pink">
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-cart-shopping card-icon"></i>
                        <div class="card-title">Quản lý đơn hàng</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="#" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="dashboard-card bg-blue">
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-chart-line card-icon"></i>
                        <div class="card-title">Thống kê doanh số</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="#" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="dashboard-card bg-orange">
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

        <div class="col-md-6">
            <div class="dashboard-card bg-green">
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-store card-icon"></i>
                        <div class="card-title">Thông tin cửa hàng</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="#" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="dashboard-card bg-yellow">
                <div class="card-body text-center">
                    <div class="card-content">
                        <i class="fa fa-exclamation-circle card-icon"></i>
                        <div class="card-title">Xử lý khiếu nại</div>
                    </div>
                    <div>
                        <div class="divider"></div>
                        <a href="#" class="detail-link">Chi tiết</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
