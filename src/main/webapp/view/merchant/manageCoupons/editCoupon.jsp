<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sửa Thông Tin Coupon</title>
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .custom-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 15px;
        }
        .profile-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 2rem 2rem 3rem;
            animation: fadeInUp 1s ease;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .card-header h2 {
            margin: 0;
            color: #333;
        }
        .form-label {
            font-weight: 600;
            color: #555;
        }
        .form-control {
            border-radius: 50px;
            border: 1px solid #ddd;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            border-color: #607d8b;
            box-shadow: 0 0 8px rgba(96, 125, 139, 0.2);
        }
        .btn-primary {
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            border: none;
            color: #fff;
            transition: background 0.3s, transform 0.3s, box-shadow 0.3s, color 0.3s;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #1E88E5, #2a9ffc);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
            color: #000;
        }
        .btn-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            border: none;
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s, color 0.3s;
        }
        .btn-back:hover {
            background: linear-gradient(90deg, #f55d5d, #f67272);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(234, 177, 177, 0.8);
            color: #000;
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2>Sửa Thông Tin Coupon <i class="fas fa-gift"></i></h2>
        </div>
        <form action="/manageCoupons?action=editCoupon" method="post" id="couponForm">
            <input type="hidden" name="coupon_id" value="${coupon.coupon_id}">

            <div class="mb-3">
                <label for="coupon_code" class="form-label"><i class="fas fa-barcode"></i> Mã Coupon:</label>
                <input type="text" class="form-control" id="coupon_code" name="coupon_code" value="${coupon.coupon_code}"
                       placeholder="Nhập mã coupon" pattern="^[A-Za-z][0-9]{4,10}$" required>
            </div>
            <div class="mb-3">
                <label for="discount_value" class="form-label"><i class="fas fa-percent"></i> Giá trị giảm giá (%):</label>
                <input type="number" class="form-control" id="discount_value" name="discount_value"
                       value="${coupon.discount_value}" min="1" max="100" required>
            </div>
            <div class="mb-3">
                <label for="start_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu:</label>
                <input type="date" class="form-control" id="start_date" name="start_date"
                       value="${coupon.start_date}" required>
            </div>
            <div class="mb-3">
                <label for="end_date" class="form-label"><i class="fas fa-calendar-check"></i> Ngày kết thúc:</label>
                <input type="date" class="form-control" id="end_date" name="end_date" value="${coupon.end_date}"
                       required>
            </div>
            <div class="mb-3">
                <label for="start_time" class="form-label"><i class="fas fa-clock"></i> Thời gian bắt đầu:</label>
                <input type="time" class="form-control" id="start_time" name="start_time" value="${coupon.start_time}"
                       required>
            </div>
            <div class="mb-3">
                <label for="end_time" class="form-label"><i class="fas fa-clock"></i> Thời gian kết thúc:</label>
                <input type="time" class="form-control" id="end_time" name="end_time" value="${coupon.end_time}" required>
            </div>
            <div class="mb-3">
                <label for="quantity" class="form-label"><i class="fas fa-cogs"></i> Số lượng:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" value="${coupon.quantity}" min="1"
                       required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label"><i class="fas fa-align-left"></i> Mô tả:</label>
                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập mô tả">${coupon.description}</textarea>
            </div>
            <div class="d-flex justify-content-center gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Cập nhật Coupon
                </button>
                <button type="button" class="btn-back" onclick="window.location.href='/manageCoupons';">
                    <i class="fas fa-times"></i> Huỷ
                </button>
            </div>
        </form>
    </div>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('couponForm').addEventListener('submit', function (event) {
        const start_date = new Date(document.getElementById('start_date').value);
        const end_date = new Date(document.getElementById('end_date').value);
        const start_time = document.getElementById('start_time').value.split(':');
        const end_time = document.getElementById('end_time').value.split(':');

        if (end_date < start_date) {
            alert("Ngày kết thúc phải sau ngày bắt đầu.");
            event.preventDefault();
            return;
        }

        if (start_date.toDateString() === end_date.toDateString()) {
            if (parseInt(end_time[0]) < parseInt(start_time[0]) ||
                (parseInt(end_time[0]) === parseInt(start_time[0]) && parseInt(end_time[1]) <= parseInt(start_time[1]))) {
                alert("Thời gian kết thúc phải sau thời gian bắt đầu.");
                event.preventDefault();
                return;
            }
        }
    });
</script>
</body>
</html>
