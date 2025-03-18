<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng ký cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
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
        #avatarPreview, #bannerPreview {
            display: none;
            margin-top: 10px;
            border: 3px solid #dcdcdc;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .btn-primary {
            background-color: #5563DE;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #4651b5;
        }
        .terms-box {
            max-height: 150px;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 5px;
            margin-bottom: 10px;
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
                            <label class="form-label"><i class="fas fa-user-circle"></i> Ảnh đại diện</label><br>
                            <button type="button" class="btn btn-secondary mt-1" onclick="document.getElementById('avatarUpload').click()">
                                Chọn ảnh đại diện
                            </button>
                            <input type="file" name="avt_path" id="avatarUpload" accept="image/*" style="display: none;">
                            <img id="avatarPreview" alt="Ảnh đại diện" width="120" height="120">
                        </div>
                        <!-- Upload ảnh banner -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-image"></i> Ảnh nền</label><br>
                            <button type="button" class="btn btn-secondary mt-1" onclick="document.getElementById('bannerUpload').click()">
                                Chọn ảnh hình nền
                            </button>
                            <input type="file" name="banner_path" id="bannerUpload" accept="image/*" style="display: none;">
                            <img id="bannerPreview" alt="Ảnh banner" width="100%" height="200">
                        </div>
                        <!-- Upload tài liệu đăng ký -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-file-alt"></i> Tài liệu đăng ký</label><br>
                            <input type="file" class="form-control" name="register_file" accept=".pdf,.doc,.docx" required>
                            <small class="text-muted">Chỉ chấp nhận file PDF, DOC, DOCX.</small>
                        </div>
                        <!-- Tên cửa hàng -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-store"></i> Tên cửa hàng</label>
                            <input type="text" class="form-control" name="store_name" placeholder="Nhập tên cửa hàng" required>
                        </div>
                        <!-- Địa chỉ cửa hàng -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                            <textarea class="form-control" name="store_address" rows="3" placeholder="Nhập địa chỉ" required></textarea>
                        </div>
                        <!-- Số điện thoại -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-phone"></i> Số điện thoại</label>
                            <input type="tel" class="form-control" name="contact_number" placeholder="Nhập số điện thoại" required>
                        </div>
                        <!-- Điều khoản dịch vụ -->
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-file-contract"></i> Điều khoản dịch vụ</label>
                            <div class="terms-box">
                                <p><strong>1. Điều kiện sử dụng:</strong> Bạn đồng ý cung cấp thông tin chính xác về cửa hàng của mình.</p>
                                <p><strong>2. Bảo mật:</strong> Chúng tôi cam kết bảo vệ thông tin của bạn.</p>
                                <p><strong>3. Trách nhiệm:</strong> Bạn chịu trách nhiệm về nội dung đăng tải trên hệ thống.</p>
                                <p><strong>4. Chấm dứt dịch vụ:</strong> Hệ thống có quyền từ chối hoặc gỡ bỏ cửa hàng nếu vi phạm điều khoản.</p>
                            </div>
                            <div class="form-check mt-2">
                                <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">Tôi đã đọc và đồng ý với điều khoản dịch vụ</label>
                            </div>
                        </div>
                        <input type="hidden" name="merchant_id" value="${sessionScope.loggedInAccount.accountID}">
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Đăng ký</button>
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
