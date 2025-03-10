<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết tài khoản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        .avatar {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            margin: 0 auto;
        }
        .info-label {
            color: #6c757d;
            font-weight: 500;
        }
        .info-field {
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="fas fa-info-circle"></i> Chi tiết tài khoản
    </h2>
    <div class="card shadow p-4">
        <div class="card-body text-center">
            <c:if test="${not empty account.avtPath}">
                <img src="${pageContext.request.contextPath}/images/avatars/${account.avtPath}"
                     alt="Ảnh đại diện" class="avatar mb-3">
            </c:if>
            <div class="mb-3">
                <p class="info-label mb-1">Tên đăng nhập</p>
                <p class="info-field">${account.username}</p>
            </div>
            <div class="mb-3">
                <p class="info-label mb-1">Mật khẩu</p>
                <div class="d-flex justify-content-center">
                    <div class="input-group" style="max-width: 300px;">
                        <input type="password" class="form-control text-center"
                               id="passwordInput" value="${account.password}" readonly>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="bi bi-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-6">
                    <p class="info-label mb-1">Trạng thái</p>
                    <p class="info-field">
                        <c:choose>
                            <c:when test="${account.active}">
                                <i class="bi bi-check-circle-fill text-success me-1"></i> Đang hoạt động
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-lock-fill text-danger me-1"></i> Khóa tài khoản
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="col-sm-6">
                    <p class="info-label mb-1">Vai trò</p>
                    <p class="info-field">
                        <c:choose>
                            <c:when test="${account.role eq 'Admin'}">
                                <i class="bi bi-shield-lock-fill text-primary me-1"></i> Quản trị viên
                            </c:when>
                            <c:when test="${account.role eq 'Merchant'}">
                                <i class="bi bi-shop-window text-warning me-1"></i> Chủ cửa hàng
                            </c:when>
                            <c:when test="${account.role eq 'User'}">
                                <i class="bi bi-person text-secondary me-1"></i> Người dùng
                            </c:when>
                            <c:otherwise>
                                ${account.role}
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
            <div class="mb-3">
                <p class="info-label mb-1">Địa chỉ đã lưu</p>
                <c:if test="${not empty accountDetails}">
                    <div class="row justify-content-center">
                        <c:forEach var="accountDetail" items="${accountDetails}">
                            <div class="col-sm-6 mb-3">
                                <div class="border rounded p-3 text-start">
                                    <p class="mb-1"><strong>Địa chỉ:</strong></p>
                                    <p class="mb-2">${accountDetail.address}</p>
                                    <p class="mb-1"><strong>Số điện thoại:</strong></p>
                                    <p class="mb-2">${accountDetail.phonenumber}</p>
                                    <c:if test="${accountDetail.isDefault}">
                                        <span class="badge bg-primary">Mặc định</span>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty accountDetails}">
                    <p class="text-muted">Chưa có thông tin</p>
                </c:if>
            </div>
            <div class="mt-3">
                <a href="/manageUsers" class="btn btn-secondary">
                    <i class="bi bi-arrow-left-circle"></i> Quay về danh sách
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const toggleBtn = document.getElementById("togglePassword");
    const passwordInput = document.getElementById("passwordInput");
    const toggleIcon = document.getElementById("toggleIcon");

    toggleBtn.addEventListener("click", function () {
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            toggleIcon.classList.remove("bi-eye");
            toggleIcon.classList.add("bi-eye-slash");
        } else {
            passwordInput.type = "password";
            toggleIcon.classList.remove("bi-eye-slash");
            toggleIcon.classList.add("bi-eye");
        }
    });
</script>
</body>
</html>
