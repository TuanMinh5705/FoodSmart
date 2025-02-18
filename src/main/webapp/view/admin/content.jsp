<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        .card {
            color: white;
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
        }
        .card-body {
            padding: 30px;
        }
        .card-title {
            font-size: 22px;
            font-weight: bold;
        }
        .card-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }
        .detail-btn {
            display: block;
            padding: 10px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 0 0 15px 15px;
            text-align: center;
            font-weight: bold;
            transition: background 0.3s ease;
        }
        .detail-btn:hover {
            background: rgba(255, 255, 255, 0.4);
            text-decoration: none;
        }

        /* Màu Gradient */
        .bg-red { background: linear-gradient(135deg, #ff416c, #ff4b2b); }
        .bg-blue { background: linear-gradient(135deg, #36d1dc, #5b86e5); }
        .bg-green { background: linear-gradient(135deg, #56ab2f, #a8e063); }
    </style>
</head>
<body>

<div class="container mt-4">
    <div class="row g-4">
        <!-- Hàng đầu tiên -->
        <div class="col-md-4">
            <div class="card bg-red">
                <div class="card-body text-center">
                    <i class="bi bi-shop card-icon"></i>
                    <div class="card-title">Cửa hàng</div>
                </div>
                <a href="/manageMerchants" class="text-white detail-btn">Chi tiết</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-red">
                <div class="card-body text-center">
                    <i class="bi bi-tag card-icon"></i>
                    <div class="card-title"> Mã giảm giá</div>
                </div>
                <a href="#" class="text-white detail-btn">Chi tiết</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-red">
                <div class="card-body text-center">
                    <i class="bi bi-graph-up card-icon"></i>
                    <div class="card-title"> Báo cáo doanh thu</div>
                </div>
                <a href="#" class="text-white detail-btn">Chi tiết</a>
            </div>
        </div>

        <!-- Hàng thứ hai -->
        <div class="col-md-4">
            <div class="card bg-blue">
                <div class="card-body text-center">
                    <i class="bi bi-people card-icon"></i>
                    <div class="card-title"> Người dùng</div>
                </div>
                <a href="/manageUsers" class="text-white detail-btn">Chi tiết</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-blue">
                <div class="card-body text-center">
                    <i class="bi bi-truck card-icon"></i>
                    <div class="card-title"> Đối tác vận chuyển</div>
                </div>
                <a href="/manageCarriers" class="text-white detail-btn">Chi tiết</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-blue">
                <div class="card-body text-center">
                    <i class="bi bi-exclamation-circle card-icon"></i>
                    <div class="card-title">Khiếu nại</div>
                </div>
                <a href="#" class="text-white detail-btn">Chi tiết</a>
            </div>
        </div>

        <!-- Hàng thứ ba -->
        <div class="col-md-4 offset-md-4">
            <div class="card bg-green">
                <div class="card-body text-center">
                    <i class="bi bi-box-seam card-icon"></i>
                    <div class="card-title">Đơn hàng</div>
                </div>
                <a href="#" class="text-white detail-btn">Chi tiết</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
