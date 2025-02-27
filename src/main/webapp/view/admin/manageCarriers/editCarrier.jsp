<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.foodSmart.model.admin.Carrier" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật thông tin đối tác vận chuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="fas fa-edit"></i> Cập nhật thông tin đối tác vận chuyển
    </h2>
    <div class="card shadow p-4">
        <form action="manageCarriers?action=editCarrier" method="post">
            <input type="hidden" name="carrierId" value="${carrier.carrier_id}">

            <div class="mb-3">
                <label for="name" class="form-label">Tên đối tác</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-building"></i></span>
                    <input type="text" class="form-control" id="name" name="name"
                           value="${carrier.carrier_name}" required
                           placeholder="Nhập tên đối tác vận chuyển"
                           pattern="^[\p{L}\s]+$"
                           title="Tên chỉ được chứa chữ cái và khoảng trắng">
                </div>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                    <input type="text" class="form-control" id="phone" name="phone"
                           value="${carrier.contact_phone}" required
                           placeholder="Nhập số điện thoại (10-11 số)"
                           pattern="^0\d{9,10}$"
                           title="Số điện thoại phải bắt đầu bằng 0 và có từ 10 đến 11 số">
                </div>
            </div>

            <div class="mb-3">
                <label for="cost" class="form-label">Chi phí vận chuyển (VNĐ)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-currency-exchange"></i></span>
                    <input type="number" class="form-control" id="cost" name="cost"
                           value="${carrier.shipping_cost}" required
                           placeholder="Nhập chi phí (VD: 50000 VNĐ)"
                           min="1000" step="1000"
                           title="Chi phí phải là số nguyên dương, tối thiểu 1.000 VNĐ">
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i> Lưu thay đổi
                </button>
                <a href="manageCarriers" class="btn btn-danger">
                    <i class="bi bi-x-circle"></i> Hủy
                </a>
            </div>

        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
