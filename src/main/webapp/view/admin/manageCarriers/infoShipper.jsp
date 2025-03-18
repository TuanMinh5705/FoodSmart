<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết nhân viên vận chuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="fas fa-info-circle"></i> Chi tiết nhân viên vận chuyển
    </h2>
    <div class="card shadow p-4">
        <table class="table table-bordered">
            <tbody>
            <tr>
                <th style="width: 30%;">Mã nhân viên vận chuyển</th>
                <td>${shipper.shipper_id}</td>
            </tr>
            <tr>
                <th>Tên nhân viên vận chuyển</th>
                <td>${shipper.shipper_name}</td>
            </tr>
            <tr>
                <th>Số điện thoại</th>
                <td>${shipper.phonenumber}</td>
            </tr>
            <tr>
                <th>Nhà vận chuyển</th>
                <td>${shipper.carrier_name}</td>
            </tr>
            </tbody>
        </table>
        <div class="d-flex justify-content-center gap-3 mt-4">
            <a href="manageCarriers" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Quay lại
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
