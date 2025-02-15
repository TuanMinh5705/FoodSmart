<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 15/02/2025
  Time: 5:23 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quên mật khẩu</title>
</head>
<body>
<form action="/authenticate?action=resetPassword" method="post">
    <h1>Quên mật khẩu</h1>
    <div>
        <label>Tên đăng nhập</label>
        <input name="username" type="text"
               pattern="[A-Za-z0-9]{3,}"
               placeholder="Nhập tên đăng nhập..."
               title="Tên đăng nhập phải có ít nhất 3 ký tự, chỉ chứa chữ cái và số"
               autofocus
               required>
    </div>

    <div>
        <label for="newPassword">Mật khẩu mới:</label>
        <input type="password" id="newPassword" name="newPassword" required>
    </div>

    <div>
        <label for="captchaInput">Nhập mã xác minh:</label>
        <input type="text" id="captchaInput" name="captchaInput" required>
    </div>
    <div>
        <p>Mã xác minh: <strong>${captchaText}</strong></p>
    </div>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
    <button type="submit">Reset Mật Khẩu</button>
</form>
</body>
</html>
