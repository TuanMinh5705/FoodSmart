<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/manageStore?action=editInfoStore" method="post" enctype="multipart/form-data">
    <input type="hidden" name="accountID" value="${loggedInAccount.accountID}">
    <label>Username:</label>
    <input type="text" name="username" value="${loggedInAccount.username}"/><br>

    <div class="mb-3">
        <label class="form-label">Mật khẩu</label>
        <div class="input-group">
            <input type="password" class="form-control" id="passwordInput" name="password"
                   value="${loggedInAccount.password}" required>
            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                <i class="fas fa-eye"></i>
            </button>
        </div>
    </div>

    <div class="mb-3">
        <label class="form-label">Ảnh đại diện</label>
        <div class="d-flex align-items-center">
            <div class="me-3">
                <c:if test="${not empty loggedInAccount.avtPath}">
                    <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${loggedInAccount.avtPath}"
                         alt="Ảnh đại diện" class="img-thumbnail" id="avatarPreview"
                         style="width: 120px; height: 120px; border-radius: 50%;">
                </c:if>
            </div>
            <div>
                <input type="hidden" name="currentAvtPath" value="${loggedInAccount.avtPath}">
                <input type="file" class="form-control" name="avtPath" id="avt_path">
            </div>
        </div>
    </div>
    <div class="mb-3">
        <label class="form-label">Trạng thái tài khoản</label>
        <div>
            <input type="radio" id="active" name="status" value="active" ${loggedInAccount.active ? 'checked' : ''}>
            <label for="active">Đang hoạt động</label>

            <input type="radio" id="inactive" name="status" value="inactive" ${!loggedInAccount.active ? 'checked' : ''}>
            <label for="inactive">Khóa</label>
        </div>
    </div>


    <button type="submit" class="btn btn-primary">Cập nhật</button>
</form>



</body>
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
</html>
