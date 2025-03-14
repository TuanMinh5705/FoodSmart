<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUa6mYbO0WfT3Q9F/Sk70Pf9K57a05c7AA8j8T94WrHftjDbrCEXSU1oBoq5" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #eef2f7;
        }
        .profile-card {
            max-width: 700px;
            margin: 20px auto;
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .profile-banner {
            position: relative;
            height: 200px;
        }
        .banner-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .profile-avatar {
            position: absolute;
            left: 50%;
            bottom: -50px;
            transform: translateX(-50%);
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 5px solid #fff;
            object-fit: cover;
            box-shadow: 0 0 8px rgba(0,0,0,0.15);
        }

        .edit-btn {
            width: 30px;
            height: 30px;
            position: absolute;
            background: rgba(0,0,0,0.5);
            border: none;
            color: #fff;
            border-radius: 50%;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }
        .edit-btn:hover {
            background: rgba(0,0,0,0.8);
            transform: scale(1.1);
        }
        .banner-edit {
            top: 10px;
            right: 10px;
        }
        .avatar-edit {
            bottom: 10px;
            right: calc(50% - 50px);
        }
        .profile-body {
            margin-top: 60px;
            padding: 20px;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-custom {
            border-radius: 50px;
            padding: 0.5rem 2rem;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <form action="/manageMerchants?action=updateMerchant" method="post" enctype="multipart/form-data">
        <div class="card profile-card">
            <div class="profile-banner">
                <!-- Banner -->
                <img id="bannerPreview" src="${pageContext.request.contextPath}/images/avatars/${merchant.banner_path}" alt="Banner" class="banner-img">
                <!-- Nút chỉnh sửa banner -->
                <button type="button" class="edit-btn banner-edit" onclick="document.getElementById('banner_path').click();">
                    <i class="bi bi-pencil"></i>
                </button>
                <input type="hidden" name="current_banner_path" value="${merchant.banner_path}">
                <input type="file" class="d-none" id="banner_path" name="banner_path" accept="image/*">

                <!-- Avatar -->
                <img id="avtPreview" src="${pageContext.request.contextPath}/images/avatars/${merchant.avt_path}" alt="Avatar" class="profile-avatar">
                <!-- Nút chỉnh sửa avatar -->
                <button type="button" class="edit-btn avatar-edit" onclick="document.getElementById('avt_path').click();">
                    <i class="bi bi-pencil"></i>
                </button>
                <input type="hidden" name="current_avt_path" value="${merchant.avt_path}">
                <input type="file" class="d-none" id="avt_path" name="avt_path" accept="image/*">
            </div>
            <div class="card-body profile-body">
                <!-- Tên cửa hàng -->
                <div class="mb-3">
                    <label class="form-label">Tên cửa hàng</label>
                    <input type="text" class="form-control" value="${merchant.store_name}" name="store_name" required
                           pattern=".*\S.*" title="Tên cửa hàng không được để trống" minlength="2">
                </div>
                <!-- Địa chỉ -->
                <div class="mb-3">
                    <label class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" value="${merchant.store_address}" name="store_address" required
                           pattern=".*\S.*" title="Địa chỉ không được để trống" minlength="2">
                </div>
                <!-- Số điện thoại -->
                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" value="${merchant.contact_number}" name="contact_number"
                           required placeholder="Nhập số điện thoại" pattern="^0\d{9}$"
                           title="Số điện thoại phải có 10 số và bắt đầu bằng 0">
                </div>
                <!-- Trạng thái -->
                <div class="mb-3">
                    <label class="form-label">Trạng thái</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="store_type" value="true" ${merchant.store_type ? 'checked' : ''}>
                        <label class="form-check-label">Hoạt động</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="store_type" value="false" ${!merchant.store_type ? 'checked' : ''}>
                        <label class="form-check-label">Khóa tài khoản</label>
                    </div>
                </div>
                <input type="hidden" name="store_id" value="${merchant.store_id}">
                <!-- Nút cập nhật và hủy -->
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success btn-custom">
                        <i class="bi bi-save"></i> Cập nhật
                    </button>
                    <a href="/manageMerchants" class="btn btn-danger btn-custom ms-3">
                        <i class="bi bi-x-circle"></i> Hủy
                    </a>
                </div>
            </div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+AMvyTG2x04QnEJwB07x9JvoRxT2M"
        crossorigin="anonymous"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        function updateFilePreview(input, previewId) {
            if (input.files.length > 0) {
                const file = input.files[0];
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById(previewId).src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
        document.getElementById("avt_path").addEventListener("change", function () {
            updateFilePreview(this, 'avtPreview');
        });
        document.getElementById("banner_path").addEventListener("change", function () {
            updateFilePreview(this, 'bannerPreview');
        });
    });
</script>
</body>
</html>
