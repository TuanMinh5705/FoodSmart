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
    <!-- Nút Thêm ảnh mới -->
    <button type="button" class="btn btn-success mb-3" onclick="addNewImageCard()">Thêm ảnh mới</button>

    <c:choose>
        <c:when test="${not empty food.list_food_images}">
            <div class="row g-3" id="imageContainer">
                <c:forEach var="img" items="${food.list_food_images}">
                    <input type="hidden" name="imageID" value="${img.image_id}">
                    <div class="col-md-4 image-card">
                        <div class="card">
                            <img id="imgPreview_${img.image_id}"
                                 src="${pageContext.request.contextPath}/foodSmartImages/product/${img.image_path}"
                                 class="image-slot card-img-top" alt="Ảnh món ăn">
                            <div class="card-body">
                                <label class="form-check-label">Ảnh chính:</label>
                                <input type="radio" name="primary_image"
                                       value="${img.image_id}" ${img.is_primary ? 'checked' : ''}>
                                <div class="mt-3">
                                    <label for="image_${img.image_id}" class="btn btn-outline-success">Cập nhật ảnh</label>
                                    <input type="file" class="d-none" id="image_${img.image_id}"
                                           name="img_path_${img.image_path}" accept="image/*"
                                           onchange="updateImagePreview(event, 'imgPreview_${img.image_id}')">
                                    <input type="hidden" name="currentImgPath" value="${img.image_path}">
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
            <div class="row g-3" id="imageContainer"></div>
            <p>Không có ảnh nào.</p>
        </c:otherwise>
    </c:choose>

    <jsp:include page="../../admin/system/modalConfirmDelete.jsp"/>
    <button type="submit" class="btn btn-primary">Cập nhật</button>
    <a href="/manageFoods" class="btn btn-secondary">Hủy</a>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Biến đếm để tạo id duy nhất cho các thẻ ảnh mới
    var newImageCount = 0;

    // Hàm cập nhật preview khi chọn file ảnh mới (dùng cho cả ảnh cũ và ảnh mới)
    function updateImagePreview(event, previewId) {
        var input = event.target;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById(previewId).src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function addNewImageCard() {
        newImageCount++;
        var container = document.getElementById('imageContainer');
        var colDiv = document.createElement('div');
        colDiv.className = "col-md-4 image-card";
        colDiv.innerHTML = `
            <div class="card">
                <img id="imgPreview_new_${newImageCount}" src="https://via.placeholder.com/200x200?text=No+Image" class="image-slot card-img-top" alt="Ảnh món ăn">
                <div class="card-body">
                    <label class="form-check-label">Ảnh chính:</label>
                    <input type="radio" name="primary_image" value="new_${newImageCount}">
                    <div class="mt-3">
                        <label for="image_new_${newImageCount}" class="btn btn-outline-success">Cập nhật ảnh</label>
                        <input type="file" class="d-none" id="image_new_${newImageCount}" name="new_img_path_${newImageCount}" accept="image/*" onchange="updateImagePreview(event, 'imgPreview_new_${newImageCount}')">
                    </div>
                    <button type="button" class="btn btn-danger btn-sm mt-3" onclick="removeImageCard(this)">Xóa ảnh</button>
                </div>
            </div>
        `;
        container.appendChild(colDiv);
    }

    function removeImageCard(button) {
        var card = button.closest('.image-card');
        if (card) {
            card.remove();
        }
    }
</script>
</body>
</html>
