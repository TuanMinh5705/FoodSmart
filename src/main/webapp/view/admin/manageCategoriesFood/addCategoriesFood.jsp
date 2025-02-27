<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm danh mục sản phẩm</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4 text-center"><i class="bi bi-plus-circle-fill"></i> Thêm danh mục sản phẩm</h2>

    <div class="card shadow p-4">
        <form action="/manageCategoryFood?action=add" method="post" enctype="multipart/form-data">
            <div class="mb-3 text-center">
                <img id="avatarPreview" class="img-fluid rounded-circle border d-none" src="#" style="max-height: 100px;">
                <input type="file" class="form-control mt-2" id="avatar" name="avatar" accept="image/*" onchange="previewImage(event, 'avatarPreview')">
            </div>

            <div class="mb-3">
                <label class="form-label">Tên danh mục</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-tags-fill"></i></span>
                    <input type="text" class="form-control" id="category_name" name="category_name"
                           placeholder="Nhập tên danh mục" required
                           pattern="^[\p{L}0-9\s]{3,100}$"
                           title="Tên danh mục chỉ chứa chữ cái, số và khoảng trắng, từ 3 đến 100 ký tự">
                </div>
                <c:if test="${not empty categoryFoodList}">
                    <c:set var="isDuplicate" value="false"/>
                    <c:forEach var="category" items="${categoryFoodList}">
                        <c:if test="${category.category_name eq param.category_name}">
                            <c:set var="isDuplicate" value="true"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${isDuplicate}">
                        <div class="alert alert-danger mt-2" role="alert">
                            Danh mục sản phẩm đã tồn tại!
                        </div>
                    </c:if>
                </c:if>
            </div>

            <div class="mb-3">
                <label class="form-label">Mô tả</label>
                <textarea class="form-control" id="description" name="description"
                          minlength="5" maxlength="255"
                          placeholder="Nhập mô tả danh mục" required></textarea>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-check-circle"></i> Thêm danh mục
                </button>
                <a href="/manageCategoryFood" class="btn btn-danger">
                    <i class="bi bi-x-circle"></i> Hủy
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    function previewImage(event, previewId) {
        let reader = new FileReader();
        reader.onload = function () {
            let preview = document.getElementById(previewId);
            preview.src = reader.result;
            preview.classList.remove("d-none");
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>
</body>
</html>
