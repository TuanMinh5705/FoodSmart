<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <!-- Animate.css for effects -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <style>
        .input-group-text { cursor: pointer; }
    </style>
</head>
<body>
<!-- SweetAlert2 Toast for Error -->
<c:if test="${not empty sessionScope.error}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'error',
            title: '${sessionScope.error}',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            showClass: {
                popup: 'animate__animated animate__fadeInDown'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOutUp'
            }
        });
    </script>
    <c:remove var="error" scope="session"/>
</c:if>

<!-- SweetAlert2 Toast for Success with a "tada" effect -->
<c:if test="${not empty sessionScope.success}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: 'success',
            title: '${sessionScope.success}',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            showClass: {
                popup: 'animate__animated animate__fadeInDown'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOutUp'
            },
            didOpen: (toast) => {
                toast.classList.add('animate__animated', 'animate__tada');
            }
        });
    </script>
    <c:remove var="success" scope="session"/>
</c:if>

<div class="container login-container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">Đăng nhập</h3>
                    <form action="/authenticate?action=login" method="POST">
                        <div class="form-group">
                            <label for="username">Tên đăng nhập</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input id="username" name="username" type="text" class="form-control" required autofocus placeholder="Nhập tên đăng nhập">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password">Mật khẩu</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                </div>
                                <input id="password" type="password" name="password" class="form-control" required placeholder="Nhập mật khẩu">
                                <div class="input-group-append">
                                        <span class="input-group-text toggle-password">
                                            <i class="fas fa-eye"></i>
                                        </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <a href="/authenticate?action=forgetPasswordForm">Quên mật khẩu?</a>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Đăng nhập</button>
                    </form>
                    <div class="text-center mt-3">
                        <p>Bạn chưa có tài khoản? <a href="/authenticate?action=registerForm">Đăng ký ngay</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Script JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).on('click', '.toggle-password', function() {
        var input = $('#password');
        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            $(this).find('i').removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            input.attr('type', 'password');
            $(this).find('i').removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });
</script>
</body>
</html>
