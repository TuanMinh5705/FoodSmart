<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết danh mục sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .avatar {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #ddd;
            display: block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<div class="container my-4">
    <h2 class="text-center mb-4">
        <i class="fas fa-info-circle"></i> Chi tiết danh mục sản phẩm
    </h2>
    <div class="card mx-auto" style="max-width: 600px;">
        <div class="card-body">
            <div class="text-center mb-4">
                <img src="${pageContext.request.contextPath}/images/product/${category.avt_path}" alt="Ảnh danh mục" class="avatar">
            </div>
            <h4 class="card-title text-center">
                <i class="fas fa-tags"></i> ${category.category_name}
            </h4>
            <p class="card-text mt-3"><strong>Mô tả:</strong> ${category.description}</p>
            <p class="card-text"><strong>Mã danh mục :</strong> ${category.category_id}</p>
            <div class="text-center">
                <a href="/manageFoods" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
