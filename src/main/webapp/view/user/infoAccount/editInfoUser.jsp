<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Thông Tin Tài Khoản</title>
    <!-- Sử dụng Bootstrap 4.5.2 và FontAwesome giống trang Thông tin Tài Khoản -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,500,600&display=swap" rel="stylesheet">
    <style>
        body {
            background: #ecf0f1;
            font-family: 'Poppins', sans-serif;
            color: #2c3e50;
        }
        .card {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            background: #ffffff;
        }
        .card-header {
            background: linear-gradient(90deg, #2980b9, #3498db);
            color: #ffffff;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            text-align: center;
            padding: 20px;
        }
        .card-body {
            padding: 30px;
        }
        .avatar {
            width: 130px;
            height: 130px;
            border-radius: 50% !important;
            object-fit: contain;
        }
        .form-label {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .btn-primary {
            background-color: #2980b9;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #2471a3;
        }
        a {
            text-decoration: none !important;
        }
        /* Định dạng cho input file ẩn */
        #avt_path {
            display: none;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 d-none d-md-block">
            <jsp:include page="sidebarUser.jsp" />
        </div>
        <!-- Nội dung chính -->
        <div class="col-md-9">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="mb-0">Sửa Thông Tin Tài Khoản</h3>
                            </div>
                            <div class="card-body">
                                <form action="/userInformation?action=editInfoUser" method="post" enctype="multipart/form-data">
                                    <!-- Ảnh đại diện -->
                                    <div class="form-group text-center mb-4">
                                        <label class="form-label d-block">Ảnh đại diện</label>
                                        <c:if test="${not empty account.avtPath}">
                                            <img src="${pageContext.request.contextPath}/images/avatars/${account.avtPath}"
                                                 alt="Ảnh đại diện" class="avatar img-thumbnail mx-auto d-block" id="avatarPreview">
                                        </c:if>
                                        <input type="hidden" name="currentAvtPath" value="${account.avtPath}">
                                        <input type="file" class="form-control-file mt-2" name="avtPath" id="avt_path">
                                        <button type="button" class="btn btn-secondary mt-2" id="chooseImageButton">
                                            <i class="fas fa-image"></i> Chỉnh sửa hình ảnh
                                        </button>
                                    </div>
                                    <!-- Tên đăng nhập -->
                                    <div class="form-group mb-4">
                                        <label class="form-label">Tên đăng nhập</label>
                                        <input type="text" class="form-control" name="username" value="${account.username}" required>
                                    </div>
                                    <!-- Mật khẩu -->
                                    <div class="form-group mb-4">
                                        <label class="form-label">Mật khẩu</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="passwordInput" name="password" value="${account.password}" required>
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Trạng thái -->
                                    <div class="form-group mb-4">
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
                                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                                        <a href="/userInformation?action=showUserInformation" class="btn btn-danger ml-3">Huỷ</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End nội dung chính -->
    </div>
</div>
<!-- jQuery và Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
    // Khi nhấn "Chỉnh sửa hình ảnh", kích hoạt input file ẩn
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
