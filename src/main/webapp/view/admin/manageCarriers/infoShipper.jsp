<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết nhân viên vận chuyển</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Chi tiết nhân viên vận chuyển</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>Mã nhân viên vận chuyển</th>
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
            </table>
            <div class="d-flex justify-content-between">
                <a href="manageCarriers" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
