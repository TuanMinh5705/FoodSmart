<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý sản phẩm cửa hàng</title>
    <!-- Font Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome cho icon -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .custom-container {
            max-width: 800px;
            margin: auto;
            padding: 2rem 1rem;
        }
        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            background: #fff;
            animation: fadeInUp 1s ease;
            margin-bottom: 2rem;
        }
        /* Sửa đổi: Bỏ background của tiêu đề */
        .card-header {
            background: transparent;
            color: #000;
            text-align: center;
            padding: 1.8rem;
            font-size: 2rem;
            font-weight: 700;
            position: relative;
        }
        .card-header::after {
            display: none;
        }
        .card-body {
            padding: 2rem;
        }
        .btn-sm {
            padding: 0.35rem 0.75rem !important;
            font-size: 0.85rem !important;
            border-radius: 25px !important;
        }
        /* Các style chung cho button (xoá border) */
        .btn-custom {
            border: none !important;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s, background 0.3s, color 0.3s;
            color: #fff;
        }
        /* Màu sắc cho các button */
        .btn-primary, .btn-secondary {
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
        }
        .btn-primary:hover, .btn-secondary:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #1E88E5, #2a9ffc);
            box-shadow: none;
        }
        /* Button đỏ */
        .btn-danger {
            background: linear-gradient(90deg, #f67272, #f55d5d);
        }
        .btn-danger:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #f55d5d, #f67272);
            box-shadow: none;
        }
        /* Button xanh lá dùng cho upload (Thêm & Sửa) */
        .btn-upload {
            background: linear-gradient(90deg, #2ecc71, #2dc26c);
        }
        .btn-upload:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #2dc26c, #2ecc71);
            box-shadow: none;
        }
        /* Đảm bảo chữ và icon trong button luôn màu trắng ban đầu */
        .btn-upload, .btn-upload * {
            color: #fff !important;
        }
        /* Hover effect: Khi trỏ chuột vào nút, chữ và icon chuyển thành màu đen */
        .btn-custom:hover,
        .btn-custom:hover i {
            color: #000 !important;
        }

        .btn-upload:hover, .btn-upload:hover * {
            color: #000 !important;
        }

        /* Input với icon */
        .input-with-icon {
            position: relative;
        }
        .input-with-icon input {
            padding-right: 40px;
            border-radius: 50px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .input-with-icon input:focus {
            border-color: #1E88E5;
            box-shadow: 0 0 8px rgba(30, 136, 229, 0.5);
        }
        .input-with-icon .fa-search {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            transition: color 0.3s;
        }
        .input-with-icon .fa-search:hover {
            color: #495057;
        }
        .table thead {
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            color: #fff;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="container my-4 custom-container">
    <div class="card">
        <div class="card-header">
            Quản lý sản phẩm cửa hàng
        </div>
        <div class="card-body">
            <div class="row mb-4">
                <div class="col-md-4 mb-3 mb-md-0">
                    <!-- Nút Thêm món ăn sử dụng btn-upload với style tối ưu -->
                    <a href="/manageFoods?action=addFoodForm" class="btn btn-custom btn-upload btn-sm">
                        <i class="fas fa-plus me-2"></i> <strong>Thêm món ăn</strong>
                    </a>
                </div>
                <div class="col-md-8">
                    <form action="/manageFoods?action=search" method="post" id="searchForm">
                        <div class="input-with-icon">
                            <input type="text" class="form-control" placeholder="Tìm kiếm..." name="keyword" onkeyup="startTimer()">
                            <i class="fas fa-search" onclick="document.getElementById('searchForm').submit();"></i>
                        </div>
                    </form>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
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
                                                <img src="${pageContext.request.contextPath}/images/product/${image.image_path}"
                                                     alt="Ảnh món ăn"
                                                     class="img-thumbnail product-img">
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${product.product_name}</td>
                                    <td><fmt:formatNumber value="${product.price}" pattern="#,### đ"/></td>
                                    <td>${product.stock_quantity}</td>
                                    <td>${product.discount}%</td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <!-- Nút Sửa sử dụng btn-upload -->
                                            <a href="/manageFoods?action=editProductForm&productID=${product.product_id}"
                                               class="btn btn-custom btn-upload btn-sm" title="Sửa">
                                                <i class="fas fa-pencil-alt"></i>
                                            </a>
                                            <a href="/manageFoods?action=infoProductForm&productID=${product.product_id}"
                                               class="btn btn-custom btn-secondary btn-sm" title="Chi tiết">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <button type="button"
                                                    class="btn btn-custom btn-danger btn-sm"
                                                    title="Xóa"
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
        timer = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2500);
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
