<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Thông Tin Tài Khoản</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
        }

        .card-glass {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .card-header-glass {
            background: rgba(85, 99, 222, 0.8);
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
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

        .form-label {
            font-weight: 500;
        }

        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
        }

        input[type="file"] {
            border: none;
            background: transparent;
            color: #fff;
        }
    </style>
</head>
<body>
<jsp:include page="sidebarUser.jsp"/>

<div class="container">
    <div class="min-vh-100 d-flex justify-content-center align-items-center">
        <div class="col-md-6">
            <div class="card card-glass p-4">
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
                                        <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${account.avtPath}"
                                             alt="Ảnh đại diện" class="avatar-preview" id="avatarPreview">
                                    </c:if>
                                </div>
                                <div>
                                    <input type="hidden" name="currentAvtPath" value="${account.avtPath}">
                                    <input type="file" class="form-control form-control-sm" name="avtPath"
                                           id="avt_path">
                                </div>
                            </div>
                        </div>
                        <!-- Tên đăng nhập -->
                        <div class="mb-4">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" name="username" value="${account.username}"
                                   required>
                        </div>
                        <!-- Mật khẩu -->
                        <div class="mb-4">
                            <label class="form-label">Mật khẩu</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="passwordInput" name="password"
                                       value="${account.password}" required>
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>
                        <!-- Trạng thái -->
                        <div class="mb-4">
                            <label class="form-label d-block">Trạng thái</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status"
                                       value="active" ${account.active ? 'checked' : ''}>
                                <label class="form-check-label">Hoạt động</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="status"
                                       value="inactive" ${!account.active ? 'checked' : ''}>
                                <label class="form-check-label">Khóa tài khoản</label>
                            </div>
                        </div>
                        <!-- Nút hành động -->
                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-custom text-white px-4">Cập nhật</button>
                            <a href="/userInformation?action=showUserInformation" class="btn btn-danger ms-3 px-4">
                                Huỷ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
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
