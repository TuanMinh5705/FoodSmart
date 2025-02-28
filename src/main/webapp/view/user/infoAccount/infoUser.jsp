<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin Tài Khoản</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,500,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/view/user/infoAccount/user.css" />

</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 d-none d-md-block">
            <div class="sidebar">
                <jsp:include page="sidebarUser.jsp"/>
            </div>
        </div>
        <!-- Nội dung chính -->
        <div class="col-md-9">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="mb-0">Thông tin Tài Khoản</h4>
                            </div>
                            <div class="card-body">
                                <!-- Ảnh đại diện -->
                                <div class="form-group text-center mb-4">
                                    <label class="form-label d-block">Ảnh đại diện</label>
                                    <c:if test="${not empty account.avtPath}">
                                        <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${account.avtPath}"
                                             alt="Ảnh đại diện" class="avatar img-thumbnail mx-auto d-block" id="avatarPreview">
                                    </c:if>
                                </div>
                                <!-- Tên đăng nhập hiển thị theo hàng ngang -->
                                <div class="inline-field">
                                    <label class="form-label">Tên đăng nhập:</label>
                                    <span>${account.username}</span>
                                </div>
                                <!-- Mật khẩu hiển thị theo hàng ngang với chức năng toggle -->
                                <div class="inline-field">
                                    <label class="form-label">Mật khẩu:</label>
                                    <div class="input-group" style="max-width: 300px;">
                                        <input type="password" class="form-control" id="passwordInput"
                                               name="password" value="${account.password}" readonly>
                                        <div class="input-group-append">
                                            <span class="input-group-text toggle-password-btn" id="togglePassword">
                                                <i class="fas fa-eye"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Trạng thái tài khoản -->
                                <div class="form-group mb-4">
                                    <label class="form-label">Trạng thái</label>
                                    <div>
                                        <c:if test="${account.active}">
                                            <span class="badge badge-success">Đang hoạt động</span>
                                        </c:if>
                                        <c:if test="${!account.active}">
                                            <span class="badge badge-secondary">Không hoạt động</span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <a href="/userInformation?action=editUserForm" class="btn btn-primary">Chỉnh sửa</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Nội dung chính -->
    </div>
</div>
<!-- jQuery và Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
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
</body>
</html>
