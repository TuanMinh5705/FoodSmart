<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .avatar-preview {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 1px solid #ddd;
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h2 class="mb-4 text-center">
                <i class="fas fa-plus-circle"></i> Thêm danh mục sản phẩm
            </h2>
            <div class="card shadow">
                <div class="card-body">
                    <form action="/manageCategoryFood?action=add" method="post" enctype="multipart/form-data">
                        <div class="mb-3 text-center">
                            <img id="avatarPreview" class="avatar-preview" src="https://via.placeholder.com/150" alt="Ảnh danh mục">
                            <label for="avatar" class="form-label d-block">
                                <i class="fas fa-image"></i> Chọn ảnh danh mục
                            </label>
                            <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*">
                        </div>
                        <div class="mb-3">
                            <label for="category_name" class="form-label">
                                <i class="fas fa-tags"></i> Tên danh mục
                            </label>
                            <input type="text" class="form-control" id="category_name" name="category_name"
                                   placeholder="Nhập tên danh mục" required
                                   pattern="^[\p{L}0-9\s]{3,100}$"
                                   title="Tên danh mục chỉ chứa chữ cái, số và khoảng trắng, từ 3 đến 100 ký tự">

                            <c:if test="${not empty categoryFoodList}">
                                <c:forEach var="category" items="${categoryFoodList}">
                                    <c:if test="${category.category_name eq param.category_name}">
                                        <div class="alert alert-danger mt-2" role="alert">
                                            Danh mục sản phẩm đã tồn tại!
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">
                                <i class="fas fa-info-circle"></i> Mô tả
                            </label>
                            <textarea class="form-control" id="description" name="description"
                                      pattern="^.{5,255}$"
                                      title="Mô tả phải có từ 5 đến 255 ký tự"
                                      placeholder="Nhập mô tả danh mục" required></textarea>
                        </div>
                        <div class="d-grid">
                        <div class="d-flex justify-content-center gap-2">
                            <a href="/manageCategoryFood" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>

                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Lưu danh mục
                            </button>
                        </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("avatar").addEventListener("change", function(event) {
        const file = event.target.files[0];
        if(file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("avatarPreview").src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>
