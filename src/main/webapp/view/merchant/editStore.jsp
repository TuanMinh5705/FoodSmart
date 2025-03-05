<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật cửa hàng</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }

        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .custom-container {
            max-width: 600px;
            margin: auto;
            padding: 50px 15px;
        }

        .profile-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 2rem 2rem 3rem;
            animation: fadeInUp 1s ease;
            position: relative;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .card-header h2 {
            margin: 0;
            color: #333;
        }

        .form-label {
            font-weight: 600;
            color: #555;
        }

        .form-control {
            border-radius: 50px;
            border: 1px solid #ddd;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #607d8b;
            box-shadow: 0 0 8px rgba(96, 125, 139, 0.2);
        }

        .btn-primary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            border: none;
            transition: background 0.3s, transform 0.3s, box-shadow 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #1E88E5, #2a9ffc);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
        }

        .btn-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn-back:hover {
            background: linear-gradient(90deg, #f55d5d, #f67272);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgb(234, 177, 177);
        }

        /* Khu vực hiển thị banner và avatar */
        .image-header {
            position: relative;
            margin-bottom: 80px; /* Tạo khoảng trống cho avatar tràn ra ngoài */
        }
        .banner-container {
            position: relative;
        }
        .banner-container img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }
        .avatar-container {
            position: absolute;
            bottom: -60px;
            left: 50%;
            transform: translateX(-50%);
        }
        .avatar-container img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            border: 4px solid #fff;
            cursor: pointer;
        }
        /* Icon pen */
        .pen-icon {
            cursor: pointer;
            transition: background 0.3s;
        }
        .banner-pen {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(0, 0, 0, 0.6);
            color: #fff;
            padding: 5px;
            border-radius: 50%;
            font-size: 0.8rem;
        }
        .avatar-pen {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: rgba(0, 0, 0, 0.6);
            color: #fff;
            padding: 4px;
            border-radius: 50%;
            font-size: 0.8rem;
        }
        .pen-icon:hover {
            background: rgba(0, 0, 0, 0.8);
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2 class="form-label fw-bold">Cập nhật thông tin cửa hàng</h2>
        </div>
        <!-- Phần banner và avatar kết hợp -->
        <div class="image-header">
            <div class="banner-container">
                <img id="bannerPreview"
                     src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.banner_path}"
                     alt="Banner">
                <i class="fas fa-pen pen-icon banner-pen" id="bannerPen"></i>
                <input type="hidden" name="current_banner_path" value="${store.banner_path}">
                <input type="file" class="d-none" id="banner_path" name="banner_path">
            </div>
            <div class="avatar-container">
                <img id="avtPreview"
                     src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.avt_path}"
                     alt="Avatar">
                <i class="fas fa-pen pen-icon avatar-pen" id="avtPen"></i>
                <input type="hidden" name="current_avt_path" value="${store.avt_path}">
                <input type="file" class="d-none" id="avt_path" name="avt_path">
            </div>
        </div>

        <form action="/manageStore?action=editMerchantStore" method="post" enctype="multipart/form-data">
            <input type="hidden" name="store_id" value="${store.store_id}">
            <div class="mb-3">
                <label class="form-label">Tên cửa hàng:</label>
                <input type="text" name="store_name" value="${store.store_name}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Địa chỉ:</label>
                <input type="text" name="store_address" value="${store.store_address}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Số điện thoại:</label>
                <input type="text" name="contact_number" value="${store.contact_number}" class="form-control" required>
            </div>

            <!-- Phần trạng thái cửa hàng -->
            <div class="mb-4 text-center">
                <label class="form-label d-block">Trạng thái cửa hàng:</label>
                <div class="d-flex justify-content-center">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="store_type" id="storeActive" value="true"
                               <c:if test="${store.store_type}">checked</c:if>>
                        <label class="form-check-label" for="storeActive">Đang hoạt động</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="store_type" id="storeInactive" value="false"
                               <c:if test="${!store.store_type}">checked</c:if>>
                        <label class="form-check-label" for="storeInactive">Không hoạt động</label>
                    </div>
                </div>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary me-4">Cập nhật</button>
                <button type="button" class="btn-back" onclick="location.href='/manageStore?action=showInfoStore'">
                    Quay lại
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khi click vào ảnh hoặc icon pen của avatar thì mở file input
    document.getElementById("avtPreview").addEventListener("click", function () {
        document.getElementById("avt_path").click();
    });
    document.getElementById("avtPen").addEventListener("click", function (e) {
        e.stopPropagation();
        document.getElementById("avt_path").click();
    });

    // Khi click vào ảnh hoặc icon pen của banner thì mở file input
    document.getElementById("bannerPreview").addEventListener("click", function () {
        document.getElementById("banner_path").click();
    });
    document.getElementById("bannerPen").addEventListener("click", function (e) {
        e.stopPropagation();
        document.getElementById("banner_path").click();
    });

    // Preview ảnh đại diện sau khi chọn file
    document.getElementById("avt_path").addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const avtPreview = document.getElementById("avtPreview");
                avtPreview.style.opacity = 0;
                setTimeout(() => {
                    avtPreview.src = e.target.result;
                    avtPreview.style.opacity = 1;
                }, 300);
            };
            reader.readAsDataURL(file);
        }
    });

    // Preview ảnh nền sau khi chọn file
    document.getElementById("banner_path").addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const bannerPreview = document.getElementById("bannerPreview");
                bannerPreview.style.opacity = 0;
                setTimeout(() => {
                    bannerPreview.src = e.target.result;
                    bannerPreview.style.opacity = 1;
                }, 300);
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>
