<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImages() {
            let preview = document.getElementById('imagePreview');
            let files = document.getElementById('productImages').files;

            for (let i = 0; i < files.length; i++) {
                let file = files[i];
                let reader = new FileReader();

                reader.onload = function (e) {
                    let img = document.createElement('img');
                    img.src = e.target.result
                    img.className = 'img-thumbnail m-1';
                    img.style.width = '100px';

                    preview.appendChild(img);
                };

                reader.readAsDataURL(file);
            }
        }
    </script>

</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Thêm Sản Phẩm</h2>
    <form action="/manageFoods?action=addFood" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" class="form-control" name="product_name" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Giá</label>
            <input type="number" class="form-control" name="price" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Số lượng</label>
            <input type="number" class="form-control" name="stock_quantity" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Giảm giá (%)</label>
            <input type="number" class="form-control" name="discount" min="0" max="100">
        </div>
        <div class="mb-3">
            <label class="form-label">Danh mục</label>
            <select class="form-select" name="category_id" required>
                <c:forEach var="category" items="${categoryStoreList}">
                    <option value="${category.category_id}">${category.category_name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Chọn ảnh sản phẩm</label>
            <input type="file" class="form-control" name="product_images" id="productImages" multiple
                   accept="image/*" onchange="previewImages()">
            <div id="imagePreview" class="mt-2 d-flex flex-wrap"></div>
        </div>
        <button type="submit" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Thêm sản phẩm
        </button>
    </form>
</div>
</body>
</html>
