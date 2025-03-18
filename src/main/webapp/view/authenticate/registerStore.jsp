<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 27/02/2025
  Time: 11:19 CH
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
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .card-header {
            background-color: #fff;
            border-bottom: none;
            text-align: center;
            padding: 20px;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .card-header h2 {
            color: #5563de;
            font-weight: 700;
        }
        /* Avatar preview styling */
        #avatarPreview {
            margin-top: 10px;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: contain;
            border: 3px solid #dcdcdc;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            display: none;
        }
        /* Banner preview styling */
        #bannerPreview {
            margin-top: 10px;
            width: 100%;
            height: 200px;
            object-fit: contain;
            border: 3px solid #dcdcdc;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            display: none;
        }
        .btn-primary {
            background-color: #5563DE;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #4651b5;
        }
        .form-label i {
            color: #696969;
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h2>Đăng ký cửa hàng</h2>
                </div>
                <div class="card-body">
                    <form action="/authenticate?action=registerStore" method="POST" enctype="multipart/form-data">
                        <!-- Upload ảnh đại diện -->
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="fas fa-user-circle"></i> Ảnh đại diện
                            </label>
                            <br>
                            <button type="button" class="btn btn-secondary mt-1" onclick="document.getElementById('avatarUpload').click()">
                                Chọn ảnh đại diện
                            </button>
                            <input type="file" name="avt_path" id="avatarUpload" accept="image/*" title="Chọn ảnh đại diện" style="display: none;">
                            <img id="avatarPreview" alt="Ảnh đại diện preview">
                        </div>
                        <!-- Upload ảnh banner -->
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="fas fa-image"></i> Ảnh nền
                            </label>
                            <br>
                            <button type="button" class="btn btn-secondary mt-1" onclick="document.getElementById('bannerUpload').click()">
                                Chọn ảnh hình nền
                            </button>
                            <input type="file" name="banner_path" id="bannerUpload" accept="image/*" title="Chọn ảnh banner" style="display: none;">
                            <img id="bannerPreview" alt="Ảnh banner preview">
                        </div>
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
                        <input type="hidden" name="merchant_id" value="${sessionScope.loggedInAccount.accountID}">
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check"></i> Đăng ký
                            </button>
                        </div>
                        <div class="text-center mt-3">
                            <a href="/homeUser" class="text-decoration-none">Quay lại trang chủ</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript xử lý preview ảnh -->
<script>
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
    document.getElementById('avatarUpload').addEventListener('change', function() {
        previewImage(this, 'avatarPreview');
    });
    document.getElementById('bannerUpload').addEventListener('change', function() {
        previewImage(this, 'bannerPreview');
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
