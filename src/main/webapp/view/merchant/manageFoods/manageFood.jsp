<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý sản phẩm cửa hàng</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --primary-color: #3498db; /* Xanh dương tươi */
            --secondary-color: #2ecc71; /* Xanh lá mát */
            --primary-gradient: linear-gradient(90deg, #3498db, #2980b9);
            --secondary-gradient: linear-gradient(90deg, #2ecc71, #27ae60);
            --danger-gradient: linear-gradient(90deg, #e74c3c, #c0392b);
            --bg-light: #ffffff;
            --bg-dark: #ecf0f1;  /* Màu nền sáng nhẹ */
            --text-color: #2c3e50; /* Xám đậm */
            --card-shadow: rgba(44, 62, 80, 0.1);
            --hover-shadow: rgba(44, 62, 80, 0.15);
        }

        /* Global Styles */
        body {
            background: var(--bg-dark);
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 20px;
            color: var(--text-color);
        }

        .custom-container {
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            color: var(--primary-color);
        }

        /* Card Styles */
        .card {
            border: none;
            border-radius: 15px;
            background: var(--bg-light);
            box-shadow: 0 4px 20px var(--card-shadow);
            margin-bottom: 2rem;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        /* Chỉnh sửa card-header: bỏ màu nền và hiển thị chữ đậm */
        .card-header {
            background: transparent; /* Bỏ màu nền */
            color: var(--text-color); /* Sử dụng màu chữ mặc định */
            padding: 1.5rem;
            font-size: 1.75rem;
            font-weight: 700; /* Chữ đậm */
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            text-align: center;
            position: relative;
        }

        .card-body {
            padding: 1.5rem 2rem;
        }

        /* Button Styles */
        .btn {
            border-radius: 50px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            padding: 0.65rem 2rem;
            font-weight: 600;
        }

        .btn-primary:hover {
            box-shadow: 0 6px 15px var(--hover-shadow);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: var(--secondary-gradient);
            border: none;
            color: #fff;
            padding: 0.65rem 2rem;
            font-weight: 600;
        }

        .btn-secondary:hover {
            box-shadow: 0 6px 15px var(--hover-shadow);
            transform: translateY(-2px);
        }

        .btn-danger {
            background: var(--danger-gradient);
            border: none;
            padding: 0.65rem 1.5rem;
            font-weight: 600;
        }

        .btn-danger:hover {
            box-shadow: 0 6px 15px var(--hover-shadow);
            transform: translateY(-2px);
        }

        /* Search input with icon on right */
        .search-form {
            position: relative;
            max-width: 300px;
        }

        .search-input {
            padding-right: 2.5rem;
            border-radius: 50px;
            transition: box-shadow 0.3s;
        }

        .search-input:focus {
            box-shadow: 0 0 8px var(--primary-color);
        }

        .search-icon {
            position: absolute;
            top: 50%;
            right: 0.75rem;
            transform: translateY(-50%);
            color: #aaa;
            cursor: pointer;
        }

        /* Table styles */
        .table {
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px var(--card-shadow);
        }

        .table thead {
            background: var(--primary-gradient);
            color: #fff;
        }

        .table th, .table td {
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem;
        }

        .table tbody tr:nth-child(even) {
            background: #f8f8f8;
        }

        .table tbody tr:hover {
            background: #f1f1f1;
        }

        .img-thumbnail {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px var(--card-shadow);
        }

        @media (max-width: 576px) {
            .card-header {
                font-size: 1.5rem;
            }

            .btn {
                font-size: 0.9rem;
                padding: 0.5rem 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container my-4 custom-container">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
        <div>
            <a href="/manageFoods?action=addFoodForm" class="btn btn-secondary">
                <i class="fas fa-plus me-1"></i> Thêm món ăn
            </a>
        </div>
        <form action="/manageFoods?action=search" method="post" class="search-form" id="searchForm">
            <input type="text" class="form-control search-input" placeholder="Tìm kiếm" name="keyword" id="searchBox" oninput="startTimer()">
            <i class="fas fa-search search-icon" onclick="document.getElementById('searchForm').submit();"></i>
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
                                            <button type="button" class="btn btn-danger btn-sm" title="Xóa"
                                                    onclick="showDeleteModal({ id: '${product.product_id}', url: 'manageFoods', action: 'deleteFood' });">
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
        timer = setTimeout(function() {
            document.getElementById("searchForm").submit();
        }, 4500);
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
