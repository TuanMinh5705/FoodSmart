<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidebar</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style>
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

        @media (max-width: 901px) {
            .sidebar {
                transform: translateX(-250px);
            }
        }

        .sidebar.active {
            transform: translateX(0);
        }

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
            display: none;
        }

        .nav-item .submenu {
            display: none;
            padding-left: 20px;
        }

        .nav-item.active .submenu {
            display: block;
        }

        .sidebar .nav-link {
            color: white !important;
            cursor: pointer;
        }

        .sidebar .nav-link:hover {
            color: #4e9efa !important;
        }

        /* Bỏ chấm của thẻ li */
        ul.nav li {
            list-style: none;
        }
    </style>
</head>
<body>

<button class="menu-btn" onclick="toggleSidebar()">☰</button>

<div class="sidebar" id="sidebar">
    <div class="text-center mb-3">
        <a href="/view/merchant/homeMerchant.jsp">
            <img src="../../../imageDefault/logo1.png" alt="Logo" style="height: 100px;">
        </a>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link" href="/view/merchant/homeMerchant.jsp"><i class="fas fa-home"></i> Trang chủ</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="fas fa-utensils"></i> Món ăn <i class="fas fa-chevron-down float-right"></i></a>
            <ul class="submenu">
                <li><a class="nav-link" href="/manageFoods?action=addFoodForm">Thêm món ăn</a></li>
                <li><a class="nav-link" href="/manageFoods">Danh sách món ăn</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="fas fa-shopping-cart"></i> Đơn hàng <i class="fas fa-chevron-down float-right"></i></a>
            <ul class="submenu">
                <li><a class="nav-link" href="#"> Thêm đơn hàng</a></li>
                <li><a class="nav-link" href="/manageOrder"> Danh sách đơn hàng</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="fas fa-tags"></i> Mã giảm giá <i class="fas fa-chevron-down float-right"></i></a>
            <ul class="submenu">
                <li><a class="nav-link" href="/manageCoupons?action=addCouponForm"> Thêm mã giảm giá</a></li>
                <li><a class="nav-link" href="/manageCoupons"> Danh sách mã giảm giá</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/statistical"><i class="fas fa-chart-bar"></i> Thống kê doanh số</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/manageStore?action=showInfoStore"><i class="fas fa-store"></i> Thông tin cửa hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="fas fa-exclamation-circle"></i> Xử lý khiếu nại</a>
        </li>
    </ul>
</div>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("active");
    }

    $(document).ready(function() {
        $(".nav-item > .nav-link").click(function() {
            $(this).parent().toggleClass("active");
        });
    });
</script>
</body>
</html>
