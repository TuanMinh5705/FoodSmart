<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.foodSmart.model.admin.Carrier" %>

<html>
<head>
    <title>Cập nhật thông tin đối tác vận chuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Cập nhật thông tin đối tác vận chuyển</h4>
        </div>
        <div class="card-body">
            <form action="manageCarriers?action=editCarrier" method="post">
                <input type="hidden" name="carrierId" value="${carrier.carrier_id}">

                <div class="mb-3">
                    <label for="name" class="form-label">Tên đối tác</label>
                    <input type="text" class="form-control" id="name" name="name"
                           value="${carrier.carrier_name}" required
                           placeholder="Nhập tên đối tác vận chuyển"
                           pattern="^[\p{L}\s]+$"
                           title="Tên chỉ được chứa chữ cái và khoảng trắng">
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="phone" name="phone"
                           value="${carrier.contact_phone}" required
                           placeholder="Nhập số điện thoại (10-11 số)"
                           pattern="^0\d{9,10}$"
                           title="Số điện thoại phải bắt đầu bằng 0 và có từ 10 đến 11 số">
                </div>

                <div class="mb-3">
                    <label for="cost" class="form-label">Chi phí vận chuyển (VNĐ)</label>
                    <input type="number" class="form-control" id="cost" name="cost"
                           value="${carrier.shipping_cost}" required
                           placeholder="Nhập chi phí (VD: 50000 VNĐ)"
                           min="1000"
                           step="1000"
                           title="Chi phí phải là số nguyên dương, tối thiểu 1.000 VNĐ">
                </div>

                <div class="d-flex justify-content-between">
                    <a href="manageCarriers" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
