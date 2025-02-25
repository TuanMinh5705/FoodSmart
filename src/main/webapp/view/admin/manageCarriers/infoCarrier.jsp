<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Thông tin chi tiết đối tác vận chuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-info text-white">
            <h4 class="mb-0">Thông tin chi tiết đối tác vận chuyển</h4>
        </div>
        <div class="card-body">
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
                    <td>    <fmt:formatNumber value="${carrier.shipping_cost}" pattern="#,###" />đ</td>
                </tr>
                </tbody>
            </table>

            <div class="d-flex justify-content-center gap-2">
                <a href="manageCarriers" class="btn btn-secondary">Quay lại</a>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
