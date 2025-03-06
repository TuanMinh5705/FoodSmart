<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Thông Tin Coupon</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h2 {
            color: #4CAF50;
            font-weight: bold;
        }

        .form-group label {
            font-weight: bold;
            color: #555;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(0, 200, 0, 0.5);
        }

        .btn-primary {
            background-color: #4CAF50;
            border-color: #4CAF50;
        }

        .btn-primary:hover {
            background-color: #45a049;
            border-color: #45a049;
        }

        .form-group .fas {
            color: #4CAF50;
            margin-right: 10px;
        }

        .alert {
            display: none;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center">Sửa Thông Tin Coupon <i class="fas fa-gift"></i></h2>
    <form action="/manageCoupons?action=editCoupon" method="post" id="couponForm">
        <input type="hidden" name="coupon_id" value="${coupon.coupon_id}">

        <div class="form-group">
            <label for="coupon_code"><i class="fas fa-barcode"></i> Mã Coupon:</label>
            <input type="text" class="form-control" id="coupon_code" name="coupon_code" value="${coupon.coupon_code}"
                   placeholder="Nhập mã coupon" pattern="^[A-Za-z][0-9]{4,10}$" required>
        </div>

        <div class="form-group">
            <label for="discount_value"><i class="fas fa-percent"></i> Giá trị giảm giá (%):</label>
            <input type="number" class="form-control" id="discount_value" name="discount_value"
                   value="${coupon.discount_value}" min="1" max="100" required>
        </div>

        <div class="form-group">
            <label for="start_date"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu:</label>
            <input type="datetime-local" class="form-control" id="start_date" name="start_date"
                   value="${coupon.start_date}" required>
        </div>

        <div class="form-group">
            <label for="end_date"><i class="fas fa-calendar-check"></i> Ngày kết thúc:</label>
            <input type="datetime-local" class="form-control" id="end_date" name="end_date" value="${coupon.end_date}"
                   required>
        </div>

        <div class="form-group">
            <label for="start_time"><i class="fas fa-clock"></i> Thời gian bắt đầu:</label>
            <input type="time" class="form-control" id="start_time" name="start_time" value="${coupon.start_time}"
                   required>
        </div>

        <div class="form-group">
            <label for="end_time"><i class="fas fa-clock"></i> Thời gian kết thúc:</label>
            <input type="time" class="form-control" id="end_time" name="end_time" value="${coupon.end_time}" required>
        </div>

        <div class="form-group">
            <label for="quantity"><i class="fas fa-cogs"></i> Số lượng:</label>
            <input type="number" class="form-control" id="quantity" name="quantity" value="${coupon.quantity}" min="1"
                   required>
        </div>

        <div class="form-group">
            <label for="description"><i class="fas fa-align-left"></i> Mô tả:</label>
            <textarea class="form-control" id="description" name="description" rows="4">${coupon.description}</textarea>
        </div>

        <div class="d-flex justify-content-center gap-2">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Cập nhật Coupon
            </button>
            <a href="/manageCoupons" class="btn btn-secondary" style="margin-right: 10px;"> <!-- Thêm margin -->
                <i class="fas fa-arrow-left"></i> Huỷ
            </a>
        </div>
    </form>
</div>

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
