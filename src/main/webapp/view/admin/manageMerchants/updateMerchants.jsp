<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center mb-4">
        <i class="fas fa-edit"></i> Cập nhật cửa hàng
    </h2>

    <div class="card shadow">
        <div class="card-body">
            <form action="/manageMerchants?action=updateMerchant" method="post" enctype="multipart/form-data">

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-store-alt"></i> Tên cửa hàng</label>
                    <input type="text" class="form-control" value="${merchant.store_name}" name="store_name" required
                           pattern=".*\S.*"
                           title="Tên cửa hàng không được để trống" minlength="2">
                </div>

                <!-- Avatar -->
                <label class="form-label"><i class="fas fa-user-circle"></i> Avatar</label>
                <div class="mb-3 text-center">
                    <div class="mb-2">
                        <img id="avtPreview" src="${pageContext.request.contextPath}/foodSmartImages/avatars/${merchant.avt_path}" alt="avatar"
                             class="img-fluid rounded-circle shadow" style="max-width: 130px; height: 130px">
                    </div>
                    <input type="hidden" value="${merchant.avt_path}" name="current_avt_path">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="avt_path" name="avt_path"
                               style="max-width: 400px;">
                        <label class="custom-file-label" for="avt_path">${merchant.avt_path}</label>
                    </div>
                </div>

                <!-- Banner -->
                <label class="form-label"><i class="fas fa-image"></i> Banner</label>
                <div class="mb-3 text-center">
                    <div class="mb-2">
                        <!-- Thêm id="bannerPreview" để update ảnh -->
                        <img id="bannerPreview" src="${pageContext.request.contextPath}/foodSmartImages/avatars/${merchant.banner_path}" alt="banner" class="img-fluid rounded shadow"
                             style="max-width: 250px;">
                    </div>
                    <input type="hidden" value="${merchant.banner_path}" name="current_banner_path">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="banner_path" name="banner_path"
                               style="max-width: 400px;">
                        <label class="custom-file-label" for="banner_path">${merchant.banner_path}</label>
                    </div>
                </div>


                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                    <input type="text" class="form-control" value="${merchant.store_address}" name="store_address"
                           required pattern=".*\S.*"
                           title="Địa chỉ không được để trống" minlength="2">
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-phone-alt"></i> Số điện thoại</label>
                    <input type="text" class="form-control" value="${merchant.contact_number}" name="contact_number"
                           required placeholder="Nhập số điện thoại" pattern="^0\d{9}$"
                           title="Số điện thoại phải có 10 số và bắt đầu bằng 0">
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-cogs"></i> Trạng thái</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="store_type"
                               value="true" ${merchant.store_type ? 'checked' : ''}>
                        <label class="form-check-label">
                            Hoạt động <i class="fas fa-check-circle text-success"></i>
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="store_type"
                               value="false" ${!merchant.store_type ? 'checked' : ''}>
                        <label class="form-check-label">
                            Khóa tài khoản <i class="fas fa-times-circle text-danger"></i>
                        </label>
                    </div>
                </div>

                <input type="hidden" name="store_id" value="${merchant.store_id}">

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Cập nhật
                    </button>
                    <a href="/manageMerchants" class="btn btn-danger ms-3">
                        <i class="bi bi-x-circle"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
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

        document.getElementById("banner_path").addEventListener("change", function () {
            updateFilePreview(this, 'bannerPreview');
        });

        document.getElementById("avt_path").addEventListener("change", function () {
            updateFilePreview(this, 'avtPreview');
        });
    });
</script>

</body>
</html>
