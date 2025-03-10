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
            --primary-color: #6a11cb;
            --secondary-color: #2575fc;
            --primary-gradient: linear-gradient(90deg, #8E2DE2, #4A00E0);
            --secondary-gradient: linear-gradient(90deg, #FF416C, #FF4B2B);
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
            --table-row-hover: #f1f1f1;
        }

        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            line-height: 1.6;
        }

        .custom-container {
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            font-weight: 700;
            color: #333;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background: #fff;
            animation: fadeInUp 0.8s ease;
            margin-bottom: 2rem;
        }

        .card-header {
            background: var(--primary-gradient);
            color: #fff;
            text-align: center;
            padding: 1.5rem;
            font-size: 1.8rem;
            font-weight: 700;
            position: relative;
        }

        .card-header::after {
            content: "";
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 40%;
            height: 3px;
            background: #fff;
            border-radius: 2px;
        }

        .card-body {
            padding: 1.5rem 2rem;
        }

        .btn-primary {
            border-radius: 50px;
            padding: 0.65rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            background: var(--primary-gradient);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-primary:hover {
            box-shadow: 0 6px 15px rgba(142, 45, 226, 0.3);
        }

        .btn-secondary {
            border-radius: 50px;
            padding: 0.65rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            background: var(--secondary-gradient);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
            color: #fff;
        }

        .btn-secondary:hover {
            box-shadow: 0 6px 15px rgba(255, 65, 108, 0.3);
        }

        .btn-danger {
            border-radius: 50px;
            padding: 0.65rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-danger:hover {
            box-shadow: 0 6px 15px rgba(220, 53, 69, 0.3);
        }

        .input-group .form-control {
            border-radius: 50px 0 0 50px;
            border-right: none;
            padding: 0.65rem 1rem;
        }

        .input-group .btn {
            border-radius: 0 50px 50px 0;
        }

        .table {
            margin-bottom: 0;
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
            background-color: #f9f9f9;
        }

        .table tbody tr:hover {
            background-color: var(--table-row-hover);
        }

        .img-thumbnail {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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
<div class="container my-4 custom-container">
    <h2>Quản lý sản phẩm</h2>

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-stretch mb-4 gap-3">
        <div class="d-flex gap-2">
            <a href="/manageFoods?action=addFoodForm" class="btn btn-secondary">
                <i class="fas fa-plus me-1"></i> Thêm món ăn
            </a>
        </div>
        <form action="/manageFoods?action=search" method="post" class="d-flex" id="searchForm">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm" name="keyword" id="searchBox"
                       oninput="startTimer()">
                <button class="btn btn-primary" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>
    </div>

    <div class="card">
<%--        <div class="card-header">--%>
<%--            Danh sách món ăn--%>
<%--        </div>--%>
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
                                                <img src="${pageContext.request.contextPath}/images/product/${image.image_path}"
                                                     alt="Ảnh món ăn" class="img-thumbnail" width="80">
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>${product.product_name}</td>
                                    <td><fmt:formatNumber value="${product.price}" pattern="#,### đ"/></td>
                                    <td>${product.stock_quantity}</td>
                                    <td>${product.discount}%</td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="/manageFoods?action=editProductForm&productID=${product.product_id}"
                                               class="btn btn-secondary btn-sm" title="Sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <a href="/manageFoods?action=infoProductForm&productID=${product.product_id}"
                                               class="btn btn-primary btn-sm" title="Chi tiết">
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
        timer = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 4500);
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
