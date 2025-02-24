<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục và sản phẩm cửa hàng</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
<div class="container my-4">
    <h2 class="text-center mb-4">Quản lý danh mục và sản phẩm</h2>

    <div class="d-flex justify-content-between mb-3">
        <div>
            <a href="/manageFoods?action=addCategoryForm" class="btn btn-success">
                <i class="fas fa-plus"></i> Thêm danh mục
            </a>
            <a href="/manageFoods?action=addFoodForm" class="btn btn-primary">
                <i class="fas fa-plus"></i> Thêm món ăn
            </a>
        </div>
        <form action="/manageFoods?action=search" method="post" class="form-inline" id="searchForm">
            <input type="text" class="form-control mr-2" placeholder="Tìm kiếm" name="keyword" id="searchBox" oninput="startTimer()">
            <button class="btn btn-primary" type="submit">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <h4 class="mt-4">Danh mục sản phẩm</h4>
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
                    <td><img src="${pageContext.request.contextPath}/foodSmartImages/product/${category.avt_path}" alt="Ảnh danh mục" class="img-thumbnail" width="80"></td>
                    <td>${category.category_name}</td>
                    <td>${category.description}</td>
                    <td>
                        <a href="/manageFoods?action=infoCategoryForm&categoryID=${category.category_id}" class="btn btn-info btn-sm">
                            <i class="fas fa-info-circle"></i> Chi tiết
                        </a>
                        <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal({ id: ${category.category_id}, url: '/manageFoods', action: 'deleteCategory' })">
                            <i class="fa fa-trash"></i> Xóa
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <h4 class="mt-4">Danh sách món ăn</h4>
    <div class="table-responsive">
        <table class="table table-bordered table-hover text-center">
            <thead class="thead-dark">
            <tr>
                <th>#</th>
                <th>Ảnh chính</th>
                <th>Tên món</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Giảm giá (%)</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="product" items="${foodList}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>
                        <c:forEach var="image" items="${product.list_food_images}">
                            <c:if test="${image.is_primary}">
                                <img src="/images/product/${image.image_path}" alt="Ảnh món ăn" class="img-thumbnail" width="80">
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>${product.product_name}</td>
                    <td><fmt:formatNumber value="${product.price}" pattern="#,### đ"/></td>
                    <td>${product.stock_quantity}</td>
                    <td>${product.discount}%</td>
                    <td>
                        <a href="/manageFoods?action=infoProductForm&productID=${product.product_id}" class="btn btn-info btn-sm">
                            <i class="fas fa-info-circle"></i> Chi tiết
                        </a>
                        <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal(${product.product_id})">
                            <i class="fa fa-trash"></i> Xóa
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>
<jsp:include page="../../admin/system/modalConfirmDelete.jsp" />

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
