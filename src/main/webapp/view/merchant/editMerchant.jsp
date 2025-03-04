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
            font-family: 'Fantasy', sans-serif;
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
        /* Nút cập nhật theo gradient xanh ban đầu */
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
        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            transition: transform 0.5s ease, opacity 0.5s ease;
        }

        .img-preview {
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .img-preview:hover {
            transform: scale(1.05);
        }

        .avatar-preview:hover {
            transform: scale(1.05);
        }
        .btn-custom-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-custom-back:hover {
            background: linear-gradient(90deg, #f55d5d, #f67272);
            transform: translateY(-3px);
            color: #fff;
            box-shadow: 0 8px 20px rgb(234, 177, 177);
        }
        .account-status {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
        }
        /* Container cho input mật khẩu và icon toggle */
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
        /* Avatar container và icon edit */
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
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2 class="form-label fw-bold">Cập nhật thông tin tài khoản</h2>
        </div>
        <form action="/manageStore?action=editInfoStore" method="post" enctype="multipart/form-data">
            <input type="hidden" name="accountID" value="${loggedInAccount.accountID}">
            <div class="mb-3">
                <label class="form-label">Ảnh đại diện:</label>
                <div class="text-center">
                    <c:if test="${not empty loggedInAccount.avtPath}">
                        <div class="avatar-container">
                            <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${loggedInAccount.avtPath}"
                                 alt="Ảnh đại diện" class="img-thumbnail avatar-preview mb-3" id="avatarPreview">
                            <i class="fas fa-pen edit-icon"></i>
                        </div>
                    </c:if>
                    <input type="hidden" name="currentAvtPath" value="${loggedInAccount.avtPath}">
                    <input type="file" class="d-none" name="avtPath" id="avt_path">
                </div>
            </div>
            <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" class="form-control" id="username" name="username" value="${loggedInAccount.username}" required>
            </div>
            <!-- Input mật khẩu với icon toggle bên trong -->
            <div class="mb-3">
                <label for="passwordInput" class="form-label">Mật khẩu:</label>
                <div class="password-container">
                    <input type="password" class="form-control" id="passwordInput" name="password" value="${loggedInAccount.password}" required style="padding-right: 40px;">
                    <i class="fas fa-eye toggle-password" id="togglePassword"></i>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label d-block text-center">Trạng thái tài khoản:</label>
                <div class="account-status">
                    <div class="form-check">
                        <input type="radio" id="active" name="status" value="active" class="form-check-input" ${loggedInAccount.active ? 'checked' : ''}>
                        <label class="form-check-label" for="active">Đang hoạt động</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" id="inactive" name="status" value="inactive" class="form-check-input" ${!loggedInAccount.active ? 'checked' : ''}>
                        <label class="form-check-label" for="inactive">Khóa</label>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary me-4">Cập nhật</button>
                <a href="#" class="btn btn-custom-back">Quay lại</a>
            </div>
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Preview ảnh đại diện sau khi chọn file
    document.getElementById("avt_path").addEventListener("change", function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("avatarPreview").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
    // Khi nhấp vào avatar container (bao gồm ảnh và icon pen), kích hoạt file input
    document.querySelector(".avatar-container").addEventListener("click", function() {
        document.getElementById("avt_path").click();
    });
    // Xử lý ẩn/hiện mật khẩu khi click vào icon toggle
    document.getElementById("togglePassword").addEventListener("click", function() {
        const passwordInput = document.getElementById("passwordInput");
        const icon = this;
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
