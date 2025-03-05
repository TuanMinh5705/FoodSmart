<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý danh mục và sản phẩm cửa hàng</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --primary-color: #1E88E5; /* Màu xanh chủ đạo */
            --primary-color-hover: #1565c0; /* Màu xanh đậm khi hover */
            --secondary-color: #f55d5d; /* Màu phụ cho nút */
            --secondary-color-hover: #d32f2f;
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
            --card-bg: #ffffff;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --border-radius: 15px;
        }

        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .custom-container {
            max-width: 1200px;
            margin: auto;
            padding: 30px;
        }

        h2 {
            font-weight: 700;
            color: #333;
            margin-bottom: 2rem;
            text-align: center;
        }

        .card {
            background: var(--card-bg);
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 2rem;
            margin-bottom: 2rem;
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            font-size: 1.8rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 10px;
        }

        .card-header::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 2px;
        }

        .btn-primary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: var(--primary-color);
            border: none;
            transition: background 0.3s, transform 0.3s;
        }

        .btn-primary:hover {
            background: var(--primary-color-hover);
            transform: translateY(-3px);
        }

        .btn-secondary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1rem;
            font-weight: 600;
            background: var(--secondary-color);
            border: none;
            color: #fff;
            transition: background 0.3s, transform 0.3s;
        }

        .btn-secondary:hover {
            background: var(--secondary-color-hover);
            transform: translateY(-3px);
        }

        .btn-danger {
            border-radius: 50px;
            padding: 0.65rem 1.5rem;
            font-size: 0.9rem;
            font-weight: 600;
            transition: transform 0.3s;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
        }

        .input-group .form-control {
            border-radius: 50px 0 0 50px;
            border: 1px solid #ddd;
            padding: 0.75rem 1rem;
        }

        .input-group .btn {
            border-radius: 0 50px 50px 0;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background: var(--primary-color);
            color: #fff;
        }

        .table th, .table td {
            vertical-align: middle;
            text-align: center;
            padding: 1rem;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .img-thumbnail {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 576px) {
            .card-header {
                font-size: 1.5rem;
            }

            .btn-primary, .btn-secondary, .btn-danger {
                font-size: 0.9rem;
                padding: 0.5rem 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container custom-container">
    <h2>Quản lý danh mục và sản phẩm</h2>

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
        <div>
            <a href="/manageFoods?action=addFoodForm" class="btn btn-secondary">
                <i class="fas fa-plus me-1"></i> Thêm món ăn
            </a>
        </div>
        <form action="/manageFoods?action=search" method="post" class="d-flex" id="searchForm">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm" name="keyword" id="searchBox" oninput="startTimer()">
                <button class="btn btn-primary" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>
    </div>

    <div class="card">
        <div class="card-header">
            Danh sách món ăn
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Ảnh chính</th>
                        <th>Tên món</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Giảm giá (%)</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty foodList}">
                            <tr>
                                <td colspan="7" class="text-center text-muted">Không có món ăn nào.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="product" items="${foodList}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>
                                        <c:forEach var="image" items="${product.list_food_images}">
                                            <c:if test="${image.is_primary}">
                                                <img src="${pageContext.request.contextPath}/foodSmartImages/product/${image.image_path}" alt="Ảnh món ăn" class="img-thumbnail" width="80">
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${product.product_name}</td>
                                    <td><fmt:formatNumber value="${product.price}" pattern="#,### đ"/></td>
                                    <td>${product.stock_quantity}</td>
                                    <td>${product.discount}%</td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="/manageFoods?action=editProductForm&productID=${product.product_id}" class="btn btn-secondary btn-sm" title="Sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="/manageFoods?action=infoProductForm&productID=${product.product_id}" class="btn btn-primary btn-sm" title="Chi tiết">
                                                <i class="fas fa-info-circle"></i>
                                            </a>
                                            <button type="button" class="btn btn-danger btn-sm" title="Xóa" onclick="showDeleteModal({ id: '${product.product_id}', url: 'manageFoods', action: 'deleteFood' });">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../admin/system/modalConfirmDelete.jsp"/>

<script>
    let timer;
    function startTimer() {
        clearTimeout(timer);
        timer = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2500);
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
