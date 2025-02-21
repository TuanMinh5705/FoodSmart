<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    <form id="addCategoryForm" action="/manageFoods?action=addCategory" method="post">
                        <div class="mb-3 text-center">
                            <img id="avatarPreview" class="avatar-preview" src="https://via.placeholder.com/150" alt="Ảnh danh mục">
                        </div>
                        <div class="mb-3">
                            <label for="category_name" class="form-label">
                                <i class="fas fa-tags"></i> Chọn danh mục
                            </label>
                            <select class="form-control" id="category_name" name="category_id" required>
                                <c:forEach var="cat" items="${categoryFoodList}">
                                    <option value="${cat.category_id}">${cat.category_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">
                                <i class="fas fa-info-circle"></i> Mô tả
                            </label>
                            <textarea class="form-control" id="description" name="description"
                                      placeholder="Mô tả danh mục" required readonly></textarea>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Lưu danh mục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("category_name").addEventListener("change", function(event) {
        const categoryId = event.target.value;
        fetch('/manageFoods?action=getCategory&categoryId=' + categoryId)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById("avatarPreview").src = "images/product/" + data.imageUrl;
                    document.getElementById("description").value = data.description;
                } else {
                    document.getElementById("avatarPreview").src = "https://via.placeholder.com/150";
                    document.getElementById("description").value = "";
                }
            })
            .catch(error => {
                console.error("Error:", error);
                document.getElementById("avatarPreview").src = "https://via.placeholder.com/150";
                document.getElementById("description").value = "";
            });
    });

    document.addEventListener("DOMContentLoaded", function() {
        const select = document.getElementById("category_name");
        if (select.value) {
            const event = new Event("change");
            select.dispatchEvent(event);
        }
    });

</script>
</body>
</html>
