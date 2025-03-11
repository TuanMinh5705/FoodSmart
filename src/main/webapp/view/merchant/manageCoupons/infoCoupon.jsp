<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Chi Tiết Voucher</title>
  <!-- Google Fonts: Poppins -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <!-- Bootstrap 5.3 CSS -->
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
      padding-left: 1rem;
    }
    .form-control:focus {
      border-color: #607d8b;
      box-shadow: 0 0 8px rgba(96, 125, 139, 0.2);
    }
    .btn-back {
      background: linear-gradient(90deg, #f67272, #f55d5d);
      color: #fff;
      border: none;
      border-radius: 50px;
      padding: 0.5rem 1.5rem;
      font-size: 1rem;
      font-weight: 600;
      transition: background 0.3s, transform 0.3s, color 0.3s;
      text-decoration: none;
    }

    .btn-back:hover {
      background: linear-gradient(90deg, #f55d5d, #f67272);
      transform: translateY(-3px);
      text-decoration: none;
      box-shadow: 0 8px 20px rgba(234, 177, 177, 0.8);
      color: #000; /* Khi trỏ chuột, chuyển màu chữ thành đen */
    }

  </style>
</head>
<body>
<div class="container custom-container">
  <div class="profile-card">
    <div class="card-header">
      <h2>Chi Tiết Voucher <i class="fas fa-gift"></i></h2>
    </div>
    <!-- Form hiển thị thông tin voucher (chế độ readonly) -->
    <form action="/manageCoupons?action=infoCoupon&coupon_id=${coupon.coupon_id}" method="post">
      <div class="mb-3">
        <label for="coupon_code" class="form-label"><i class="fas fa-barcode"></i> Mã Voucher:</label>
        <input type="text" class="form-control" id="coupon_code" name="coupon_code" value="${coupon.coupon_code}" readonly>
      </div>
      <div class="mb-3">
        <label for="discount_value" class="form-label"><i class="fas fa-percent"></i> Giá trị giảm giá (%):</label>
        <input type="number" class="form-control" id="discount_value" name="discount_value" value="${coupon.discount_value}" readonly>
      </div>
      <div class="mb-3">
        <label for="start_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu:</label>
        <input type="date" class="form-control" id="start_date" name="start_date" value="${coupon.start_date}" readonly>
      </div>
      <div class="mb-3">
        <label for="end_date" class="form-label"><i class="fas fa-calendar-check"></i> Ngày kết thúc:</label>
        <input type="date" class="form-control" id="end_date" name="end_date" value="${coupon.end_date}" readonly>
      </div>
      <div class="mb-3">
        <label for="start_time" class="form-label"><i class="fas fa-clock"></i> Thời gian bắt đầu:</label>
        <input type="time" class="form-control" id="start_time" name="start_time" value="${coupon.start_time}" readonly>
      </div>
      <div class="mb-3">
        <label for="end_time" class="form-label"><i class="fas fa-clock"></i> Thời gian kết thúc:</label>
        <input type="time" class="form-control" id="end_time" name="end_time" value="${coupon.end_time}" readonly>
      </div>
      <div class="mb-3">
        <label for="quantity" class="form-label"><i class="fas fa-cogs"></i> Số lượng:</label>
        <input type="number" class="form-control" id="quantity" name="quantity" value="${coupon.quantity}" readonly>
      </div>
      <div class="mb-3">
        <label for="description" class="form-label"><i class="fas fa-align-left"></i> Mô tả:</label>
        <textarea class="form-control" id="description" name="description" rows="4" readonly>${coupon.description}</textarea>
      </div>
      <div class="text-center">
        <a href="/manageCoupons" class="btn-back">Quay lại</a>
      </div>
    </form>
  </div>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
