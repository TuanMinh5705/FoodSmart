<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm sản phẩm</title>
    <!-- Font Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome cho icon -->
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

        /* Button cho Thêm sản phẩm */
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

        /* Button cho Huỷ */
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
            box-shadow: 0 8px 20px rgba(234, 177, 177, 0.8);
        }

        /* Button cho Thêm ảnh */
        .btn-upload {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2ecc71, #2dc26c); /* Gradient màu xanh lá */
            color: #fff;
            border: none;
            transition: transform 0.3s, box-shadow 0.3s, background 0.3s;
        }

        .btn-upload:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #2dc26c, #2ecc71); /* Đảo ngược gradient khi hover */
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.4);
            color: #fff;
        }


        /* Style cho vùng preview ảnh */
        #imagePreview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
            margin-bottom: 1rem;
        }

        #imagePreview img {
            border-radius: 10px;
            width: 100px;
            height: 100px;
            object-fit: cover;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2>Thêm Sản Phẩm</h2>
        </div>
        <form action="/manageFoods?action=addFood" method="post" enctype="multipart/form-data">
            <!-- Ảnh sản phẩm -->
            <div class="mb-3">
                <label class="form-label">Ảnh sản phẩm</label>
                <div id="imagePreview">
                    <!-- Hiển thị ảnh mặc định khi chưa chọn ảnh -->
                    <img src="https://via.placeholder.com/100" alt="Default Image">
                </div>
                <!-- Ẩn input file -->
                <input type="file" class="d-none" name="product_images" id="productImages" multiple accept="image/*"
                       onchange="previewImages()">
                <div class="text-center">
                    <button type="button" class="btn-upload"
                            onclick="document.getElementById('productImages').click();">
                        <i class="fas fa-plus"></i> Thêm ảnh
                    </button>
                </div>
            </div>
            <!-- Tên sản phẩm -->
            <div class="mb-3">
                <label class="form-label">Tên sản phẩm</label>
                <input type="text" class="form-control" name="product_name" required>
            </div>
            <!-- Giá -->
            <div class="mb-3">
                <label class="form-label">Giá</label>
                <input type="number" class="form-control" name="price" required>
            </div>
            <!-- Số lượng -->
            <div class="mb-3">
                <label class="form-label">Số lượng</label>
                <input type="number" class="form-control" name="stock_quantity" required>
            </div>
            <!-- Giảm giá (%) -->
            <div class="mb-3">
                <label class="form-label">Giảm giá (%)</label>
                <input type="number" class="form-control" name="discount" min="0" max="100">
            </div>
            <!-- Danh mục -->
            <div class="mb-3">
                <label class="form-label">Danh mục</label>
                <select class="form-select" name="category_id" required>
                    <c:forEach var="category" items="${categoryStoreList}">
                        <option value="${category.category_id}">${category.category_name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="text-center">
                <button type="submit" class="btn-primary me-3">
                    <i class="fas fa-plus-circle"></i> Thêm sản phẩm
                </button>
                <button type="button" class="btn-back"
                        onclick="window.location.href='/manageFoods?action=listFoodAndCategory';">
                    <i class="fas fa-times"></i> Huỷ
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hàm hiển thị preview ảnh
    function previewImages() {
        const preview = document.getElementById('imagePreview');
        preview.innerHTML = "";
        const files = document.getElementById('productImages').files;
        if (files.length === 0) {
            // Hiển thị ảnh mặc định nếu không có ảnh nào được chọn
            const defaultImg = document.createElement('img');
            defaultImg.src = 'https://via.placeholder.com/100';
            defaultImg.alt = 'Default Image';
            preview.appendChild(defaultImg);
        } else {
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                const reader = new FileReader();
                reader.onload = function (e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    preview.appendChild(img);
                };
                reader.readAsDataURL(file);
            }
        }
    }

    // Gọi preview khi trang được load (nếu cần)
    window.onload = function () {
        previewImages();
    };
</script>
</body>
</html>
