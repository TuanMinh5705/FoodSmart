<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>

<body class="bg-light">
<div class="container mt-4">
    <h2 class="text-center mb-4 text-primary">Quản lý cửa hàng</h2>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="btn-group">
            <button class="btn btn-outline-primary">Danh sách đăng ký cửa hàng</button>
        </div>
        <form method="post" action="/manageMerchants?action=searchWithNameMerchant" id="searchForm" class="d-flex">
            <input name="keyword" type="text" class="form-control me-2" placeholder="Tìm kiếm..." value="${searchKeyword}" oninput="startTimer()">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-search"></i> <!-- Icon tìm kiếm mới -->
            </button>
        </form>
        <a href="/manageMerchants?action=addMerchantForm" class="btn btn-success">
            <i class="bi bi-plus-circle"></i> Thêm cửa hàng
        </a>
    </div>

    <div class="card shadow rounded">
        <div class="card-body">
            <table class="table table-hover table-bordered text-center">
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
                            <a href="/manageMerchants?action=updateMerchantForm&store_id=${merchant.store_id}" class="btn btn-warning btn-sm">
                                <i class="bi bi-pencil-square"></i> Sửa
                            </a>
                            <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}" class="btn btn-info btn-sm">
                                <i class="bi bi-info-circle"></i> Chi tiết
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let searchTimeout;
    function startTimer() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 5000);
    }
</script>
</body>
</html>
