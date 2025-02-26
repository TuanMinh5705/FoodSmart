<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông tin User</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
    <!-- FontAwesome (Thêm dòng này) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
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
    </div>
</div>

<!-- Tên đăng nhập -->
<div class="mb-3">
    <label class="form-label">Tên đăng nhập</label>
    <input type="text" class="form-control" name="username" value="${account.username}" readonly>
</div>

<!-- Mật khẩu với toggle hiển thị -->
<div class="mb-3">
    <label class="form-label">Mật khẩu</label>
    <div class="input-group">
        <input type="password" class="form-control" id="passwordInput" name="password"
               value="${account.password}" readonly>
        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
            <i class="fas fa-eye"></i>
        </button>
    </div>
</div>
<p>Trạng thái :
<c:if test="${account.active}">
    <p>Đang hoạt động</p>
</c:if>
</p>
<a href="/userInformation?action=editUserForm">sửa</a>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
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

</html>
