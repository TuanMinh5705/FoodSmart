
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
    <style>
        /* Tổng thể */
        body {
            background: #f4f7f9;
            font-family: 'Poppins', sans-serif;
        }
        /* Sidebar */
        .sidebar {
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        .sidebar .nav-link {
            font-weight: 500;
            padding: 10px 15px;
            transition: all 0.3s ease;
            border-radius: 5px;
            color: #333;
        }
        .sidebar .nav-link:hover {
            background-color: #2575fc;
            color: #fff;
        }
        .sidebar .nav-link.text-danger:hover {
            background-color: #dc3545;
        }
        /* Thẻ Card */
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            color: #fff;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
        }
        .form-label {
            font-weight: 600;
        }
        .toggle-password-btn {
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Cột Sidebar -->
        <div class="col-md-3 d-none d-md-block">
            <jsp:include page="sidebarUser.jsp"/>
        </div>
        <!-- Cột Nội dung Chính -->
        <div class="col-md-9">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header text-center">
                                <h4 class="mb-0">Thông tin Tài Khoản</h4>
                            </div>
                            <div class="card-body">
                                <div class="form-group text-center mb-4">
                                    <label class="form-label">Ảnh đại diện</label>
                                    <div>
                                        <c:if test="${not empty account.avtPath}">
                                            <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${account.avtPath}"
                                                 alt="Ảnh đại diện" class="avatar img-thumbnail" id="avatarPreview">
                                        </c:if>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label">Tên đăng nhập</label>
                                    <input type="text" class="form-control" name="username" value="${account.username}" readonly>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label">Mật khẩu</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="passwordInput" name="password" value="${account.password}" readonly>
                                        <div class="input-group-append">
                                            <span class="input-group-text toggle-password-btn" id="togglePassword">
                                                <i class="fas fa-eye"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
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
        <!-- Bạn có thể thêm giao diện cho thiết bị di động (mobile) nếu cần -->
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