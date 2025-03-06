<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập nhật món ăn</title>
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        /* CSS Variables cho màu sắc và giao diện */
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --primary-gradient: linear-gradient(90deg, #3498db, #2980b9);
            --secondary-gradient: linear-gradient(90deg, #2ecc71, #27ae60);
            --danger-gradient: linear-gradient(90deg, #e74c3c, #c0392b);
            --bg-light: #ffffff;
            --bg-dark: #ecf0f1;
            --text-color: #2c3e50;
            --card-shadow: rgba(44, 62, 80, 0.1);
            --hover-shadow: rgba(44, 62, 80, 0.15);
        }
        /* Global Styles */
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-family: 'Poppins', sans-serif;
            color: var(--text-color);
            margin: 0;
            padding: 20px;
        }
        /* Container chính */
        .custom-container {
            max-width: 1000px;
            margin: auto;
        }
        /* Tiêu đề trang */
        h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 2rem;
            color: var(--primary-color);
        }
        /* Card */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--bg-light);
            box-shadow: 0 4px 20px var(--card-shadow);
            margin-bottom: 2rem;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-3px);
        }
        .card-header {
            background: transparent;
            padding: 1.5rem;
            font-size: 1.75rem;
            font-weight: 700;
            text-align: center;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .card-body {
            padding: 1.5rem 2rem;
        }
        /* Form */
        .form-label {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border-radius: 10px;
        }
        /* Button */
        .btn {
            border-radius: 50px;
            transition: transform 0.3s, box-shadow 0.3s;
            border: none !important;
        }
        .btn:focus,
        .btn:active {
            outline: none !important;
            box-shadow: none !important;
        }
        .btn-primary {
            background: var(--primary-gradient);
            padding: 0.65rem 2rem;
            font-weight: 600;
        }
        .btn-primary:hover {
            box-shadow: 0 6px 15px var(--hover-shadow);
            transform: translateY(-2px);
        }
        .btn-secondary {
            background: var(--secondary-gradient);
            padding: 0.65rem 2rem;
            font-weight: 600;
        }
        .btn-secondary:hover {
            box-shadow: 0 6px 15px var(--hover-shadow);
            transform: translateY(-2px);
        }
        .btn-cancel {
            background: linear-gradient(90deg, #ff7f7f, #ff4d4d);
            padding: 0.65rem 2rem;
            font-weight: 600;
            border-radius: 50px;
            transition: transform 0.3s, box-shadow 0.3s;
            color: #fff !important;
        }
        .btn-cancel:hover {
            box-shadow: 0 6px 15px var(--hover-shadow);
            transform: translateY(-2px);
        }
        /* Ảnh: giới hạn kích thước mỗi ảnh 100px x 100px */
        .img-thumbnail {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px var(--card-shadow);
            object-fit: cover;
        }
        .image-slot {
            width: 50px;
            height: 50px;
        }
    </style>
</head>
<body>
<main class="container my-4 custom-container">
    <article class="card">
        <header class="card-header">
            Cập nhật món ăn
        </header>
        <div class="card-body">
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
                    <h4 class="mb-3">Danh sách ảnh:</h4>
                    <div class="row g-3" id="imageContainer">
                        <c:forEach var="img" items="${food.list_food_images}" varStatus="status">
                            <div class="col-md-4">
                                <div class="card">
                                    <img id="imgPreview_${img.image_id}"
                                         src="${pageContext.request.contextPath}/foodSmartImages/product/${img.image_path}"
                                         class="img-thumbnail card-img-top image-slot" alt="Ảnh món ăn">
                                    <div class="card-body text-center">
                                        <label class="form-check-label">Ảnh chính:</label>
                                        <input type="radio" name="primary_image" value="${img.image_id}"
                                            ${img.is_primary ? 'checked' : (status.first ? 'checked' : '')}>
                                        <div class="mt-3">
                                            <label for="image_${img.image_id}" class="btn btn-outline-success">
                                                <i class="fas fa-sync-alt"></i> Cập nhật ảnh
                                            </label>
                                            <input type="file" id="image_${img.image_id}" name="img_path_${img.image_id}" class="d-none"
                                                   accept="image/*">
                                            <input type="hidden" name="currentImgPath_${img.image_id}" value="${img.image_path}">
                                        </div>
                                        <button type="button" class="btn btn-danger btn-sm mt-3"
                                                onclick="showDeleteModal({ id: '${img.image_id}', url: 'manageFoods', action: 'deleteImage' });">
                                            <i class="fas fa-trash"></i> Xóa ảnh
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
                <!-- Phần thêm ảnh mới -->
                <section class="mb-4">
                    <label class="form-label">Thêm ảnh sản phẩm</label>
                    <input type="file" class="d-none" name="product_images" id="productImages" multiple accept="image/*">
                    <div id="imagePreview" class="d-flex flex-wrap justify-content-center mt-2"></div>
                    <div class="text-center mt-2">
                        <button type="button" class="btn btn-secondary" id="addImagesBtn">
                            <i class="fas fa-plus"></i> Thêm ảnh
                        </button>
                    </div>
                </section>
                <!-- Nút xử lý -->
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-sync-alt"></i> Cập nhật
                    </button>
                    <button type="button" class="btn btn-cancel ms-3" onclick="window.location.href='/manageFoods';">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                </div>
            </form>
        </div>
    </article>
</main>

<jsp:include page="../../admin/system/modalConfirmDelete.jsp"/>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hàm hiển thị preview cho ảnh được thêm mới
    function previewImages() {
        const preview = document.getElementById('imagePreview');
        const files = document.getElementById('productImages').files;
        preview.innerHTML = '';
        Array.from(files).forEach(file => {
            const reader = new FileReader();
            reader.onload = function(e) {
                const div = document.createElement('div');
                div.className = 'm-1 text-center';
                const img = document.createElement('img');
                img.src = e.target.result;
                // Sử dụng class image-slot để đảm bảo kích thước 100px x 100px
                img.className = 'img-thumbnail image-slot';
                div.appendChild(img);
                // Nút xóa từng preview ảnh
                const deleteBtn = document.createElement('button');
                deleteBtn.type = 'button';
                deleteBtn.className = 'btn btn-danger btn-sm mt-2';
                deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
                deleteBtn.addEventListener('click', function() {
                    div.remove();
                });
                div.appendChild(deleteBtn);
                preview.appendChild(div);
            };
            reader.readAsDataURL(file);
        });
    }

    // Gán sự kiện cho các nút và input file
    document.getElementById('addImagesBtn').addEventListener('click', function() {
        document.getElementById('productImages').click();
    });
    document.getElementById('productImages').addEventListener('change', previewImages);
</script>
</body>
</html>
