<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidebar</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* Sidebar mặc định */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
            transition: transform 0.3s ease-in-out;
            z-index: 1040;
        }

        /* Khi màn hình >900px thì sidebar tự động ẩn */
        @media (max-width: 901px) {
            .sidebar {
                transform: translateX(-250px);
            }
        }

        /* Khi sidebar mở */
        .sidebar.active {
            transform: translateX(0);
        }

        /* Nút menu khi thu nhỏ */
        .menu-btn {
            position: fixed;
            top: 15px;
            left: 15px;
            background-color: #343a40;
            color: white;
            border: none;
            font-size: 24px;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            z-index: 1050;
        }
    </style>
</head>
<body>

<!-- Nút mở sidebar -->
<button class="menu-btn" onclick="toggleSidebar()">☰</button>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="text-center mb-3">
        <a href="/view/admin/homeAdmin.jsp">
            <img src="../../../images/icon_default/system/tiktok.png" alt="Logo" style="height: 40px;">
        </a>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp"><i class="fas fa-home"></i> Trang chủ</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageMerchants"><i class="fas fa-store"></i> Quản lý cửa hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/manageUsers"><i class="fas fa-user-cog"></i> Quản lý người dùng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageVouchers"><i class="fas fa-tags"></i> Mã giảm giá</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=manageOrders"><i class="fas fa-shopping-cart"></i> Quản lý đơn hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/manageCarriers"><i class="fas fa-shipping-fast"></i> Đối tác vận chuyển</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=revenueStatistics"><i class="fas fa-chart-line"></i> Thống kê doanh thu</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="/view/admin/homeAdmin.jsp?page=complaints"><i class="fas fa-exclamation-circle"></i> Xử lý khiếu nại</a>
        </li>
    </ul>
</div>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("active");
    }
</script>

</body>
</html>
