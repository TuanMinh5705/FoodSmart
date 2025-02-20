<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa danh mục sản phẩm</title>
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
                <i class="fas fa-edit"></i> Sửa danh mục sản phẩm
            </h2>
            <div class="card shadow">
                <div class="card-body">
                    <form action="/manageCategoryFood?action=edit" method="post" enctype="multipart/form-data">

                        <input type="hidden" name="category_id" value="${category.category_id}">
                        <div class="mb-3 text-center">
                            <img id="avatarPreview" class="avatar-preview"
                                 src="${pageContext.request.contextPath}/images/product/${category.avt_path}"
                                 alt="Ảnh danh mục">
                            <label for="avatar" class="form-label d-block">
                                <i class="fas fa-image"></i> Chọn ảnh danh mục (nếu muốn thay đổi)
                            </label>
                            <input type="file" class="form-control" id="avatar" name="avt_path" accept="image/*">
                            <input type="hidden" name="currentAvtPath" value="${category.avt_path}">
                        </div>

                        <!-- Tên danh mục -->
                        <div class="mb-3">
                            <label for="category_name" class="form-label">
                                <i class="fas fa-tags"></i> Tên danh mục
                            </label>
                            <select class="form-control" id="category_name" name="category_name" required>
                                <c:forEach var="cat" items="${categoryFoodList}">
                                    <option value="${cat.category_name}"
                                            <c:if test="${cat.category_id eq category.category_id}">selected</c:if>>
                                            ${cat.category_name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Mô tả -->
                        <div class="mb-3">
                            <label for="description" class="form-label">
                                <i class="fas fa-info-circle"></i> Mô tả
                            </label>
                            <textarea class="form-control" id="description" name="description" rows="4"
                                      placeholder="Nhập mô tả danh mục" required
                                      oninput="this.setCustomValidity(this.value.length < 5 || this.value.length > 255 ? 'Mô tả phải có từ 5 đến 255 ký tự' : '')">${category.description}</textarea>
                        </div>
                        <!-- Nút submit -->
                        <div class="d-flex justify-content-center gap-2">
                            <a href="/manageCategoryFood" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Cập nhật danh mục
                            </button>
                        </div>
                    </form>
                </div><!-- End card-body -->
            </div><!-- End card -->
        </div><!-- End col-md-8 -->
    </div><!-- End row -->
</div><!-- End container -->

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("avatar")?.addEventListener("change", function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("avatarPreview").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>
