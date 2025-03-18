<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin chi tiết đối tác vận chuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="fas fa-info-circle"></i> Thông tin chi
    </h2>
    <div class="card shadow p-4">
        <table class="table table-bordered">
            <tbody>
            <tr>
                <th style="width: 30%;">Mã đối tác</th>
                <td>${carrier.carrier_id}</td>
            </tr>
            <tr>
                <th>Tên đối tác</th>
                <td>${carrier.carrier_name}</td>
            </tr>
            <tr>
                <th>Số điện thoại</th>
                <td>${carrier.contact_phone}</td>
            </tr>
            <tr>
                <th>Chi phí vận chuyển</th>
                <td><fmt:formatNumber value="${carrier.shipping_cost}" pattern="#,###"/>đ</td>
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
