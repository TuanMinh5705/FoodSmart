<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm Voucher</title>
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        /* Định nghĩa biến cho background */
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        /* Định dạng toàn cục cho body */
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            min-height: 100vh;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }
        /* Container chứa form */
        .custom-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 15px;
        }
        /* Style cho thẻ card chứa form */
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
        /* Style cho header của card */
        .card-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .card-header h2 {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
            color: #333;
        }
        /* Style cho nhãn và input trong form */
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
        /* Style cho các nút */
        .btn-primary {
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            border: none;
            color: #fff;
            transition: background 0.3s, box-shadow 0.3s, color 0.3s;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #1672c4, #2988d5);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
            color: #fff;
        }
        .btn-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            border: none;
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s, box-shadow 0.3s, color 0.3s;
        }
        .btn-back:hover {
            background: linear-gradient(90deg, #d74a4a, #da5f5f);
            box-shadow: 0 8px 20px rgba(234, 177, 177, 0.8);
            color: #fff;
        }
        /* Hiệu ứng phóng to chỉ cho chữ trong các nút */
        .btn-primary .btn-text,
        .btn-back .btn-text {
            display: inline-block;
            transition: transform 0.3s ease-in-out;
        }
        .btn-primary:hover .btn-text,
        .btn-back:hover .btn-text {
            transform: scale(1.2);
        }
    </style>
</head>
<body>

<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2>Thêm Voucher</h2>
        </div>

        <form action="/manageCoupons?action=addCoupon" method="post">
            <input type="hidden" name="store_id" value="${store_id}">
            <div class="mb-3">
                <label for="coupon_code" class="form-label"><i class="fas fa-barcode"></i> Mã Voucher</label>
                <input type="text" class="form-control" id="coupon_code" name="coupon_code"
                       placeholder="Nhập mã voucher" pattern="^[A-Za-z][0-9]{4,10}$"
                       title="Mã voucher phải bắt đầu bằng một chữ cái và theo sau là từ 4 đến 10 chữ số. Ví dụ: A0001"
                       required>
                <span id="voucher_error" class="text-danger mt-2"></span>
            </div>
            <c:if test="${not empty couponList}">
                <script>
                    const existingCoupons = [
                        <c:forEach var="coupon" items="${couponList}">
                        "${coupon.coupon_code}",
                        </c:forEach>
                    ];
                    document.getElementById('coupon_code').addEventListener('input', function() {
                        const couponCode = this.value.trim();
                        const voucherError = document.getElementById('voucher_error');
                        if (existingCoupons.includes(couponCode)) {
                            voucherError.textContent = 'Mã voucher đã tồn tại.';
                        } else {
                            voucherError.textContent = '';
                        }
                    });
                </script>
            </c:if>
            <div class="mb-3">
                <label for="discount_value" class="form-label"><i class="fas fa-percent"></i> Giá trị giảm giá</label>
                <input type="number" class="form-control" id="discount_value" name="discount_value"
                       placeholder="Nhập giá trị giảm giá" min="1" max="99" required>
            </div>
            <div class="mb-3">
                <label for="start_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu</label>
                <input type="date" class="form-control" id="start_date" name="start_date" required>
            </div>
            <div class="mb-3">
                <label for="end_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày kết thúc</label>
                <input type="date" class="form-control" id="end_date" name="end_date" required>
            </div>
            <div class="mb-3">
                <label for="start_time" class="form-label"><i class="fas fa-clock"></i> Thời gian bắt đầu</label>
                <input type="time" class="form-control" id="start_time" name="start_time" required>
            </div>
            <div class="mb-3">
                <label for="end_time" class="form-label"><i class="fas fa-clock"></i> Thời gian kết thúc</label>
                <input type="time" class="form-control" id="end_time" name="end_time" required>
            </div>
            <div class="mb-3">
                <label for="quantity" class="form-label"><i class="fas fa-cogs"></i> Số lượng</label>
                <input type="number" class="form-control" id="quantity" name="quantity"
                       placeholder="Nhập số lượng voucher" min="1" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label"><i class="fas fa-info-circle"></i> Mô tả</label>
                <textarea class="form-control" id="description" name="description" rows="3"
                          placeholder="Nhập mô tả voucher"></textarea>
            </div>
            <div class="text-center">
                <button type="submit" class="btn-primary me-3">
                    <span class="btn-text"><i class="fas fa-plus-circle"></i> Thêm Voucher</span>
                </button>
                <button type="button" class="btn-back" onclick="window.location.href='/manageCoupons';">
                    <span class="btn-text"><i class="fas fa-times"></i> Huỷ</span>
                </button>
            </div>
        </form>
    </div>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
