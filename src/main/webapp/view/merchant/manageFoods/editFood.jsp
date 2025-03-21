<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa món ăn</title>
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-size: 18px;
            font-weight: 750;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        /* Giảm chiều rộng tổng thể của trang */
        .custom-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 15px;
        }
        /* Card cập nhật món ăn */
        .profile-card {
            width: 100%;
            max-width: 750px;
            margin: 0 auto;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 2rem 2rem 3rem;
            animation: fadeInUp 1s ease;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
        .form-control,
        .form-select {
            border-radius: 8px;
            border: 1px solid #ddd;
            transition: border-color 0.3s;
        }
        .form-control:focus,
        .form-select:focus {
            border-color: #607d8b;
            box-shadow: 0 0 8px rgba(96, 125, 139, 0.2);
        }
        /* Button chính (.btn-primary) */
        .btn-primary {
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            border: none;
            transition: background 0.3s, transform 0.3s, box-shadow 0.3s, color 0.3s;
            color: #fff;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #1672c4, #2988d5);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
        }
        /* Button quay lại (.btn-back) */
        .btn-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s, color 0.3s;
        }
        .btn-back:hover {
            background: linear-gradient(90deg, #d74a4a, #da5f5f);
            box-shadow: 0 8px 20px rgba(234, 177, 177, 0.8);
        }
        /* Button thêm ảnh (.btn-upload) */
        .btn-upload {
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2ecc71, #29c069);
            color: #fff;
            border: none;
            transition: background 0.3s, transform 0.3s, box-shadow 0.3s, color 0.3s;
        }
        .btn-upload:hover {
            background: linear-gradient(90deg, #22a95b, #28b463);
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.4);
        }
        /* Hiệu ứng phóng to chỉ cho chữ trong button */
        .btn-primary .btn-text,
        .btn-back .btn-text,
        .btn-upload .btn-text {
            display: inline-block;
            transition: transform 0.3s ease-in-out;
        }
        .btn-primary:hover .btn-text,
        .btn-back:hover .btn-text,
        .btn-upload:hover .btn-text {
            transform: scale(1.2);
        }
        /* Vùng xem trước ảnh cho ảnh mới */
        #imagePreview {
            align-items: center;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 1rem;
        }
        #imagePreview img {
            border-radius: 10px;
            width: 100px;
            height: 100px;
            border: 1px solid #ddd;
            object-fit: contain;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        /* Danh sách ảnh hiện có: ảnh nhỏ hơn và cách nhau 30px */
        #imageContainer {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
        }
        #imageContainer .image-item {
            text-align: center;
        }
        #imageContainer img {
            width: 120px;
            height: 120px;
            object-fit: contain;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        /* CSS cho container của ảnh có vị trí relative */
        .img-wrapper {
            position: relative;
            display: inline-block;
        }
        /* CSS cho icon xoá ảnh nằm ở góc trên bên phải */
        .delete-icon {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(255, 255, 255, 0.7);
            border: 1px solid #ddd;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 2;
            transition: background 0.3s, color 0.3s;
        }
        .delete-icon:hover {
            background: rgb(250, 101, 101);
        }
        .delete-icon:hover i {
            color: #ffffff;
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2>Chỉnh sửa món ăn</h2>
        </div>
        <form action="/manageFoods?action=updateFood" method="post" enctype="multipart/form-data" id="updateFoodForm">
            <!-- Thông tin món ăn -->
            <input type="hidden" name="product_id" value="${food.product_id}">
            <div class="mb-3">
                <label class="form-label">Tên món ăn:</label>
                <input type="text" name="product_name" value="${food.product_name}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Giá:</label>
                <input type="number" name="price" value="${food.price}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Số lượng trong kho:</label>
                <input type="number" name="stock_quantity" value="${food.stock_quantity}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Giảm giá (%):</label>
                <input type="number" name="discount" value="${food.discount}" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Danh mục:</label>
                <select name="category_id" class="form-select" required>
                    <c:forEach var="category" items="${categoryFoodList}">
                        <option value="${category.category_id}" ${category.category_id == food.category_id ? 'selected' : ''}>
                                ${category.category_name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <!-- Danh sách ảnh hiện có -->
            <section class="mb-4">
                <h4 class="mb-3 text-center">Danh sách ảnh:</h4>
                <div id="imageContainer">
                    <c:forEach var="img" items="${food.list_food_images}" varStatus="status">
                        <div class="image-item">
                            <!-- Container ảnh với vị trí relative -->
                            <div class="img-wrapper">
                                <img id="imgPreview_${img.image_id}"
                                     src="${pageContext.request.contextPath}/images/product/${img.image_path}"
                                     class="img-thumbnail" alt="Ảnh món ăn">
                                <!-- Icon xoá (dấu X) nằm ở góc trên bên phải của ảnh -->
                                <button type="button" class="delete-icon" onclick="showDeleteModal({ id: '${img.image_id}', url: 'manageFoods', action: 'deleteImage' });">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <div class="mt-2">
                                <label class="form-check-label">Ảnh chính:</label>
                                <input type="radio" name="primary_image" value="${img.image_id}"
                                    ${img.is_primary ? 'checked' : (status.first ? 'checked' : '')}>
                            </div>
                            <div class="mt-2">
                                <label for="image_${img.image_id}" class="btn btn-outline-success">
                                    <span class="btn-text"><i class="fas fa-pencil-alt"></i> Chỉnh sửa</span>
                                </label>
                                <input type="file" id="image_${img.image_id}" name="img_path_${img.image_id}" class="d-none"
                                       accept="image/*">
                                <input type="hidden" name="currentImgPath_${img.image_id}" value="${img.image_path}">
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
            <!-- Phần thêm ảnh mới -->
            <section class="mb-4">
                <input type="file" class="d-none" name="product_images" id="productImages" multiple accept="image/*">
                <div id="imagePreview"></div>
                <div class="text-center mt-3">
                    <button type="button" class="btn-upload" id="addImagesBtn">
                        <span class="btn-text"><i class="fas fa-plus"></i> Thêm ảnh</span>
                    </button>
                </div>
            </section>
            <!-- Nút xử lý -->
            <div class="text-center">
                <button type="submit" class="btn-primary me-3">
                    <span class="btn-text"><i class="fas fa-sync-alt"></i> Cập nhật</span>
                </button>
                <button type="button" class="btn-back" onclick="window.location.href='/manageFoods';">
                    <span class="btn-text"><i class="fas fa-times"></i> Huỷ</span>
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../../admin/system/modalConfirmDelete.jsp"/>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hàm hiển thị preview cho ảnh được thêm mới với icon xoá dạng icon tròn
    function previewImages() {
        const preview = document.getElementById('imagePreview');
        const files = document.getElementById('productImages').files;
        preview.innerHTML = '';
        Array.from(files).forEach(file => {
            const reader = new FileReader();
            reader.onload = function(e) {
                // Tạo container với class 'img-wrapper' để có vị trí relative
                const wrapper = document.createElement('div');
                wrapper.className = 'img-wrapper text-center';

                // Tạo thẻ img hiển thị preview
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.width = '100px';
                img.style.height = '100px';
                img.style.objectFit = 'contain';
                img.style.borderRadius = '10px';
                wrapper.appendChild(img);

                // Tạo icon xoá ảnh (button với class 'delete-icon')
                const deleteIcon = document.createElement('button');
                deleteIcon.type = 'button';
                deleteIcon.className = 'delete-icon';
                deleteIcon.innerHTML = '<i class="fas fa-times"></i>';
                deleteIcon.addEventListener('click', function() {
                    wrapper.remove();
                });
                wrapper.appendChild(deleteIcon);

                preview.appendChild(wrapper);
            };
            reader.readAsDataURL(file);
        });
    }
    // Sự kiện kích hoạt input file
    document.getElementById('addImagesBtn').addEventListener('click', function() {
        document.getElementById('productImages').click();
    });
    document.getElementById('productImages').addEventListener('change', previewImages);

    document.querySelectorAll('input[type="file"][id^="image_"]').forEach(function(fileInput) {
        fileInput.addEventListener('change', function (e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    // Lấy id từ input (ví dụ: image_123 -> 123)
                    const id = fileInput.id.split('_')[1];
                    const imgPreview = document.getElementById('imgPreview_' + id);
                    if (imgPreview) {
                        imgPreview.src = e.target.result;
                    }
                }
                reader.readAsDataURL(file);
            }
        });
    });
</script>
</body>
</html>
