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
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 2rem;
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
        .btn-primary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: var(--primary-gradient);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgb(94, 35, 144);
        }
        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
        }
        /* Custom style cho button "Chọn ảnh" */
        .btn-custom-upload {
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-custom-upload:hover {
            background-color: #218838;
            transform: translateY(-3px);
            color: #fff; /* Giữ nguyên màu chữ */
        }
        /* Custom style cho button "Quay lại" */
        .btn-custom-back {
            background-color: #f86e51;
            color: #fff;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-custom-back:hover {
            background-color: #ee3e38;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgb(251, 164, 101);
            color: #fff; /* Giữ nguyên màu chữ */
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
                        <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${loggedInAccount.avtPath}"
                             alt="Ảnh đại diện" class="img-thumbnail avatar-preview mb-3" id="avatarPreview">
                    </c:if>
                    <input type="hidden" name="currentAvtPath" value="${loggedInAccount.avtPath}">
                    <!-- Input file ẩn -->
                    <input type="file" class="d-none" name="avtPath" id="avt_path">
                    <!-- Nút chọn ảnh với style riêng -->
                    <div>
                        <button type="button" class="btn btn-outline-success" onclick="document.getElementById('avt_path').click()">Chọn ảnh</button>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" class="form-control" id="username" name="username"
                       value="${loggedInAccount.username}" required>
            </div>
            <div class="mb-3">
                <label for="passwordInput" class="form-label">Mật khẩu:</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="passwordInput" name="password"
                           value="${loggedInAccount.password}" required>
                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
            </div>
            <div class="mb-3 center">
                <label class="form-label">Trạng thái tài khoản:</label>
                <div class="form-check form-check-inline">
                    <input type="radio" id="active" name="status" value="active" class="form-check-input"
                    ${loggedInAccount.active ? 'checked' : ''}>
                    <label class="form-check-label" for="active">Đang hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" id="inactive" name="status" value="inactive" class="form-check-input"
                    ${!loggedInAccount.active ? 'checked' : ''}>
                    <label class="form-check-label" for="inactive">Khóa</label>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Cập nhật</button>
                <a href="#" class="btn btn-custom-back">Quay lại</a>
            </div>
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
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
    document.getElementById("togglePassword").addEventListener("click", function() {
        var passwordInput = document.getElementById("passwordInput");
        var icon = this.querySelector("i");
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            passwordInput.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    });
</script>
</body>
</html>
