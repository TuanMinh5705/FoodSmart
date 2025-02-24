<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật thông tin người dùng</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .img-thumbnail {
            max-width: 100px;
        }
        .address-block {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4 text-center">Cập nhật thông tin người dùng</h2>
    <form action="/manageUsers?action=updateInfoUser" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="accountID" value="${account.accountID}">

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

        <!-- Vai trò -->
        <div class="mb-3">
            <label class="form-label">Vai trò</label>
            <div class="form-check">
                <input type="radio" class="form-check-input" name="role"
                       value="Admin" ${account.role eq 'Admin' ? 'checked' : ''}>
                <label class="form-check-label"> Quản trị viên</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" name="role"
                       value="User" ${account.role eq 'User' ? 'checked' : ''}>
                <label class="form-check-label"> Người dùng </label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" name="role"
                       value="Merchant" ${account.role eq 'Merchant' ? 'checked' : ''}>
                <label class="form-check-label"> Chủ cửa hàng </label>
            </div>
        </div>

        <!-- Các địa chỉ đã lưu -->
        <div class="container">
            <div class="row">
                <c:forEach var="accountDetail" items="${accountDetails}" varStatus="status">
                    <div class="col-md-${accountDetails.size() > 1 ? 6 : 12} mb-3 address-block">
                        <div class="border rounded p-3">
                            <input type="hidden" name="accountDetailsID" value="${accountDetail.accountDetailID}">
                            <div class="form-check">
                                <input type="radio" class="form-check-input" name="isDefault"
                                       value="${accountDetail.accountDetailID}"
                                    ${accountDetail.isDefault ? 'checked="checked"' : ''}>
                                <label class="form-check-label">Mặc định</label>
                            </div>
                            <label class="form-label">Địa chỉ</label>
                            <textarea class="form-control" name="address_${accountDetail.accountDetailID}"
                                      placeholder="Nhập địa chỉ...">${accountDetail.address}</textarea>
                            <label class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" name="phonenumber_${accountDetail.accountDetailID}"
                                   value="${accountDetail.phonenumber}" placeholder="Nhập số điện thoại..."
                                   pattern="[0-9]{10,11}" title="Số điện thoại phải có 10 hoặc 11 chữ số">
                            <div class="d-flex justify-content-end mt-2">
                                <button type="button" class="btn btn-danger btn-sm"
                                        onclick="showDeleteModal({ id: ${accountDetail.accountDetailID}, url: '/manageUsers', action: 'deleteDetails' })">
                                    <i class="fa fa-trash"></i> Xóa
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="border border-primary rounded p-3 mb-3">
            <label class="form-label">Thêm địa chỉ mới</label>
            <div class="form-check">
                <input type="radio" class="form-check-input" name="isDefault" value="true">
                <label class="form-check-label">Mặc định</label>
            </div>
            <div class="mb-3">
                <label class="form-label">Địa chỉ</label>
                <textarea class="form-control" name="newAddress" placeholder="Nhập địa chỉ mới..."></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <input type="tel" class="form-control" name="newPhonenumber" pattern="[0-9]{10,11}"
                       title="Số điện thoại phải có 10 hoặc 11 chữ số" placeholder="Nhập số điện thoại...">
            </div>
            <button type="button" id="addAddressBtn" class="btn btn-primary">Thêm địa chỉ</button>
        </div>
        <div class="d-flex justify-content-center gap-2">
            <a href="/manageUsers" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
            <button type="submit" class="btn btn-primary">
                Cập nhật thông tin
            </button>
        </div>

    </form>
</div>
<!-- Modal xóa -->
<jsp:include page="../system/modalConfirmDelete.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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

    // Toggle hiển thị mật khẩu (phần script hiện có)
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

    function addNewAddress() {
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
    }

    document.addEventListener("DOMContentLoaded", function() {
        const addAddressButton = document.getElementById("addAddressBtn");
        addAddressButton.addEventListener("click", addNewAddress);
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
