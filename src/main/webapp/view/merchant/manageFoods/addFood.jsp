<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm món ăn</title>
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        /* Định nghĩa biến cho background */
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        /* Định dạng toàn cục cho body */
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        /* Container chứa form */
        .custom-container {
            margin: 50px auto;
            padding: 15px;
        }
        /* Style cho thẻ card chứa form */
        .profile-card {
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
        /* Header của card */
        .card-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .card-header h2 {
            margin: 0;
            color: #333;
        }
        /* Nhãn và input */
        .form-label {
            font-weight: 600;
            color: #555;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            border-color: #607d8b;
            box-shadow: 0 0 8px rgba(96, 125, 139, 0.2);
        }
        /* Style cho các nút */
        .btn-primary {
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            border: none;
            color: #fff;
            transition: background 0.3s, box-shadow 0.3s, color 0.3s;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #1672c4, #2988d5);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
            color: #fff;
        }
        .btn-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s, box-shadow 0.3s, color 0.3s;
        }
        .btn-back:hover {
            background: linear-gradient(90deg, #d74a4a, #da5f5f);
            box-shadow: 0 8px 20px rgba(234, 177, 177, 0.8);
            color: #fff;
        }
        .btn-upload {
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #2ecc71, #2dc26c);
            color: #fff;
            border: none;
            transition: background 0.3s, box-shadow 0.3s, color 0.3s;
        }
        .btn-upload:hover {
            background: linear-gradient(90deg, #22a95b, #28b463);
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.4);
            color: #fff;
        }
        /* Hiệu ứng phóng to chỉ cho chữ trong các nút */
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
        /* Style cho vùng xem trước ảnh */
        #imagePreview {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin-bottom: 1rem;
        }
        #imagePreview img {
            border-radius: 15px;
            width: 120px;
            height: 120px;
            object-fit: contain;
            border: 1px solid #ddd;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        #imagePreview img:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="profile-card">
        <div class="card-header">
            <h2>Thêm món ăn</h2>
        </div>
        <form action="/manageFoods?action=addFood" method="post" enctype="multipart/form-data">
            <!-- Phần chọn ảnh sản phẩm -->
            <div class="mb-3">
                <label class="form-label">Ảnh món ăn</label>
                <div id="imagePreview">
                    <img src="https://via.placeholder.com/120" alt="Ảnh đại diện">
                </div>
                <!-- Input file ẩn -->
                <input type="file" class="d-none" name="product_images" id="productImages" multiple accept="image/*">
                <div class="text-center">
                    <button type="button" class="btn-upload" id="uploadBtn">
                        <span class="btn-text"><i class="fas fa-plus"></i> Thêm ảnh</span>
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
                <input type="number" class="form-control" name="discount" value="0" min="0" max="100">
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
            <!-- Nút xử lý -->
            <div class="text-center">
                <button type="submit" class="btn-primary me-3">
                    <span class="btn-text"><i class="fas fa-plus-circle"></i> Thêm sản phẩm</span>
                </button>
                <button type="button" class="btn-back" onclick="window.location.href='/manageFoods?action=listFoodAndCategory';">
                    <span class="btn-text"><i class="fas fa-times"></i> Huỷ</span>
                </button>
            </div>
        </form>
    </div>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Sự kiện mở input file khi nhấn nút "Thêm ảnh"
    document.getElementById('uploadBtn').addEventListener('click', function() {
        document.getElementById('productImages').click();
    });

    // Xử lý xem trước ảnh khi chọn file
    document.getElementById('productImages').addEventListener('change', function() {
        const preview = document.getElementById('imagePreview');
        preview.innerHTML = "";
        const files = this.files;
        if (files.length === 0) {
            const defaultImg = document.createElement('img');
            defaultImg.src = 'https://via.placeholder.com/120';
            defaultImg.alt = 'Default Image';
            preview.appendChild(defaultImg);
        } else {
            Array.from(files).forEach(file => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    preview.appendChild(img);
                };
                reader.readAsDataURL(file);
            });
        }
    });

    // Khởi tạo xem trước ảnh khi trang load (nếu cần)
    window.addEventListener('load', function() {
        document.getElementById('productImages').dispatchEvent(new Event('change'));
    });
</script>
</body>
</html>
