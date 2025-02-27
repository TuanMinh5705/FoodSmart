<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">

            <div class="card shadow">
                <div class="card-header bg-danger text-white">
                    <h3 class="mb-0 text-center">Quên mật khẩu</h3>
                </div>
                <div class="card-body">
                    <form action="/authenticate?action=resetPassword" method="post">

                        <div class="form-group">
                            <label for="username">Tên đăng nhập</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" id="username" name="username"
                                       pattern="[A-Za-z0-9]{3,}"
                                       placeholder="Nhập tên đăng nhập..."
                                       title="Tên đăng nhập phải có ít nhất 3 ký tự, chỉ chứa chữ cái và số"
                                       autofocus required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newPassword">Mật khẩu mới</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-lock"></i>
                                    </span>
                                </div>
                                <input type="password" class="form-control" id="newPassword" name="newPassword"
                                       placeholder="Nhập mật khẩu mới" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="captchaInput">Nhập mã xác minh</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-shield-alt"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" id="captchaInput" name="captchaInput"
                                       placeholder="Nhập mã xác minh" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <p class="mb-0">Mã xác minh: <strong>${sessionScope.captcha}</strong></p>
                        </div>

                        <c:if test="${not empty sessionScope.error}">
                            <div class="alert alert-danger" role="alert">
                                    ${sessionScope.error}
                                <c:remove var="error" scope="session"/>
                            </div>
                        </c:if>

                        <c:if test="${not empty sessionScope.success}">
                            <div class="alert alert-success" role="alert">
                                    ${sessionScope.success}
                                <c:remove var="success" scope="session"/>
                            </div>
                        </c:if>

                        <button type="submit" class="btn btn-danger btn-block">Reset Mật Khẩu</button>
                    </form>
                </div>
            </div>

            <div class="text-center mt-3">
                <a href="/authenticate?action=loginForm" class="text-muted">Quay lại đăng nhập</a>
            </div>

        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
