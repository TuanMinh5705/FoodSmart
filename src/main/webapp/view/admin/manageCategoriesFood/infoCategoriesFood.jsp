<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết danh mục sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
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
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="fas fa-info-circle"></i> Chi tiết danh mục sản phẩm
    </h2>
    <div class="card shadow p-4 mx-auto" style="max-width: 600px;">
        <div class="card-body">
            <div class="text-center mb-4">
                <img src="${pageContext.request.contextPath}/images/product/${category.avt_path}"
                     alt="Ảnh danh mục" class="avatar">
            </div>
            <h4 class="card-title text-center mb-3">
                <i class="fas fa-tags"></i> ${category.category_name}
            </h4>
            <p class="card-text"><strong>Mô tả:</strong> ${category.description}</p>
            <p class="card-text"><strong>Mã danh mục:</strong> ${category.category_id}</p>
            <div class="d-flex justify-content-center gap-3 mt-4">
                <a href="/manageCategoryFood" class="btn btn-secondary">
                    <i class="bi bi-arrow-left-circle"></i> Quay lại
                </a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
