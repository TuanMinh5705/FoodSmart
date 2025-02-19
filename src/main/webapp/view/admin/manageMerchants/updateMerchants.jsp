<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center mb-4">Cập nhật cửa hàng</h2>

    <div class="card shadow">
        <div class="card-body">
            <form action="/manageMerchants?action=updateMerchant" method="post" enctype="multipart/form-data">

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-store-alt"></i> Tên cửa hàng</label>
                    <input type="text" class="form-control" value="${merchant.store_name}" name="store_name" required>
                </div>

                <label class="form-label"><i class="fas fa-image"></i> Banner</label>
                <div class="mb-3 text-center">
                    <div class="mb-2">
                        <img src="/images/avatars/${merchant.banner_path}" alt="banner" class="img-fluid rounded shadow"
                             style="max-width: 250px;">
                    </div>
                    <input type="hidden" value="${merchant.banner_path}" name="current_banner_path">
                    <input type="file" class="form-control mx-auto d-block" name="banner_path"
                           style="max-width: 400px;">
                </div>

                <label class="form-label"><i class="fas fa-user-circle"></i> Avatar</label>
                <div class="mb-3 text-center">
                    <div class="mb-2">
                        <img src="/images/avatars/${merchant.avt_path}" alt="avatar"
                             class="img-fluid rounded-circle shadow" style="max-width: 120px;">
                    </div>
                    <input type="hidden" value="${merchant.avt_path}" name="current_avt_path">
                    <input type="file" class="form-control mx-auto d-block" name="avt_path" style="max-width: 400px;">
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                    <input type="text" class="form-control" value="${merchant.store_address}" name="store_address"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-phone-alt"></i> Số điện thoại</label>
                    <input type="text" class="form-control" value="${merchant.contact_number}" name="contact_number"
                           required>
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
                    <button type="submit" class="btn btn-success px-4">
                        <i class="fas fa-save"></i> Cập nhật
                    </button>
                    <a href="/manageMerchants" class="btn btn-danger px-4 ms-3">
                        <i class="fas fa-times-circle"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
