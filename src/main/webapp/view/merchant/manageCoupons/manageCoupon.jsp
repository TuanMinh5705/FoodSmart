<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý mã giảm giá - VIP Pro</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --primary-color: #6a11cb;
            --secondary-color: #2575fc;
            --primary-gradient: linear-gradient(90deg, #8E2DE2, #4A00E0);
            --secondary-gradient: linear-gradient(90deg, #ff512f, #dd2476);
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .custom-container {
            max-width: 800px;
            margin: auto;
            padding: 2rem 1rem;
        }
        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            background: #fff;
            animation: fadeInUp 1s ease;
            margin-bottom: 2rem;
        }
        .card-header {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            color: #fff;
            text-align: center;
            padding: 1.8rem;
            font-size: 2rem;
            font-weight: 700;
            position: relative;
        }
        .card-header::after {
            content: "";
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 50%;
            height: 4px;
            background: #fff;
            border-radius: 2px;
        }
        .card-body {
            padding: 2rem;
        }
        .btn-sm {
            padding: 0.35rem 0.75rem !important;
            font-size: 0.85rem !important;
            border-radius: 25px !important;
        }
        .input-group .form-control {
            border-radius: 50px 0 0 50px;
            border-right: none;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .input-group .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 8px rgba(37,117,252,0.5);
        }

        .btn-search {
            border-radius: 0 50px 50px 0;
            background: var(--primary-gradient);
            border: none;
            padding: 0.35rem 0.75rem;
            font-size: 0.85rem;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-search:hover {
            box-shadow: 0 8px 20px rgba(142,45,226,0.4);
        }
        .btn-primary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: var(--primary-gradient);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(142,45,226,0.4);
        }
        .btn-secondary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: var(--secondary-gradient);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
            color: #fff;
        }
        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255,65,108,0.4);
        }
        .table thead {
            background: var(--primary-gradient);
            color: #fff;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="container my-4 custom-container">
    <div class="card">
        <div class="card-header">
            Quản lý mã giảm giá
        </div>
        <div class="card-body">
            <div class="row mb-4">
                <div class="col-md-4 mb-3 mb-md-0">
                    <a href="/manageCoupons?action=addCouponForm" class="btn btn-primary btn-sm">
                        <i class="fas fa-plus me-2"></i> Thêm mã giảm giá
                    </a>
                </div>
                <div class="col-md-8">
                    <form action="/manageCoupons?action=searchCoupon" method="post" id="searchForm">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Tìm kiếm mã giảm giá" name="keyword" onkeyup="startTimer()">
                            <button class="btn btn-search" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" id="voucherTable">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã giảm giá</th>
                        <th>Giá trị (%)</th>
                        <th>Số lượng</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="coupon" items="${couponList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${coupon.coupon_code}</td>
                            <td>${coupon.discount_value}%</td>
                            <td>${coupon.quantity}</td>
                            <td>
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="/manageCoupons?action=editCouponForm&coupon_id=${coupon.coupon_id}" class="btn btn-primary btn-sm" title="Chỉnh sửa">
                                        <i class="fas fa-pencil-alt"></i>
                                    </a>
                                    <a href="/manageCoupons?action=infoCouponForm&coupon_id=${coupon.coupon_id}" class="btn btn-secondary btn-sm" title="Chi tiết">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>