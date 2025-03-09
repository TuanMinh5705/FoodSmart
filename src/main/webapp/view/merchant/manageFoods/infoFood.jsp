<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
    <title>Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .image-slot {
            width: 200px;
            height: 200px;
            object-fit: cover;
        }
        .image-container {
            position: relative;
            display: inline-block;
            margin: 10px;
        }
    </style>
</head>
<body class="container mt-4">

<h2>Chi tiết sản phẩm</h2>

<div class="mb-3">
    <label class="form-label">Tên món ăn:</label>
    <p>${food.product_name}</p>
</div>

<div class="mb-3">
    <label class="form-label">Giá:</label>
    <p><fmt:formatNumber value="${food.price}" pattern="#,###" /> đ</p>
</div>

<div class="mb-3">
    <label class="form-label">Số lượng trong kho:</label>
    <p>${food.stock_quantity}</p>
</div>

<div class="mb-3">
    <label class="form-label">Giảm giá (%):</label>
    <p>${food.discount}</p>
</div>

<div class="mb-3">
    <label class="form-label">Danh mục:</label>
    <p>${categoryFood.category_name}</p>
</div>

<h4>Hình ảnh sản phẩm:</h4>
<div class="row g-3" id="imageContainer">
    <c:forEach var="img" items="${food.list_food_images}" varStatus="status">
        <div class="col-md-4">
            <div class="card">
                <img id="imgPreview_${img.image_id}"
                     src="${pageContext.request.contextPath}/images/product/${img.image_path}"
                     class="image-slot card-img-top" alt="Ảnh sản phẩm">
                <div class="card-body">
                    <c:if test="${img.is_primary}">
                        <span class="badge bg-primary">Ảnh chính</span>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<a href="/manageFoods" class="btn btn-secondary mt-3">Trở về</a>

</body>
</html>
