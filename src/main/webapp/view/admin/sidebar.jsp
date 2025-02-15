<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidebar</title>
</head>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<body>
<div class="bg-dark text-white"
     style="position: fixed; top: 56px; left: 0; width: 250px; height: 100%; padding-top: 20px;">
    <div class="text-center mb-3">
        <!-- Logo (nếu có) -->
        <img src="../../images/icon_default/system/tiktok.png" alt="Logo" style="height: 40px;">
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=home"><i class="fas fa-home"></i> Trang chủ</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageMerchants"><i class="fas fa-store"></i> Quản lý cửa hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageUsers"><i class="fas fa-user-cog"></i> Quản lý người dùng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageVouchers"><i class="fas fa-tags"></i> Mã giảm giá</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageOrders"><i class="fas fa-shopping-cart"></i> Quản lý đơn hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageCarriers"><i class="fas fa-shipping-fast"></i> Đối tác vận chuyển</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=revenueStatistics"><i class="fas fa-chart-line"></i> Thống kê doanh thu</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=complaints"><i class="fas fa-exclamation-circle"></i> Xử lý khiếu nại</a>
        </li>
    </ul>
</div>

</body>
</html>
