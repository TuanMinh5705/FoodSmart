<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Sidebar Tài khoản -->
<!-- CSS cho Sidebar -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
    .sidebar {
        padding: 30px 20px;
        background: #ffffff;
        border-right: 1px solid #e0e0e0;
        min-height: 100vh;
        box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
    }
    .sidebar h4 {
        color: #34495e; /* Xám đậm mềm mại */
        margin-bottom: 30px;
        font-weight: 600;
        text-align: center;
    }
    .sidebar .nav {
        list-style: none;
        padding-left: 0;
    }
    .sidebar .nav-item {
        margin-bottom: 10px;
    }
    .sidebar .nav-link {
        font-weight: 500;
        padding: 12px 20px;
        border-radius: 8px;
        color: #7f8c8d;  /* Xám trung tính */
        transition: background 0.3s, color 0.3s;
        display: flex;
        align-items: center;
    }
    .sidebar .nav-link i {
        margin-right: 10px;
        font-size: 1.2rem;
    }
    .sidebar .nav-link:hover {
        background: #3498db;  /* Xanh pastel */
        color: #ffffff;
    }
    .sidebar .nav-link.text-danger:hover {
        background: #e74c3c !important;  /* Đỏ mềm mại */
        color: #ffffff !important;
    }

</style>
<div class="sidebar">
    <h4 class="text-center mb-4">Tài khoản</h4>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a href="/userInformation?action=showUserInformation" class="nav-link">
                <i class="fas fa-user-circle"></i> Thông tin tài khoản
            </a>
        </li>
        <li class="nav-item">
            <a href="/userInformation?action=showAddressUser" class="nav-link">
                <i class="fas fa-map-marker-alt"></i> Địa chỉ giao hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="/userInformation?action=showAddAddressForm" class="nav-link">
                <i class="fas fa-plus-square"></i> Thêm địa chỉ giao hàng
            </a>
        </li>

        <li class="nav-item">
            <a href="/authenticate?action=logout" class="nav-link text-danger">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>

