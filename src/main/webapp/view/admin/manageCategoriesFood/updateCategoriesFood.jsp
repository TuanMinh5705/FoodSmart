<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa danh mục sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* Có thể giữ lại hoặc thay đổi theo thiết kế mong muốn */
        .img-container {
            position: relative;
            display: inline-block;
        }
        .img-container .edit-icon {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(199, 199, 210, 0.8);
            border: 1px solid #dad9d9;
            border-radius: 100%;
            cursor: pointer;
        }
        .avatar-preview {
            width: 150px;
            height: 150px;
            object-fit: contain;
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
                            <!-- Sử dụng container giống trang cập nhật cửa hàng -->
                            <div class="img-container">
                                <img id="avatarPreview" class="avatar-preview"
                                     src="${pageContext.request.contextPath}/images/product/${category.avt_path}"
                                     alt="Ảnh danh mục">
                                <button type="button" class="btn btn-sm btn-light edit-icon" onclick="document.getElementById('avatar').click()">
                                    <i class="bi bi-pen"></i>
                                </button>
                            </div>
                            <input type="file" class="d-none" id="avatar" name="avt_path" accept="image/*">
                            <input type="hidden" name="currentAvtPath" value="${category.avt_path}">
                        </div>

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

                        <div class="mb-3">
                            <label for="description" class="form-label">
                                <i class="fas fa-info-circle"></i> Mô tả
                            </label>
                            <textarea class="form-control" id="description" name="description" rows="4"
                                      placeholder="Nhập mô tả danh mục" required
                                      oninput="this.setCustomValidity(this.value.length < 5 || this.value.length > 255 ? 'Mô tả phải có từ 5 đến 255 ký tự' : '')">${category.description}</textarea>
                        </div>
                        <div class="d-grid">
                            <div class="d-flex justify-content-center gap-2">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i> Cập nhật danh mục
                                </button>
                                <a href="/manageCategoryFood" class="btn btn-danger">
                                    <i class="bi bi-x-circle"></i> Hủy
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("avatar")?.addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("avatarPreview").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>
