<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sidebar</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
            overflow-y: auto;
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
        <a href="/view/admin/homeAdmin.jsp">
            <img src="../../../imageDefault/logo1.png" alt="Logo" style="height: 100px;">
        </a>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link" href="/view/admin/homeAdmin.jsp"><i class="fas fa-home"></i> Trang chủ</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-person-gear"></i> Tài khoản <i class="fas fa-chevron-down float-right"></i></a>
            <ul class="submenu">
                <li><a class="nav-link" href="/manageUsers?action=showAddAccountForm">Thêm tài khoản</a></li>
                <li><a class="nav-link" href="/manageUsers">Danh sách tài khoản</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-shop-window"></i> Cửa hàng <i class="fas fa-chevron-down float-right"></i></a>
            <ul class="submenu">
                <li><a class="nav-link" href="/manageMerchants?action=addMerchantForm"> Thêm cửa hàng</a></li>
                <li><a class="nav-link" href="/manageMerchants"> Danh sách cửa hàng</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-grid"></i> Danh mục sản phẩm <i class="fas fa-chevron-down float-right"></i></a>
            <ul class="submenu">
                <li><a class="nav-link" href="/manageCategoryFood?action=addForm"> Thêm danh mục sản phẩm</a></li>
                <li><a class="nav-link" href="/manageCategoryFood"> Danh sách danh mục</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-ticket-perforated"></i> Mã giảm giá<i class="fas fa-chevron-down float-right"></i></a>
            <ul class="submenu">
                <li><a class="nav-link" href="/manageVouchers?action=addVoucherForm"> Thêm mã giảm giá</a></li>
                <li><a class="nav-link" href="/manageVouchers"> Danh sách mã giảm giá</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/view/admin/homeAdmin.jsp?page=manageOrders"><i class="bi bi-clipboard-minus"></i> Quản lý đơn hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-truck"></i> Đối tác vận chuyển</a>
            <ul class="submenu">
                <li><a class="nav-link" href="/manageCarriers?action=addCarrierForm"> Thêm đối tác vận chuyển<i class="fas fa-chevron-down float-right"></i></a></li>
                <li><a class="nav-link" href="/manageCarriers"> Danh sách đối tác vận chuyển</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/view/admin/homeAdmin.jsp?page=revenueStatistics"><i class="bi bi-graph-up-arrow"></i> Thống kê doanh thu</a>
        </li>
        <li class="nav-item">
            <a class="nav-link"  href="/view/admin/homeAdmin.jsp?page=complaints"><i class="bi bi-exclamation-octagon"></i> Xử lý khiếu nại</a>
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
