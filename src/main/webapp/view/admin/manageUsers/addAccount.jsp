<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 16/02/2025
  Time: 4:22 CH
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm người dùng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .avatar-preview {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 1px solid #ddd;
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h2 class="mb-4 text-center">Thêm người dùng</h2>
            <div class="card shadow">
                <div class="card-body">
                    <form action="/manageUsers?action=addUser" method="post" enctype="multipart/form-data">
                        <!-- Ảnh đại diện -->
                        <div class="mb-3 text-center">
                            <img id="avatarPreview" class="avatar-preview" src="https://via.placeholder.com/150" alt="Ảnh đại diện">
                            <label for="avatar" class="form-label d-block">
                                <i class="fas fa-image"></i> Chọn ảnh đại diện
                            </label>
                            <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*">
                        </div>

                        <!-- Tên đăng nhập -->
                        <div class="mb-3">
                            <label for="username" class="form-label"><i class="fas fa-user"></i> Tên đăng nhập</label>
                            <input type="text" class="form-control" id="username" name="username"
                                   pattern="^[a-zA-Z0-9_]{3,20}$"
                                   title="Tên đăng nhập chỉ chứa chữ cái, số, dấu gạch dưới và có độ dài 3-20 ký tự"
                                   placeholder="Nhập tên đăng nhập" required>
                        </div>

                        <!-- Mật khẩu -->
                        <div class="mb-3">
                            <label for="password" class="form-label"><i class="fas fa-lock"></i> Mật khẩu</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$"
                                   title="Mật khẩu tối thiểu 6 ký tự, ít nhất một chữ cái và một số"
                                   placeholder="Nhập mật khẩu" required>
                        </div>

                        <!-- Xác nhận mật khẩu -->
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label"><i class="fas fa-key"></i> Xác nhận mật khẩu</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu" required>
                        </div>

                        <!-- Địa chỉ -->
                        <div class="mb-3">
                            <label for="address" class="form-label"><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                            <input type="text" class="form-control" id="address" name="address"
                                   pattern="^.{5,100}$"
                                   title="Địa chỉ phải có ít nhất 5 ký tự"
                                   placeholder="Nhập địa chỉ">
                        </div>

                        <!-- Số điện thoại -->
                        <div class="mb-3">
                            <label for="phone" class="form-label"><i class="fas fa-phone"></i> Số điện thoại</label>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                   pattern="^(0[3-9])+([0-9]{8})$"
                                   title="Số điện thoại Việt Nam hợp lệ (bắt đầu từ 03-09 và có 10 số)"
                                   placeholder="Nhập số điện thoại">
                        </div>

                        <!-- Vai trò -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-user-shield"></i> Vai trò</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role" id="admin" value="Admin">
                                <label class="form-check-label" for="admin">
                                    <i class="fas fa-user-cog"></i> Quản trị viên
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role" id="merchant" value="Merchant">
                                <label class="form-check-label" for="merchant">
                                    <i class="fas fa-store"></i> Chủ cửa hàng
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role" id="user" value="User" checked>
                                <label class="form-check-label" for="user">
                                    <i class="fas fa-users"></i> Người dùng
                                </label>
                            </div>
                        </div>

                        <!-- Nút submit -->
                        <div class="d-flex justify-content-center gap-2">
                            <a href="/manageCategoryFood" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Thêm người dùng
                            </button>
                        </div>
                    </form>
                </div> <!-- End card-body -->
            </div> <!-- End card -->
        </div> <!-- End col-md-8 -->
    </div> <!-- End row -->
</div> <!-- End container -->

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hiển thị ảnh đại diện khi chọn file
    document.getElementById("avatar").addEventListener("change", function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("avatarPreview").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Xác nhận mật khẩu
    document.querySelector("form").addEventListener("submit", function(event) {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;
        if (password !== confirmPassword) {
            alert("Mật khẩu xác nhận không khớp!");
            event.preventDefault();
        }
    });
</script>
</body>
</html>
