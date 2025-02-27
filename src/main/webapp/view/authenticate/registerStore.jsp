<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 27/02/2025
  Time: 11:19 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng ký cửa hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Custom file upload button style */
        .custom-file-upload {
            border: 1px solid #ccc;
            display: inline-block;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 4px;
            background-color: #f8f9fa;
        }
        .custom-file-upload input[type="file"] {
            display: none;
        }
        /* Style cho ảnh preview */
        .img-preview {
            margin-top: 10px;
            max-width: 100%;
            height: auto;
            display: none;
            border: 1px solid #ccc;
            padding: 5px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Đăng ký cửa hàng</h2>
    <form action="/authenticate?action=registerStore" method="POST" enctype="multipart/form-data">
        <!-- Tên cửa hàng -->
        <div class="mb-3">
            <label for="storeName" class="form-label">
                <i class="fas fa-store"></i> Tên cửa hàng
            </label>
            <input type="text" class="form-control" id="storeName" name="store_name"
                   placeholder="Nhập tên cửa hàng" required
                   pattern=".{3,255}"
                   title="Tên cửa hàng phải từ 3 đến 255 ký tự">
        </div>
        <!-- Địa chỉ cửa hàng -->
        <div class="mb-3">
            <label for="storeAddress" class="form-label">
                <i class="fas fa-map-marker-alt"></i> Địa chỉ cửa hàng
            </label>
            <textarea class="form-control" id="storeAddress" name="store_address" rows="3"
                      placeholder="Nhập địa chỉ cửa hàng" required
                      title="Vui lòng nhập địa chỉ cửa hàng"></textarea>
        </div>
        <!-- Số điện thoại -->
        <div class="mb-3">
            <label for="contactNumber" class="form-label">
                <i class="fas fa-phone"></i> Số điện thoại
            </label>
            <input type="tel" class="form-control" id="contactNumber" name="contact_number"
                   placeholder="Nhập số điện thoại" required
                   pattern="0[0-9]{9,10}"
                   title="Số điện thoại phải bắt đầu bằng số 0 và có từ 10 đến 11 chữ số">
        </div>
        <!-- Upload ảnh banner -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fas fa-image"></i> Ảnh banner
            </label>
            <div class="custom-file-upload">
                <input type="file" name="banner_path" id="bannerUpload" accept="image/*" title="Chọn ảnh banner">
                <label for="bannerUpload" class="mb-0">Chọn ảnh banner</label>
            </div>
            <!-- Thêm thẻ img để hiển thị preview ảnh banner -->
            <img id="bannerPreview" class="img-preview" alt="Ảnh banner preview">
        </div>
        <!-- Upload ảnh đại diện -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fas fa-user-circle"></i> Ảnh đại diện
            </label>
            <div class="custom-file-upload">
                <input type="file" name="avt_path" id="avatarUpload" accept="image/*" title="Chọn ảnh đại diện">
                <label for="avatarUpload" class="mb-0">Chọn ảnh đại diện</label>
            </div>
            <!-- Thêm thẻ img để hiển thị preview ảnh đại diện -->
            <img id="avatarPreview" class="img-preview" alt="Ảnh đại diện preview">
        </div>
        <input type="hidden" name="merchant_id" value="${sessionScope.loggedInAccount.accountID}">

        <button type="submit" class="btn btn-primary">
            <i class="fas fa-check"></i> Đăng ký
        </button>
        <a href="/homeUser">Quay lại trang chủ </a>
    </form>
</div>

<!-- Thêm JavaScript để xử lý preview ảnh -->
<script>
    // Hàm hiển thị ảnh preview
    function previewImage(input, previewId) {
        const preview = document.getElementById(previewId);
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            preview.src = '';
            preview.style.display = 'none';
        }
    }

    // Lắng nghe sự thay đổi của file input banner
    document.getElementById('bannerUpload').addEventListener('change', function() {
        previewImage(this, 'bannerPreview');
    });

    // Lắng nghe sự thay đổi của file input avatar
    document.getElementById('avatarUpload').addEventListener('change', function() {
        previewImage(this, 'avatarPreview');
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
