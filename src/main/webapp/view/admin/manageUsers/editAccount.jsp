<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật thông tin người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2 class="text-center mb-4">
        <i class="fas fa-edit"></i> Cập nhật thông tin người dùng
    </h2>
    <div class="card shadow">
        <div class="card-body">
            <form action="/manageUsers?action=updateInfoUser" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="accountID" value="${account.accountID}">

                <!-- Avatar -->
                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-person-circle-fill"></i> Ảnh đại diện</label>
                    <div class="mb-3 text-center">
                        <c:if test="${not empty account.avtPath}">
                            <img id="avatarPreview" src="${pageContext.request.contextPath}/images/avatars/${account.avtPath}"
                                 alt="Ảnh đại diện" class="img-fluid rounded-circle shadow" style="max-width: 130px; height: 130px;">
                        </c:if>
                    </div>
                    <input type="hidden" name="currentAvtPath" value="${account.avtPath}">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="avt_path" name="avtPath" style="max-width: 400px;">
                        <label class="custom-file-label" for="avt_path">${account.avtPath}</label>
                    </div>
                </div>

                <!-- Tên đăng nhập -->
                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-person-fill"></i> Tên đăng nhập</label>
                    <input type="text" class="form-control" name="username" value="${account.username}" required
                           pattern=".*\S.*" title="Tên đăng nhập không được để trống" minlength="2">
                </div>

                <!-- Mật khẩu với toggle hiển thị -->
                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-lock-fill"></i> Mật khẩu</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="passwordInput" name="password"
                               value="${account.password}" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="bi bi-eye-fill"></i>
                        </button>
                    </div>
                </div>

                <!-- Trạng thái -->
                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-check-circle-fill"></i> Trạng thái</label>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" name="status" value="active" ${account.active ? 'checked' : ''}>
                        <label class="form-check-label">Hoạt động</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" name="status" value="inactive" ${!account.active ? 'checked' : ''}>
                        <label class="form-check-label">Khóa tài khoản</label>
                    </div>
                </div>

                <!-- Vai trò -->
                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-shield-lock-fill"></i> Vai trò</label>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" name="role" value="Admin" ${account.role eq 'Admin' ? 'checked' : ''}>
                        <label class="form-check-label">Quản trị viên</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" name="role" value="User" ${account.role eq 'User' ? 'checked' : ''}>
                        <label class="form-check-label">Người dùng</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" name="role" value="Merchant" ${account.role eq 'Merchant' ? 'checked' : ''}>
                        <label class="form-check-label">Chủ cửa hàng</label>
                    </div>
                </div>

                <!-- Danh sách địa chỉ đã lưu -->
                <div class="mb-3">
                    <label class="form-label"><i class="bi bi-geo-alt-fill"></i> Địa chỉ đã lưu</label>
                    <div class="row">
                        <c:forEach var="accountDetail" items="${accountDetails}" varStatus="status">
                            <div class="col-md-${accountDetails.size() > 1 ? 6 : 12} mb-3">
                                <div class="border rounded p-3">
                                    <input type="hidden" name="accountDetailsID" value="${accountDetail.accountDetailID}">
                                    <div class="form-check mb-2">
                                        <input type="radio" class="form-check-input" name="isDefault"
                                               value="${accountDetail.accountDetailID}"
                                            ${accountDetail.isDefault ? 'checked' : ''}>
                                        <label class="form-check-label">Mặc định</label>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><i class="bi bi-building"></i> Địa chỉ</label>
                                        <textarea class="form-control" name="address_${accountDetail.accountDetailID}"
                                                  placeholder="Nhập địa chỉ...">${accountDetail.address}</textarea>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label"><i class="bi bi-telephone-fill"></i> Số điện thoại</label>
                                        <input type="tel" class="form-control"
                                               name="phonenumber_${accountDetail.accountDetailID}"
                                               value="${accountDetail.phonenumber}" placeholder="Nhập số điện thoại..."
                                               pattern="[0-9]{10,11}" title="Số điện thoại phải có 10 hoặc 11 chữ số">
                                    </div>
                                    <div class="text-end">
                                        <button type="button" class="btn btn-danger btn-sm"
                                                onclick="showDeleteModal({ id: ${accountDetail.accountDetailID}, url: '/manageUsers', action: 'deleteDetails' })">
                                            <i class="bi bi-trash-fill"></i> Xóa
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Thêm địa chỉ mới -->
                <div class="mb-3">
                    <label class="form-label">Thêm địa chỉ mới</label>
                    <div class="border border-primary rounded p-3">
                        <div class="form-check mb-2">
                            <input type="radio" class="form-check-input" name="isDefault" value="true">
                            <label class="form-check-label">Mặc định</label>
                        </div>
                        <div class="mb-2">
                            <label class="form-label"><i class="bi bi-house-add-fill"></i> Địa chỉ</label>
                            <textarea class="form-control" name="newAddress" placeholder="Nhập địa chỉ mới..."></textarea>
                        </div>
                        <div class="mb-2">
                            <label class="form-label"><i class="bi bi-telephone-plus-fill"></i> Số điện thoại</label>
                            <input type="tel" class="form-control" name="newPhonenumber" pattern="[0-9]{10,11}"
                                   title="Số điện thoại phải có 10 hoặc 11 chữ số" placeholder="Nhập số điện thoại...">
                        </div>
                        <div class="text-end">
                            <button type="button" id="addAddressBtn" class="btn btn-primary">Thêm địa chỉ</button>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Cập nhật
                    </button>
                    <a href="/manageUsers" class="btn btn-danger ms-3">
                        <i class="bi bi-x-circle"></i> Huỷ
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Script: Bootstrap Bundle & các chức năng JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Cập nhật preview cho file input
        function updateFilePreview(input, previewId) {
            const label = input.nextElementSibling;
            if (input.files.length > 0) {
                const file = input.files[0];
                label.textContent = file.name;
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById(previewId).src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
        document.getElementById("avt_path").addEventListener("change", function () {
            updateFilePreview(this, 'avatarPreview');
        });

        // Toggle hiển thị mật khẩu
        document.getElementById("togglePassword").addEventListener("click", function () {
            var passwordInput = document.getElementById("passwordInput");
            var icon = this.querySelector("i");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                icon.classList.remove("bi-eye-fill");
                icon.classList.add("bi-eye-slash-fill");
            } else {
                passwordInput.type = "password";
                icon.classList.remove("bi-eye-slash-fill");
                icon.classList.add("bi-eye-fill");
            }
        });

        // Thêm địa chỉ mới (sử dụng SweetAlert2 cho thông báo)
        document.getElementById("addAddressBtn").addEventListener("click", function () {
            const newAddress = document.querySelector('textarea[name="newAddress"]').value;
            const newPhonenumber = document.querySelector('input[name="newPhonenumber"]').value;
            const isDefault = document.querySelector('input[name="isDefault"][value="true"]').checked;

            if (!newAddress || !newPhonenumber) {
                Swal.fire({
                    title: "Cảnh báo!",
                    text: "Vui lòng nhập đầy đủ thông tin địa chỉ và số điện thoại.",
                    icon: "warning",
                    position: "top-end",
                    showConfirmButton: false,
                    timer: 2000
                });
                return;
            }

            const formData = new FormData();
            formData.append("newAddress", newAddress);
            formData.append("newPhonenumber", newPhonenumber);
            formData.append("isDefault", isDefault);
            formData.append("accountID", "${account.accountID}");

            fetch("/manageUsers?action=addAddress", {
                method: "POST",
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        Swal.fire({
                            title: "Thành công!",
                            text: "Địa chỉ mới đã được thêm.",
                            icon: "success",
                            position: "top-end",
                            showConfirmButton: false,
                            timer: 2000
                        }).then(() => {
                            location.reload();
                        });
                    } else {
                        Swal.fire({
                            title: "Lỗi!",
                            text: data.message || "Có lỗi xảy ra.",
                            icon: "error",
                            position: "top-end",
                            showConfirmButton: false,
                            timer: 2000
                        });
                    }
                })
                .catch(error => {
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Có lỗi xảy ra: " + error,
                        icon: "error",
                        position: "top-end",
                        showConfirmButton: false,
                        timer: 2000
                    });
                });
        });
    });
</script>
</body>
</html>
