<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <title>Cập nhật món ăn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .image-slot {
            width: 200px;
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>

<body class="container mt-4">

<h2>Cập nhật món ăn</h2>

<form action="updateFood" method="post" enctype="multipart/form-data">
    <input type="hidden" name="product_id" value="${food.product_id}">

    <div class="mb-3">
        <label class="form-label">Tên món ăn:</label>
        <input type="text" name="product_name" value="${food.product_name}" class="form-control" required>
    </div>

    <h4>Danh sách ảnh:</h4>
    <div class="row g-3" id="imageContainer">
        <c:forEach var="img" items="${food.list_food_images}">
            <div class="col-md-4 image-card">
                <div class="card">
                    <input type="hidden" name="primary_image" value="${food.getPrimaryImageId()}">
                    <img id="imgPreview_${img.image_id}"
                         src="${pageContext.request.contextPath}/foodSmartImages/product/${img.image_path}"
                         class="image-slot card-img-top" alt="Ảnh món ăn">
                    <div class="card-body">
                        <label class="form-check-label">Ảnh chính:</label>
                        <input type="radio" name="primary_image" value="${img.image_id}"
                            ${img.is_primary ? 'checked' : ''}>
                        <div class="mt-3">
                            <label for="image_${img.image_id}" class="btn btn-outline-success">Cập nhật ảnh</label>
                            <input type="file" id="image_${img.image_id}" name="img_path_${img.image_id}" class="d-none"
                                   accept="image/*"
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

    <div class="mb-3">
        <label class="form-label">Thêm ảnh sản phẩm</label>
        <input type="file" class="form-control" name="product_images" id="productImages" multiple
               accept="image/*" onchange="previewImages()">
        <div id="imagePreview" class="mt-2 d-flex flex-wrap"></div>
    </div>

    <button type="submit" class="btn btn-primary">Cập nhật</button>
    <a href="/manageFoods" class="btn btn-secondary">Hủy</a>
</form>

<jsp:include page="../../admin/system/modalConfirmDelete.jsp"/>

<script>

    function updateImagePreview(event, previewId) {
        const input = event.target;
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.getElementById(previewId);
                if (img) img.src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function previewImages() {
        const preview = document.getElementById('imagePreview');
        const files = document.getElementById('productImages').files;

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();

            reader.onload = function (e) {
                const div = document.createElement('div');
                div.className = 'image-container d-inline-block position-relative m-2';

                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'img-thumbnail';
                img.style.width = '100px';
                img.style.height = '100px';
                div.appendChild(img);

                const deleteBtn = document.createElement('button');
                deleteBtn.type = 'button';
                deleteBtn.className = 'btn btn-danger btn-sm position-absolute top-0 end-0';
                deleteBtn.innerHTML = '✖';
                deleteBtn.onclick = function () {
                    div.remove();
                };
                div.appendChild(deleteBtn);

                preview.appendChild(div);
            };

            reader.readAsDataURL(file);
        }
    }

</script>

</body>
</html>
