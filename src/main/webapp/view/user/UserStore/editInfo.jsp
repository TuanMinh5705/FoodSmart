<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Khanh Nguyen
  Date: 2/25/2025
  Time: 10:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sua thong tin</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
    <!-- FontAwesome (Thêm dòng này) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body>
<form action="/userInformation?action=editInfoUser" method="post" enctype="multipart/form-data">
    <!-- Avatar -->
    <div class="mb-3">
        <label class="form-label">Ảnh đại diện</label>
        <div class="d-flex align-items-center">
            <div class="me-3">
                <c:if test="${not empty account.avtPath}">
                    <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${account.avtPath}"
                         alt="Ảnh đại diện" class="img-thumbnail" id="avatarPreview"
                         style="width: 120px; height: 120px; border-radius: 50%;">
                </c:if>
            </div>
            <div>
                <input type="hidden" name="currentAvtPath" value="${account.avtPath}">
                <input type="file" class="form-control" name="avtPath" id="avt_path">
            </div>
        </div>
    </div>

    <!-- Tên đăng nhập -->
    <div class="mb-3">
        <label class="form-label">Tên đăng nhập</label>
        <input type="text" class="form-control" name="username" value="${account.username}" required>
    </div>

    <!-- Mật khẩu với toggle hiển thị -->
    <div class="mb-3">
        <label class="form-label">Mật khẩu</label>
        <div class="input-group">
            <input type="password" class="form-control" id="passwordInput" name="password"
                   value="${account.password}" required>
            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                <i class="fas fa-eye"></i>
            </button>
        </div>
    </div>

    <!-- Trạng thái -->
    <div class="mb-3">
        <label class="form-label">Trạng thái</label>
        <div class="form-check">
            <input type="radio" class="form-check-input" name="status"
                   value="active" ${account.active ? 'checked' : ''}>
            <label class="form-check-label">Hoạt động</label>
        </div>
        <div class="form-check">
            <input type="radio" class="form-check-input" name="status"
                   value="inactive" ${!account.active ? 'checked' : ''}>
            <label class="form-check-label">Khóa tài khoản</label>
        </div>
    </div>
    <button type="submit">Cap nhat</button>
</form>

<script>

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

    document.getElementById("togglePassword").addEventListener("click", function () {
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
