<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật cửa hàng</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            min-height: 100vh;
            font-family: 'Fantasy', sans-serif;
        }

        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            animation: fadeInUp 1s ease;
            background: #fff;
        }

        .card-header {
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            color: #fff;
            text-align: center;
            padding: 1.5rem;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .card-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: #333;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #6a11cb;
            box-shadow: 0 0 8px rgba(102, 17, 203, 0.2);
        }

        .btn-primary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #8E2DE2, #4A00E0);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(142, 45, 226, 0.4);
        }

        .btn-secondary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #FF416C, #FF4B2B);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
            color: #fff;
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 65, 108, 0.4);
        }

        .img-preview {
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .img-preview:hover {
            transform: scale(1.05);
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
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">
                    Cập nhật thông tin cửa hàng
                </div>
                <div class="card-body">
                    <form action="/manageStore?action=editMerchantStore" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="store_id" value="${store.store_id}">
                        <div class="mb-4">
                            <label class="form-label"><i class="fas fa-user-circle"></i> Bấm vào ảnh để chỉnh sửa</label>
                            <div class="text-center mb-3">
                                <img id="avtPreview"
                                     src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.avt_path}"
                                     alt="Avatar" class="img-fluid rounded-circle shadow img-preview"
                                     style="max-width: 120px; cursor: pointer;">
                            </div>
                            <input type="hidden" name="current_avt_path" value="${store.avt_path}">
                            <input type="file" class="d-none" id="avt_path" name="avt_path">
                        </div>

                        <div class="mb-4">
                            <label class="form-label"><i class="fas fa-image"></i> Bấm vào nền để chỉnh sửa</label>
                            <div class="text-center mb-3">
                                <img id="bannerPreview"
                                     src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.banner_path}"
                                     alt="Banner" class="img-fluid rounded shadow img-preview"
                                     style="max-width: 250px; cursor: pointer;">
                            </div>
                            <input type="hidden" name="current_banner_path" value="${store.banner_path}">
                            <input type="file" class="d-none" id="banner_path" name="banner_path">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Tên cửa hàng:</label>
                            <input type="text" name="store_name" value="${store.store_name}" class="form-control"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ:</label>
                            <input type="text" name="store_address" value="${store.store_address}" class="form-control"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">SĐT:</label>
                            <input type="text" name="contact_number" value="${store.contact_number}"
                                   class="form-control" required>
                        </div>

                        <div class="mb-4 form-check">
                            <input type="checkbox" class="form-check-input" id="store_type" name="store_type"
                                   value="true" <c:if test="${store.store_type}">checked</c:if>>
                            <label class="form-check-label" for="store_type">
                                Trạng thái (đánh dấu nếu cửa hàng đang hoạt động)
                            </label>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary me-3">Cập nhật</button>
                            <a href="/manageStore?action=showInfoStore" class="btn btn-secondary">Quay lại</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("avtPreview").addEventListener("click", function () {
        document.getElementById("avt_path").click();
    });

    document.getElementById("bannerPreview").addEventListener("click", function () {
        document.getElementById("banner_path").click();
    });

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
