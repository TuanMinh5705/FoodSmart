<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục sản phẩm</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .input-with-icon {
            position: relative;
        }
        .input-with-icon input {
            padding-right: 40px;
        }
        .input-with-icon .search-icon {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #0d6efd;
        }
    </style>
</head>

<body class="bg-light">
<div class="container mt-4">
    <h2 class="text-center mb-4 font-weight-bold">Quản lý danh mục sản phẩm</h2>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="flex-grow-1 d-flex" style="margin-left: 15%;">
            <form action="/manageCategoryFood?action=search" method="post" id="searchForm" class="w-50">
                <div class="input-with-icon">
                    <input type="text" class="form-control" placeholder="Tìm kiếm..." name="keyword" onkeyup="startTimer()">
                    <i class="bi bi-search search-icon" onclick="document.getElementById('searchForm').submit()"></i>
                </div>
            </form>
        </div>
    </div>

    <div class="card shadow rounded">
        <div class="card-body">
            <table class="table table-hover table-bordered table-striped text-center align-middle">
                <thead class="table-dark">
                <tr>
                    <th>STT</th>
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
                            <img src="${pageContext.request.contextPath}/images/product/${category.avt_path}"
                                 alt="Ảnh danh mục" class="img-thumbnail object-fit-contain" width="80">
                        </td>
                        <td>${category.category_name}</td>
                        <td>${category.description}</td>
                        <td>
                            <a href="/manageCategoryFood?action=editForm&categoryID=${category.category_id}"
                               class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="/manageCategoryFood?action=infoForm&categoryID=${category.category_id}"
                               class="btn btn-info btn-sm" title="Chi tiết">
                                <i class="bi bi-info-circle"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    let timer;
    function startTimer() {
        clearTimeout(timer);
        timer = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2000);
    }
</script>

</body>
</html>
