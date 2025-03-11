<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật thông tin tài khoản</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --primary-color: #8865ff;
            --secondary-color: #2575fc;
            --primary-gradient: linear-gradient(90deg, #8E2DE2, #4A00E0);
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .custom-container {
            max-width: 600px;
            margin: auto;
            padding: 50px 15px;
        }
        .profile-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            padding: 2rem;
            animation: fadeInUp 1s ease;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .card-header h2 {
            margin: 0;
            color: #333;
        }
        .form-label {
            font-weight: 600;
            color: #555;
        }
        .form-control {
            border-radius: 50px;
        }
        /* Buttons */
        .btn-primary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            border: none;
            transition: background 0.3s, transform 0.3s, box-shadow 0.3s;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #1E88E5, #2a9ffc);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
        }
        .btn-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-back:hover {
            background: linear-gradient(90deg, #f55d5d, #f67272);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgb(234, 177, 177);
        }
        /* Avatar & ảnh preview */
        .avatar-container {
            position: relative;
            display: inline-block;
            cursor: pointer;
        }
        .edit-icon {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(0, 0, 0, 0.6);
            color: #fff;
            border-radius: 50%;
            padding: 5px;
            font-size: 1rem;
            transition: background 0.3s;
        }
        .edit-icon:hover {
            background: rgba(0, 0, 0, 0.8);
        }
        /* Gộp chung hiệu ứng chuyển đổi cho avatar và các ảnh preview */
        .avatar-preview,
        .img-preview {
            transition: opacity 0.5s ease, transform 0.5s ease;
        }
        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
        }
        .img-preview:hover {
            transform: scale(1.05);
        }
        .account-status {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
        }
        .password-container {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            z-index: 2;
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2 class="form-label fw-bold">Cập nhật thông tin tài khoản</h2>
        </div>
        <form action="/manageStore?action=editInfoStore" method="post" enctype="multipart/form-data">
            <input type="hidden" name="accountID" value="${merchant.accountID}">
            <div class="mb-3">
                <label class="form-label">Ảnh đại diện:</label>
                <div class="text-center">
                    <c:if test="${not empty merchant.avtPath}">
                        <div class="avatar-container">
                            <img src="${pageContext.request.contextPath}/images/avatars/${merchant.avtPath}"
                                 alt="Ảnh đại diện" class="img-thumbnail avatar-preview img-preview mb-3" id="avatarPreview">
                            <i class="fas fa-pen edit-icon"></i>
                        </div>
                    </c:if>
                    <input type="hidden" name="currentAvtPath" value="${merchant.avtPath}">
                    <input type="file" class="d-none" name="avtPath" id="avt_path">
                </div>
            </div>
            <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" class="form-control" id="username" name="username" value="${merchant.username}" required>
            </div>
            <div class="mb-3">
                <label for="passwordInput" class="form-label">Mật khẩu:</label>
                <div class="password-container">
                    <input type="password" class="form-control" id="passwordInput" name="password" value="${merchant.password}" required style="padding-right: 40px;">
                    <i class="fas fa-eye toggle-password" id="togglePassword"></i>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label d-block text-center">Trạng thái tài khoản:</label>
                <div class="account-status">
                    <div class="form-check">
                        <input type="radio" id="active" name="status" value="active" class="form-check-input" ${merchant.active ? 'checked' : ''}>
                        <label class="form-check-label" for="active">Đang hoạt động</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" id="inactive" name="status" value="inactive" class="form-check-input" ${!merchant.active ? 'checked' : ''}>
                        <label class="form-check-label" for="inactive">Khóa</label>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary me-4">Cập nhật</button>
                <button type="button" class="btn-back" onclick="location.href='/manageStore?action=showMerchantStore'">Quay lại</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const avatarInput     = document.getElementById("avt_path");
        const avatarPreview   = document.getElementById("avatarPreview");
        const avatarContainer = document.querySelector(".avatar-container");
        const togglePassword  = document.getElementById("togglePassword");
        const passwordInput   = document.getElementById("passwordInput");

        if (avatarInput && avatarPreview) {
            avatarInput.addEventListener("change", event => {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = e => {
                        avatarPreview.style.opacity = 0;
                        setTimeout(() => {
                            avatarPreview.src = e.target.result;
                            avatarPreview.style.opacity = 1;
                        }, 300);
                    };
                    reader.readAsDataURL(file);
                }
            });
        }

        if (avatarContainer) {
            avatarContainer.addEventListener("click", () => avatarInput.click());
        }

        if (togglePassword && passwordInput) {
            togglePassword.addEventListener("click", () => {
                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    togglePassword.classList.replace("fa-eye", "fa-eye-slash");
                } else {
                    passwordInput.type = "password";
                    togglePassword.classList.replace("fa-eye-slash", "fa-eye");
                }
            });
        }
    });
</script>
</body>
</html>
