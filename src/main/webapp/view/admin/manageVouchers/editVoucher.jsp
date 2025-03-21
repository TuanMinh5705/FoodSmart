<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sửa mã giảm giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center mb-4">
        <i class="bi bi-gift"></i> Sửa mã giảm giá
    </h2>

    <div class="card shadow">
        <div class="card-body">
            <form action="/manageVouchers?action=editVoucher" method="post" id="voucherForm">
                <input type="hidden" name="voucher_id" value="${voucher.voucher_id}">

                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-upc-scan"></i> Mã giảm giá</label>
                    <input type="text" class="form-control" name="voucher_code" value="${voucher.voucher_code}"
                           required pattern="^[A-Za-z][0-9]{4,10}$"
                           title="Mã voucher phải bắt đầu bằng chữ cái, theo sau là 4-10 số.">
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-percent"></i> Giá trị giảm giá (%)</label>
                    <input type="number" class="form-control" name="discount_value" value="${voucher.discount_value}"
                           min="1" max="100" required>
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

                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-stack"></i> Số lượng</label>
                    <input type="number" class="form-control" name="quantity" value="${voucher.quantity}"
                           min="1" required>
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-file-text"></i> Mô tả</label>
                    <textarea class="form-control" name="description" rows="4" required>${voucher.description}</textarea>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Cập nhật
                    </button>
                    <a href="/manageVouchers" class="btn btn-danger ms-3">
                        <i class="bi bi-x-circle"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('voucherForm').addEventListener('submit', function(event) {
        const startDate = new Date(document.getElementsByName('start_date')[0].value);
        const endDate = new Date(document.getElementsByName('end_date')[0].value);

        if (endDate < startDate) {
            event.preventDefault();
            alert("Ngày kết thúc phải sau ngày bắt đầu.");
        }
    });
</script>

</body>
</html>
