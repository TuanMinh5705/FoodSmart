<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Cập nhật món ăn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .image-slot {
            width: 200px;
            height: 200px;
            object-fit: cover; /* Đảm bảo ảnh giữ tỉ lệ và không bị méo */
        }

        .custom-file-label {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body class="container mt-4">

<h2 class="mb-4">Cập nhật món ăn</h2>

<form action="updateFood" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>

    <input type="hidden" name="product_id" value="${food.product_id}">

    <div class="mb-3">
        <label class="form-label">Tên món ăn:</label>
        <input type="text" class="form-control" name="product_name" value="${food.product_name}" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Giá:</label>
        <input type="number" class="form-control" name="price" value="${food.price}" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Số lượng tồn kho:</label>
        <input type="number" class="form-control" name="stock_quantity" value="${food.stock_quantity}" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Giảm giá (%):</label>
        <input type="number" class="form-control" name="discount" value="${food.discount}">
    </div>

    <div class="mb-3">
        <label class="form-label">Danh mục món ăn:</label>
        <select name="category_id" class="form-select">
            <c:forEach var="category" items="${categoryFoodList}">
                <option value="${category.category_id}" ${category.category_id == food.category_id ? 'selected' : ''}>
                        ${category.category_name}
                </option>
            </c:forEach>
        </select>
    </div>

    <h4 class="mt-4">Danh sách ảnh:</h4>
    <c:choose>
        <c:when test="${not empty food.list_food_images}">
            <div class="row g-3" id="imageContainer">
                <c:forEach var="img" items="${food.list_food_images}">
                    <div class="col-md-4 image-card">
                        <div class="card">
                            <img id="img_${img.image_id}"
                                 src="${pageContext.request.contextPath}/foodSmartImages/product/${img.image_path}"
                                 class="image-slot card-img-top" alt="Ảnh món ăn">
                            <div class="card-body">
                                <label class="form-check-label">Ảnh chính:</label>
                                <input type="radio" name="primary_image"
                                       value="${img.image_id}" ${img.is_primary ? 'checked' : ''}>

                                <div class="mt-3">
                                    <label class="form-label">Chọn ảnh khác:</label>
                                    <input type="file" name="replace_image_${img.image_id}" class="form-control"
                                           onchange="previewReplacement(this, 'img_${img.image_id}')"
                                           data-label="${img.image_path}">
                                </div>

                                <button type="button" class="btn btn-danger btn-sm mt-3"
                                        onclick="showDeleteModal({ id: '${img.image_id}', url: 'manageFoods', action: 'deleteImage' });">
                                    Xóa ảnh
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <p>Không có ảnh nào.</p>
        </c:otherwise>
    </c:choose>
    <jsp:include page="../../admin/system/modalConfirmDelete.jsp"/>

    <label for="newImageInput" class="btn btn-outline-primary">Thêm ảnh mới</label>
    <input type="file" id="newImageInput" name="product_images" multiple style="display: none;">
    <div id="previewContainer" class="mt-3"></div>


    <button type="submit" class="btn btn-primary">Cập nhật</button>
    <a href="/manageFoods" class="btn btn-secondary">Hủy</a>

</form>


</body>
</html>
