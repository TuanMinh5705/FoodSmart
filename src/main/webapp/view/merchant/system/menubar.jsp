<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Menubar</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

    <style>
        /* Navbar cố định */
        .navbar {
            width: 100%;
            z-index: 1030;
            position: fixed;
            top: 0;
            left: 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Khoảng cách để không bị che mất nội dung */
        .content {
            margin-top: 80px;
        }

        /* Căn giữa modal */
        .modal-dialog-centered {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        /* Tùy chỉnh modal đẹp hơn */
        .custom-modal .modal-content {
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border: none;
        }

        /* Header gradient */
        .custom-modal .modal-header {
            background: linear-gradient(135deg, #4e73df, #6f42c1);
            color: white;
            border-top-left-radius: 16px;
            border-top-right-radius: 16px;
            padding: 20px;
        }

        /* Body căn giữa nội dung */
        .custom-modal .modal-body {
            padding: 30px;
            text-align: center;
            font-size: 18px;
        }

        /* Footer nền nhạt, nút căn giữa */
        .custom-modal .modal-footer {
            background-color: #f7f7f7;
            padding: 20px;
            border-top: 1px solid #e5e5e5;
            justify-content: center;
        }

        /* Nút hành động */
        .btn-cancel, .btn-logout {
            font-size: 1rem;
            min-width: 110px;
            margin: 0 10px;
            transition: background 0.3s, transform 0.3s;
            border: none;
        }

        .btn-cancel {
            background-color: #adb5bd;
            color: #fff;
            border-radius: 30px;
            padding: 8px 20px;
        }

        .btn-cancel:hover {
            background-color: #6c757d;
            transform: translateY(-2px);
        }

        .btn-logout {
            background-color: #e74c3c;
            color: #fff;
            border-radius: 30px;
            padding: 8px 20px;
        }

        .btn-logout:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
        }
    </style>
</head>

<body>

<!-- Kiểm tra nếu có người đăng nhập -->
<c:if test="${not empty sessionScope.loggedInAccount}">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarMain"
                aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link icon-btn" href="#">
                        <i class="fas fa-comments"></i> Trò chuyện
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link icon-btn" href="#">
                        <i class="fas fa-bell"></i> Thông báo
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-user"></i>
                        <c:out value="${sessionScope.loggedInAccount.username}" default="Merchant" />
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="/manageStore?action=showMerchantStore">Thông tin tài khoản</a>
                        <div class="dropdown-divider"></div>
                        <!-- Nút mở modal xác nhận -->
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>


    <!-- Modal xác nhận đăng xuất -->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content custom-modal">
                <div class="modal-header">
                    <h5 class="modal-title" id="logoutModalLabel">
                        <i class="fas fa-sign-out-alt"></i> Xác nhận đăng xuất
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn đăng xuất không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" data-dismiss="modal">
                        ❌ Hủy
                    </button>
                    <a href="/authenticate?action=logout" class="btn btn-logout">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<c:if test="${empty sessionScope.loggedInAccount}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({
                title: "Bạn chưa đăng nhập!",
                text: "Vui lòng đăng nhập để tiếp tục.",
                icon: "warning",
                confirmButtonText: "Đăng nhập ngay",
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "/authenticate?action=loginForm";
                }
            });
        });
    </script>
</c:if>


<!-- Script -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
