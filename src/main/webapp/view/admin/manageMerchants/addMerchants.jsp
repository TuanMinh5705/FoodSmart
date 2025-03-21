<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="bi bi-plus-circle-fill"></i> Thêm Cửa Hàng
    </h2>

    <div class="card shadow p-4">
        <form action="/manageMerchants?action=addMerchant" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label class="form-label">Tên cửa hàng</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-store-alt"></i></span>
                    <input type="text" class="form-control" name="store_name" required
                           placeholder="Nhập tên cửa hàng"
                           pattern=".*\S.*"
                           title="Tên cửa hàng không được để trống">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Địa chỉ</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                    <input type="text" class="form-control" name="store_address" required placeholder="Nhập địa chỉ" pattern=".*\S.*"
                           title="Tên cửa hàng không được để trống">>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-phone-alt"></i></span>
                    <input type="text" class="form-control" name="contact_number" required
                           placeholder="Nhập số điện thoại"
                           pattern="^0\d{9}$"
                           title="Số điện thoại phải có 10 số và bắt đầu bằng 0">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Banner</label>
                <input type="file" class="form-control" name="banner_path" id="bannerInput" onchange="previewImage(event, 'bannerPreview')">
                <img id="bannerPreview" src="#" class="img-fluid mt-2 d-none object-fit-contain" style="max-height: 200px;">
            </div>

            <div class="mb-3">
                <label class="form-label">Avatar</label>
                <input type="file" class="form-control" name="avt_path" id="avatarInput" onchange="previewImage(event, 'avatarPreview')">
                <img id="avatarPreview" src="#" class="img-fluid mt-2 d-none object-fit-contain" style="max-height: 100px; border-radius: 50%;">
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4">

                <button type="submit" class="btn btn-success">
                    <i class="bi bi-check-circle"></i> Thêm cửa hàng
                </button>
                <a href="/manageMerchants" class="btn btn-danger">
                    <i class="bi bi-x-circle"></i> Hủy
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    function previewImage(event, previewId) {
        let reader = new FileReader();
        reader.onload = function () {
            let preview = document.getElementById(previewId);
            preview.src = reader.result;
            preview.classList.remove("d-none");
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
