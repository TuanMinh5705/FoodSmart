<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container login-container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <c:if test="${not empty success}">
                <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="successModalLabel">Thông báo</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                    ${success}
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>
                <script type="text/javascript">
                    $(document).ready(function () {
                        $("#successModal").modal('show');
                    });
                </script>
            </c:if>


            <div class="card shadow">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">Đăng nhập</h3>
                    <form action="/authenticate?action=login" method="POST">
                        <input type="hidden" name="action" value="login">
                        <div class="form-group">
                            <label for="username">Tên đăng nhập</label>
                            <input id="username" name="username" type="text" class="form-control"
                                   pattern="[A-Za-z0-9]{3,}" placeholder="Nhập tên đăng nhập..."
                                   title="Tên đăng nhập phải có ít nhất 3 ký tự, chỉ chứa chữ cái và số"
                                   required autofocus>
                        </div>
                        <div class="form-group">
                            <label for="password">Mật khẩu</label>
                            <input id="password" type="password" name="password" class="form-control"
                                   pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$" placeholder="Nhập mật khẩu..."
                                   title="Mật khẩu phải có 6-12 ký tự, chứa ít nhất một chữ cái và một số"
                                   required>
                        </div>
                        <div class="form-group">
                            <a href="/authenticate?action=forgetPasswordForm">Quên mật khẩu?</a>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                    ${error}
                            </div>
                        </c:if>
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
</body>
</html>
