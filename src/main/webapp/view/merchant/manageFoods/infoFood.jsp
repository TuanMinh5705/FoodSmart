<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết sản phẩm</title>
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        /* Container với chiều rộng 700px */
        .custom-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 15px;
        }
        /* Card chi tiết sản phẩm */
        .detail-card {
            width: 100%;
            max-width: 700px;
            margin: 0 auto;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 2rem;
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
        p {
            margin: 0;
        }
        .detail-info {
            margin-bottom: 1rem;
        }
        /* Style cho phần hiển thị hình ảnh */
        .image-slot {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #ddd; /* Border nhạt cho ảnh */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        #imageContainer {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
        }
        .image-item {
            text-align: center;
        }
        /* Style cho nút Quay lại */
        .btn-back {
            background: linear-gradient(90deg, #f67272, #f55d5d);
            color: #fff;
            text-decoration: none; /* Loại bỏ gạch chân */
            border: none;
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.3s, color 0.3s;
        }
        .btn-back:hover {
            background: linear-gradient(90deg, #f55d5d, #f67272);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(234, 177, 177, 0.8);
            color: #000; /* Khi hover chuyển chữ thành màu đen */
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <div class="detail-card">
        <div class="card-header">
            <h2>Chi tiết sản phẩm</h2>
        </div>
        <div class="detail-info">
            <label class="form-label">Tên món ăn:</label>
            <p>${food.product_name}</p>
        </div>
        <div class="detail-info">
            <label class="form-label">Giá:</label>
            <p><fmt:formatNumber value="${food.price}" pattern="#,###" /> đ</p>
        </div>
        <div class="detail-info">
            <label class="form-label">Số lượng trong kho:</label>
            <p>${food.stock_quantity}</p>
        </div>
        <div class="detail-info">
            <label class="form-label">Giảm giá (%):</label>
            <p>${food.discount}</p>
        </div>
        <div class="detail-info">
            <label class="form-label">Danh mục:</label>
            <p>${categoryFood.category_name}</p>
        </div>
        <h4 class="text-center">Hình ảnh sản phẩm:</h4>
        <div id="imageContainer">
            <c:forEach var="img" items="${food.list_food_images}" varStatus="status">
                <div class="image-item">
                    <div class="card">
                        <img id="imgPreview_${img.image_id}"
                             src="${pageContext.request.contextPath}/images/product/${img.image_path}"
                             class="image-slot card-img-top" alt="Ảnh sản phẩm">
                        <div class="card-body text-center">
                            <c:if test="${img.is_primary}">
                                <span class="badge bg-primary">Ảnh chính</span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="text-center mt-3">
            <a href="/manageFoods" class="btn-back">Quay lại</a>
        </div>
    </div>
</div>
</body>
</html>
