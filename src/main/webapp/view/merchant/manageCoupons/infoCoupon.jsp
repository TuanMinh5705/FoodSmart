<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi Tiết Voucher</title>
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

    .btn-secondary {
      background-color: #6c757d;
      border-color: #6c757d;
    }

    .btn-secondary:hover {
      background-color: #5a6268;
      border-color: #545b62;
    }

    .form-group .fas {
      color: #4CAF50;
      margin-right: 10px;
    }

    .form-group .form-control {
      padding-left: 30px;
    }
  </style>
</head>
<body>

<div class="container mt-5">
  <h2 class="text-center">Chi Tiết Voucher <i class="fas fa-gift"></i></h2>

  <!-- Form xem chi tiết voucher -->
  <form action="/manageCoupons?action=infoCoupon&coupon_id=${coupon.coupon_id}" method="post">
    <div class="form-group">
      <label for="coupon_code"><i class="fas fa-barcode"></i> Mã Voucher:</label>
      <input type="text" class="form-control" id="coupon_code" name="coupon_code" value="${coupon.coupon_code}" readonly>
    </div>

    <div class="form-group">
      <label for="discount_value"><i class="fas fa-percent"></i> Giá trị giảm giá (%):</label>
      <input type="number" class="form-control" id="discount_value" name="discount_value" value="${coupon.discount_value}" readonly>
    </div>

    <div class="form-group">
      <label for="start_date"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu:</label>
      <input type="datetime-local" class="form-control" id="start_date" name="start_date" value="${coupon.start_date}" readonly>
    </div>

    <div class="form-group">
      <label for="end_date"><i class="fas fa-calendar-check"></i> Ngày kết thúc:</label>
      <input type="datetime-local" class="form-control" id="end_date" name="end_date" value="${coupon.end_date}" readonly>
    </div>

    <div class="form-group">
      <label for="start_time"><i class="fas fa-clock"></i> Thời gian bắt đầu:</label>
      <input type="time" class="form-control" id="start_time" name="start_time" value="${coupon.start_time}" readonly>
    </div>

    <div class="form-group">
      <label for="end_time"><i class="fas fa-clock"></i> Thời gian kết thúc:</label>
      <input type="time" class="form-control" id="end_time" name="end_time" value="${coupon.end_time}" readonly>
    </div>

    <div class="form-group">
      <label for="quantity"><i class="fas fa-cogs"></i> Số lượng:</label>
      <input type="number" class="form-control" id="quantity" name="quantity" value="${coupon.quantity}" readonly>
    </div>

    <div class="form-group">
      <label for="description"><i class="fas fa-align-left"></i> Mô tả:</label>
      <textarea class="form-control" id="description" name="description" rows="4" readonly>${coupon.description}</textarea>
    </div>

    <!-- Nút quay lại -->
    <div class="form-group text-center">
      <a href="/manageCoupons" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
    </div>
  </form>
</div>

<!-- Thêm Bootstrap JS và jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
