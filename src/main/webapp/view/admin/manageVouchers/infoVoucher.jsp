<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Voucher</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<h2 class="text-center mb-4"><i class="fas fa-info-circle"></i> Chi Tiết Voucher</h2>

<div class="container mt-5 p-4 shadow rounded bg-light">
    <form action="/manageVouchers" method="post">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="voucher_code" class="form-label"><i class="bi bi-upc"></i> Mã Voucher:</label>
                <input type="text" class="form-control" id="voucher_code" name="voucher_code" value="${voucher.voucher_code}" readonly>
            </div>
            <div class="col-md-6 mb-3">
                <label for="discount_value" class="form-label"><i class="bi bi-percent"></i> Giá trị giảm giá (%):</label>
                <input type="number" class="form-control" id="discount_value" name="discount_value" value="${voucher.discount_value}" readonly>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="start_date" class="form-label"><i class="bi bi-calendar-event"></i> Ngày bắt đầu:</label>
                <input type="datetime-local" class="form-control" id="start_date" name="start_date" value="${voucher.start_date}" readonly>
            </div>
            <div class="col-md-6 mb-3">
                <label for="end_date" class="form-label"><i class="bi bi-calendar-check"></i> Ngày kết thúc:</label>
                <input type="datetime-local" class="form-control" id="end_date" name="end_date" value="${voucher.end_date}" readonly>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="start_time" class="form-label"><i class="bi bi-clock"></i> Thời gian bắt đầu:</label>
                <input type="time" class="form-control" id="start_time" name="start_time" value="${voucher.start_time}" readonly>
            </div>
            <div class="col-md-6 mb-3">
                <label for="end_time" class="form-label"><i class="bi bi-clock-history"></i> Thời gian kết thúc:</label>
                <input type="time" class="form-control" id="end_time" name="end_time" value="${voucher.end_time}" readonly>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="quantity" class="form-label"><i class="bi bi-archive"></i> Số lượng:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" value="${voucher.quantity}" readonly>
            </div>
            <div class="col-md-6 mb-3">
                <label for="description" class="form-label"><i class="bi bi-card-text"></i> Mô tả:</label>
                <textarea class="form-control" id="description" name="description" rows="3" readonly>${voucher.description}</textarea>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="/manageVouchers" class="btn btn-secondary"><i class="bi bi-arrow-left-circle"></i> Quay lại</a>
        </div>
    </form>
</div>

</body>
</html>
