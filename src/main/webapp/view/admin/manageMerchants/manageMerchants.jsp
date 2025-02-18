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
<<<<<<< HEAD
<body>
<div>
    <button>danh sach dang ki</button>
    <button>danh sach dang ki</button>
    <button>danh sach dang ki</button>
</div>
<div>
    <table border="1">
        <tr>
            <td>#</td>
            <td>Tên cửa hàng</td>
            <td>Địa chỉ</td>
            <td>Số điện thoại</td>
            <td>Hành động</td>
        </tr>
        <c:forEach var="merchant" items="${merchantsList}" varStatus="status">
            <tr>
            <td>${status.index+1}</td>
            <td>
                ${merchant.store_name}
                    <c:choose>
                        <c:when test="${merchant.merchant_type}">
                            <i class="fas fa-check-circle" style="color: green;" title="Đang hoạt động"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-times-circle" style="color: red;" title="Đã bị khóa"></i>
                        </c:otherwise>
                    </c:choose>
            </td>
            <td>${merchant.store_address}</td>
            <td>${merchant.contact_number}</td>
            <td>
            <a href="/manageMerchants?action=addMerchantForm" class="btn btn-danger btn-sm">Add</a>
            <a href="/manageMerchants?action=editMerchantForm" class="btn btn-danger btn-sm">Sửa</a>
            <a href="#" class="btn btn-danger btn-sm">Chi tiết</a>
            </td>
=======
<body class="bg-light">
<div class="container mt-4">
    <!-- Page Title -->
    <h2 class="text-center mb-4 text-primary">Quản lý cửa hàng</h2>
>>>>>>> 37c573891ebe07e3f965c309e58fd5d8ff81a792

    <!-- Actions Bar -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="btn-group">
            <button class="btn btn-outline-primary">Danh sách đăng ký cửa hàng</button>
        </div>

        <!-- Search Form -->
        <form method="post" action="/manageMerchants?action=searchWithNameMerchant" id="searchForm" class="d-flex">
            <input name="keyword" type="text" class="form-control me-2" placeholder="Tìm kiếm..."
                   value="${searchKeyword}" oninput="startTimer()">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> <!-- Search Icon -->
            </button>
        </form>

        <!-- Add Merchant Button -->
        <a href="/manageMerchants?action=addMerchantForm" class="btn btn-success">
            <i class="bi bi-plus-circle"></i> Thêm cửa hàng
        </a>
    </div>

    <!-- Filter Form with Icon -->
    <form method="get" action="/manageMerchants" id="filterForm" class="mb-4">
        <div class="row align-items-center">
            <div class="col-md-4 d-flex align-items-center">
                <button type="button" class="btn btn-outline-secondary dropdown-toggle" id="filterDropdown"
                        data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-filter"></i> Lọc trạng thái
                </button>
                <ul class="dropdown-menu" aria-labelledby="filterDropdown">
                    <li><a class="dropdown-item" href="#" onclick="setStatusFilter('')">Tất cả</a></li>
                    <li><a class="dropdown-item" href="#" onclick="setStatusFilter('active')">Hoạt động</a></li>
                    <li><a class="dropdown-item" href="#" onclick="setStatusFilter('locked')">Khóa tài khoản</a></li>
                </ul>
                <input type="hidden" name="status" id="status">
            </div>
        </div>
    </form>

    <!-- Merchant Table -->
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
                            <a href="/manageMerchants?action=updateMerchantForm&store_id=${merchant.store_id}"
                               class="btn btn-warning btn-sm">
                                <i class="bi bi-pencil-square"></i> Sửa
                            </a>
                            <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}"
                               class="btn btn-info btn-sm">
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

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let searchTimeout;

    function startTimer() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 5000);
    }

    function submitForm() {
        document.getElementById("filterForm").submit();
    }

    function setStatusFilter(statusValue) {
        document.getElementById("status").value = statusValue;
        submitForm();
    }
</script>
</body>
</html>
