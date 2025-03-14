<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin Tài khoản</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome cho icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        /* Sidebar styles */
        .sidebar {
            padding: 30px 20px;
            background: #ffffff;
            border-right: 1px solid #e0e0e0;
            min-height: 100vh;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
        }
        .sidebar h4 {
            color: #34495e;
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
            color: #7f8c8d;
            transition: background 0.3s, color 0.3s;
            display: flex;
            align-items: center;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        .sidebar .nav-link:hover {
            background: #3498db;
            color: #ffffff;
        }
        .sidebar .nav-link.text-danger:hover {
            background: #e74c3c !important;
            color: #ffffff !important;
        }

        /* Modal custom styles với hiệu ứng xuất hiện */
        .modal-content {
            border-radius: 10px;
            border: none;
            animation: modal-appear 0.5s ease-out;
            transform-origin: center center;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        @keyframes modal-appear {
            from {
                transform: scale(0.8);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }
        /* Hiệu ứng hover cho modal */
        .modal-content:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
        }
        .modal-header, .modal-footer {
            border: none;
        }
        .modal-title i {
            margin-right: 10px;
        }
        .modal-body p {
            font-size: 1.1rem;
        }
        .modal-footer a.btn, .modal-footer button.btn {
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .modal-footer a.btn:hover, .modal-footer button.btn:hover {
            transform: scale(1.05);
            opacity: 0.9;
        }
    </style>
</head>
<body>

<!-- Sidebar Tài khoản -->
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
                <i class="fas fa-map-marker-alt"></i> Thêm địa chỉ giao hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="/userInformation" class="nav-link">
                <i class="fas fa-wallet"></i> Ví điện tử
            </a>
        </li>
        <li class="nav-item">
            <!-- Khi click vào đây sẽ mở modal xác nhận đăng xuất -->
            <a href="#" class="nav-link text-danger" data-toggle="modal" data-target="#logoutModal">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>

<!-- Modal xác nhận đăng xuất -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">
                    <i class="fas fa-exclamation-triangle text-warning"></i> Xác nhận đăng xuất
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><i class="fas fa-info-circle text-info"></i> Bạn có chắc chắn muốn đăng xuất?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <a href="/authenticate?action=logout" class="btn btn-danger">Đăng xuất</a>
            </div>
        </div>
    </div>
</div>

<!-- Thêm Bootstrap JS, Popper.js và jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
