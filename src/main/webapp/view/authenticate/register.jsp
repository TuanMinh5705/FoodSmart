<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng kí</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .avatar-preview {
            display: block;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 15px;
            border: 3px solid #007bff;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0 text-center">Đăng kí</h3>
                </div>
                <div class="card-body">
                    <form id="registerForm" action="/authenticate?action=register" method="POST" enctype="multipart/form-data">
                        <!-- Ảnh đại diện -->
                        <div class="form-group text-center">
                            <img id="avatarPreview" class="avatar-preview" src="${pageContext.request.contextPath}/images/avatars/avt_default.jpg" alt="Ảnh đại diện">
                            <label for="avt_path">Ảnh đại diện:</label>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="avt_path" name="avt_path" accept="image/*">
                                <label class="custom-file-label" for="avt_path">Chọn ảnh</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="username">Tên đăng nhập:</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input id="username" name="username" type="text" class="form-control"
                                       pattern="[A-Za-z0-9]{3,}" placeholder="Nhập tên đăng nhập..."
                                       title="Tên đăng nhập phải có ít nhất 3 ký tự, chỉ chứa chữ cái và số"
                                       required autofocus>
                            </div>
                        </div>

                        <!-- Mật khẩu -->
                        <div id="passwordFields">
                            <div class="form-group">
                                <label for="password">Mật khẩu:</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    </div>
                                    <input id="password" type="password" name="password" class="form-control"
                                           pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$" placeholder="Nhập mật khẩu..."
                                           title="Mật khẩu phải có 6-12 ký tự, chứa ít nhất một chữ cái và một số" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="re_password">Nhập lại mật khẩu:</label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    </div>
                                    <input id="re_password" type="password" name="re_password" class="form-control"
                                           placeholder="Nhập lại mật khẩu..." required>
                                </div>
                            </div>
                        </div>

                        <!-- Số điện thoại -->
                        <div class="form-group">
                            <label for="phone">Số điện thoại (tùy chọn):</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                </div>
                                <input id="phone" type="tel" name="phonenumber" class="form-control"
                                       placeholder="Nhập số điện thoại..." pattern="[0-9]{10,11}"
                                       title="Số điện thoại phải có 10 hoặc 11 chữ số">
                            </div>
                        </div>

                        <!-- Địa chỉ -->
                        <div class="form-group">
                            <label for="address">Địa chỉ (tùy chọn):</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-home"></i></span>
                                </div>
                                <textarea id="address" name="address" class="form-control" placeholder="Nhập địa chỉ..."></textarea>
                            </div>
                        </div>

                        <!-- Nút đăng ký -->
                        <button type="submit" class="btn btn-primary btn-block">Đăng kí</button>
                    </form>

                    <div class="text-center mt-3">
                        <p>Bạn đã có tài khoản? <a href="/authenticate?action=loginForm">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Xử lý preview ảnh đại diện
    document.getElementById("avt_path").addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("avatarPreview").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Kiểm tra username bằng AJAX khi blur
    document.getElementById("username").addEventListener("blur", function() {
        const username = this.value;
        if (username.length >= 3) {
            fetch('/authenticate?action=checkUsername&username=' + encodeURIComponent(username))
                .then(response => response.json())
                .then(data => {
                    const usernameInput = document.getElementById("username");
                    if (data.exists) {
                        Swal.fire({
                            toast: true,
                            position: 'top-end',
                            icon: 'error',
                            title: 'Tên đăng nhập đã tồn tại.',
                            showConfirmButton: false,
                            timer: 3000,
                            timerProgressBar: true,
                            didOpen: (toast) => {
                                toast.addEventListener('mouseenter', Swal.stopTimer)
                                toast.addEventListener('mouseleave', Swal.resumeTimer)
                            }
                        });
                        document.getElementById("passwordFields").style.display = 'none';
                        usernameInput.classList.add("is-invalid");
                        usernameInput.focus();
                    } else {
                        document.getElementById("passwordFields").style.display = 'block';
                        usernameInput.classList.remove("is-invalid");
                    }
                })
                .catch(error => console.error("Lỗi fetch:", error));
        }
    });
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
