<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật cửa hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center mb-4">Cập nhật cửa hàng</h2>

    <div class="card shadow">
        <div class="card-body">
            <form action="/manageMerchants?action=updateMerchant" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">Tên cửa hàng</label>
                    <input type="text" class="form-control" value="${merchant.store_name}" name="store_name" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Banner</label>
                    <div class="mb-2">
                        <img src="/images/avatars/${merchant.banner_path}" alt="banner" class="img-fluid rounded" style="max-width: 200px;">
                    </div>
                    <input type="hidden" value="${merchant.banner_path}" name="current_banner_path">
                    <input type="file" class="form-control" name="banner_path">
                </div>

                <div class="mb-3">
                    <label class="form-label">Avatar</label>
                    <div class="mb-2">
                        <img src="/images/avatars/${merchant.avt_path}" alt="avatar" class="img-fluid rounded-circle" style="max-width: 100px;">
                    </div>
                    <input type="hidden" value="${merchant.avt_path}" name="current_avt_path">
                    <input type="file" class="form-control" name="avt_path">
                </div>

                <div class="mb-3">
                    <label class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" value="${merchant.store_address}" name="store_address" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" value="${merchant.contact_number}" name="contact_number" required>
                </div>

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

                <div class="text-center">
                    <button type="submit" class="btn btn-success">Cập nhật</button>
                    <a href="/manageMerchants" class="btn btn-danger">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
