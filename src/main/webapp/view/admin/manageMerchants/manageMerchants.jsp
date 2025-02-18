<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2 class="text-center mb-4">Quản lý cửa hàng</h2>

    <div class="d-flex justify-content-between mb-3">
        <div>
            <button class="btn btn-primary">Danh sách đăng ký</button>
            <button class="btn btn-primary">Danh sách đăng ký</button>
            <button class="btn btn-primary">Danh sách đăng ký</button>
        </div>
        <a href="/manageMerchants?action=addMerchantForm" class="btn btn-danger">Thêm cửa hàng</a>
    </div>

    <div class="card shadow">
        <div class="card-body">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Tên cửa hàng</th>
                    <th>Địa chỉ</th>
                    <th>Số điện thoại</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="merchant" items="${merchantsList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${merchant.store_name}</td>
                        <td>${merchant.store_address}</td>
                        <td>${merchant.contact_number}</td>
                        <td>
                            <a href="/manageMerchants?action=updateMerchantForm&store_id=${merchant.store_id}"
                               class="btn btn-warning btn-sm">Sửa</a>
                            <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}" class="btn btn-info btn-sm">Chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
