<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Thông Tin Voucher</title>
    <!-- Thêm Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thêm Font Awesome cho icon -->
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

        .form-group .form-control {
            padding-left: 30px;
        }

        .alert {
            display: none;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center">Sửa Thông Tin Voucher <i class="fas fa-gift"></i></h2>
    <form action="/manageVouchers?action=editVoucher" method="post" id="voucherForm">
        <input type="hidden" name="voucher_id" value="${voucher.voucher_id}">

        <!-- Mã Voucher -->
        <div class="form-group">
            <label for="voucher_code"><i class="fas fa-barcode"></i> Mã Voucher:</label>
            <input type="text" class="form-control" id="voucher_code" name="voucher_code" value="${voucher.voucher_code}" placeholder="Nhập mã voucher (Ví dụ: A0001)" pattern="^[A-Za-z][0-9]{4,10}$" title="Mã voucher phải bắt đầu bằng một chữ cái và theo sau là từ 4 đến 10 chữ số." required >
        </div>

        <!-- Giá trị giảm giá -->
        <div class="form-group">
            <label for="discount_value"><i class="fas fa-percent"></i> Giá trị giảm giá (%):</label>
            <input type="number" class="form-control" id="discount_value" name="discount_value" value="${voucher.discount_value}" min="1" max="100" placeholder="Nhập giá trị giảm giá" required>
        </div>

        <!-- Ngày bắt đầu -->
        <div class="form-group">
            <label for="start_date"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu:</label>
            <input type="datetime-local" class="form-control" id="start_date" name="start_date" value="${voucher.start_date}" required>
        </div>

        <!-- Ngày kết thúc -->
        <div class="form-group">
            <label for="end_date"><i class="fas fa-calendar-check"></i> Ngày kết thúc:</label>
            <input type="datetime-local" class="form-control" id="end_date" name="end_date" value="${voucher.end_date}" required>
        </div>

        <!-- Thời gian bắt đầu -->
        <div class="form-group">
            <label for="start_time"><i class="fas fa-clock"></i> Thời gian bắt đầu:</label>
            <input type="time" class="form-control" id="start_time" name="start_time" value="${voucher.start_time}" required>
        </div>

        <!-- Thời gian kết thúc -->
        <div class="form-group">
            <label for="end_time"><i class="fas fa-clock"></i> Thời gian kết thúc:</label>
            <input type="time" class="form-control" id="end_time" name="end_time" value="${voucher.end_time}" required>
        </div>

        <!-- Số lượng -->
        <div class="form-group">
            <label for="quantity"><i class="fas fa-cogs"></i> Số lượng:</label>
            <input type="number" class="form-control" id="quantity" name="quantity" value="${voucher.quantity}" min="1" placeholder="Nhập số lượng voucher" required>
        </div>

        <!-- Mô tả -->
        <div class="form-group">
            <label for="description"><i class="fas fa-align-left"></i> Mô tả:</label>
            <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập mô tả voucher">${voucher.description}</textarea>
        </div>

        <!-- Nút submit -->
        <div class="form-group text-center">
            <button type="submit" class="btn btn-primary">Cập nhật Voucher <i class="fas fa-save"></i></button>
        </div>
    </form>
</div>

<!-- Thêm Bootstrap JS và jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Kiểm tra thời gian kết thúc > thời gian bắt đầu
    document.getElementById('voucherForm').addEventListener('submit', function(event) {
        const start_date = new Date(document.getElementById('start_date').value);
        const end_date = new Date(document.getElementById('end_date').value);
        const start_time = document.getElementById('start_time').value.split(':');
        const end_time = document.getElementById('end_time').value.split(':');

        // Kiểm tra ngày kết thúc > ngày bắt đầu
        if (end_date < start_date) {
            alert("Ngày kết thúc phải sau ngày bắt đầu.");
            event.preventDefault();
            return;
        }

        // Kiểm tra thời gian kết thúc > thời gian bắt đầu
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
