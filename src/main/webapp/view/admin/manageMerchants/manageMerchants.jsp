<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">

<div class="container mt-5 p-4 bg-white shadow rounded">
    <h2 class="text-center text-primary mb-4">Quản lý cửa hàng</h2>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <form method="post" action="/manageMerchants?action=searchWithNameMerchant" class="d-flex" style="width: 40%;">
            <input name="keyword" type="text" class="form-control me-2" placeholder="Tìm kiếm..." value="${searchKeyword}" style="width: 70%;">
            <button type="submit" class="btn btn-primary btn-sm"><i class="fas fa-search"></i></button>
        </form>
        <a href="/manageMerchants?action=addMerchantForm" class="btn btn-success btn-sm"><i class="fas fa-plus"></i> Thêm cửa hàng</a>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th class="text-center">STT</th>
                <th>Tên cửa hàng</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th class="text-center">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="merchant" items="${merchantsList}" varStatus="status">
                <tr>
                    <td class="text-center">${status.index + 1}</td>
                    <td>${merchant.store_name}</td>
                    <td>${merchant.store_address}</td>
                    <td>${merchant.contact_number}</td>
                    <td class="text-center">
                        <a href="/manageMerchants?action=updateMerchantForm&store_id=${merchant.store_id}" class="btn btn-warning btn-sm me-1"><i class="fas fa-edit"></i></a>
                        <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}" class="btn btn-info btn-sm"><i class="fas fa-info-circle"></i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
