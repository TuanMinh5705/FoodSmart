<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục sản phẩm</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
<div class="container my-4">
    <h2 class="text-center mb-4">Quản lý danh mục sản phẩm</h2>

    <!-- Thanh công cụ -->
    <div class="d-flex justify-content-between mb-3">
        <a href="/manageCategoryFood?action=addForm" class="btn btn-success">
            <i class="fas fa-plus"></i> Thêm danh mục
        </a>

        <form action="/manageCategoryFood?action=search" method="post" class="form-inline" id="searchForm">
            <input type="text" class="form-control mr-2" placeholder="Tìm kiếm danh mục"
                   name="keyword" id="searchBox" oninput="startTimer()">
            <button class="btn btn-primary" type="submit">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <!-- Bảng danh sách danh mục -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover text-center">
            <thead class="thead-dark">
            <tr>
                <th>#</th>
                <th>Ảnh danh mục</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="category" items="${categoryFoodList}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>
                        <img src="/images/product/${category.avt_path}" alt="Ảnh danh mục" class="img-thumbnail" width="80">
                    </td>
                    <td>${category.category_name}</td>
                    <td>${category.description}</td>
                    <td>
                        <div class="btn-group">
                            <a href="/manageCategoryFood?action=editForm&categoryID=${category.category_id}" class="btn btn-primary btn-sm">
                                <i class="fas fa-pencil-alt"></i> Sửa
                            </a>
                            <a href="/manageCategoryFood?action=infoForm&categoryID=${category.category_id}" class="btn btn-danger btn-sm">
                                <i class="manageCategoriesFood"></i> Chi tiết
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
    let timer;

    function startTimer() {
        clearTimeout(timer);

        timer = setTimeout(function() {
            document.getElementById("searchForm").submit();
        }, 4500);
    }
</script>
</body>
</html>
