<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Thông Tin Tài Khoản</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <!-- Nhúng CSS trực tiếp -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #eef2f7;
            min-height: 100vh;
        }
        /* Sidebar styles */
        .sidebar {
            background-color: #fff;
            border-right: 1px solid #dee2e6;
            min-height: 100vh;
            padding: 20px;
        }
        .sidebar h4 {
            color: #5563DE;
            margin-bottom: 20px;
        }
        .sidebar .nav-link {
            color: #343a40;
            margin-bottom: 10px;
        }
        .sidebar .nav-link:hover {
            background-color: #f1f1f1;
            border-radius: 5px;
        }
        /* Card styles */
        .card-glass {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border: none;
            width: 100%;
        }
        .card-header-glass {
            background-color: #5563DE;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .card-header-glass h3 {
            color: #fff;
            margin: 0;
        }
        .btn-custom {
            background-color: #5563DE;
            border-color: #5563DE;
        }
        .btn-custom:hover {
            background-color: #4652b5;
            border-color: #4652b5;
        }
        /* Cập nhật giao diện ảnh đại diện giống trang Thông tin Tài Khoản */
        .avatar {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #2980b9;
        }
        @media (max-width: 768px) {
            .sidebar {
                min-height: auto;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar bên trái -->
        <div class="col-md-3">
            <jsp:include page="sidebarUser.jsp"/>
        </div>
        <!-- Nội dung chỉnh sửa thông tin bên phải -->
        <div class="col-md-9">
            <div class="d-flex justify-content-center align-items-center" style="min-height: 100vh;">
                <div class="col-12 col-lg-8">
                    <div class="card card-glass">
                        <div class="card-header card-header-glass text-center py-3">
                            <h3>Sửa Thông Tin Tài Khoản</h3>
                        </div>
                        <div class="card-body">
                            <form action="/userInformation?action=editInfoUser" method="post" enctype="multipart/form-data">
                                <!-- Ảnh đại diện -->
                                <div class="mb-4 text-center">
                                    <label class="form-label">Ảnh đại diện</label>
                                    <div class="d-flex flex-column align-items-center">
                                        <div class="mb-3">
                                            <c:if test="${not empty account.avtPath}">
                                                <img src="${pageContext.request.contextPath}/images/avatars/${account.avtPath}"
                                                     alt="Ảnh đại diện" class="avatar img-thumbnail mx-auto d-block object-fit-contain" id="avatarPreview">
                                            </c:if>
                                        </div>
                                        <div>
                                            <input type="hidden" name="currentAvtPath" value="${account.avtPath}">
                                            <!-- Ẩn input file và sử dụng button để chọn file -->
                                            <input type="file" class="d-none" name="avtPath" id="avt_path">
                                            <button type="button" class="btn btn-outline-secondary" id="chooseImageButton">
                                                <i class="bi bi-images"></i> Chỉnh sửa hình ảnh
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <!-- Tên đăng nhập -->
                                <div class="mb-4">
                                    <label class="form-label">Tên đăng nhập</label>
                                    <input type="text" class="form-control" name="username" value="${account.username}" required>
                                </div>
                                <!-- Mật khẩu -->
                                <div class="mb-4">
                                    <label class="form-label">Mật khẩu</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="passwordInput" name="password" value="${account.password}" required>
                                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                <!-- Trạng thái -->
                                <div class="mb-4">
                                    <label class="form-label d-block">Trạng thái</label>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" value="active" ${account.active ? 'checked' : ''}>
                                        <label class="form-check-label">Hoạt động</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" value="inactive" ${!account.active ? 'checked' : ''}>
                                        <label class="form-check-label">Khóa tài khoản</label>
                                    </div>
                                </div>
                                <!-- Nút hành động -->
                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-custom text-white px-4">Cập nhật</button>
                                    <a href="/userInformation?action=showUserInformation" class="btn btn-danger ms-3 px-4">Huỷ</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End nội dung chỉnh sửa thông tin -->
    </div>
</div>

<script>
    // Khi nhấn button "Chỉnh sửa hình ảnh", kích hoạt input file ẩn
    document.getElementById("chooseImageButton").addEventListener("click", function () {
        document.getElementById("avt_path").click();
    });

    // Preview ảnh đại diện khi chọn file mới
    document.getElementById("avt_path").addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const avatarPreview = document.getElementById("avatarPreview");
                if (avatarPreview) {
                    avatarPreview.src = e.target.result;
                }
            };
            reader.readAsDataURL(file);
        }
    });

    // Toggle hiển thị mật khẩu
    document.getElementById("togglePassword").addEventListener("click", function () {
        const passwordInput = document.getElementById("passwordInput");
        const icon = this.querySelector("i");
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            passwordInput.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    });
</script>
</body>
</html>
