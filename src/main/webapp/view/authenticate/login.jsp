<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <style>
        .error {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<section>
    <form action="authenticate?action=login" method="POST">
        <h1>Đăng nhập</h1>

        <input type="hidden" name="action" value="login">

        <div>
            <p>Tên đăng nhập</p>
            <input name="username" type="text"
                   pattern="[A-Za-z0-9]{3,}"
                   placeholder="Nhập tên đăng nhập..."
                   title="Tên đăng nhập phải có ít nhất 3 ký tự, chỉ chứa chữ cái và số"
                   autofocus
                   required>
        </div>

        <div>
            <p>Mật khẩu</p>
            <input type="password" name="password"
                   pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$"
                   placeholder="Nhập mật khẩu..."
                   title="Mật khẩu phải có 6-12 ký tự, chứa ít nhất một chữ cái và một số"
                   required>
        </div>
        <div>
            <a href="/authenticate?action=forgetPassword">Quên mật khẩu?</a>
        </div>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <button type="submit">Đăng nhập</button>
    </form>

    <p>Bạn chưa có tài khoản? <a href="/authenticate?action=registerForm">Đăng ký ngay</a></p>
</section>
</body>
</html>
