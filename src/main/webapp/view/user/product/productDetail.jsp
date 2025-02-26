<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/homeUser">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">${food.product_name}</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-2">
            <div class="d-flex flex-column gap-2">
                <c:forEach var="img" items="${food.list_food_images}">
                    <img src="${pageContext.request.contextPath}/foodSmartImages/product/${img.image_path}"
                         alt="${food.product_name}"
                         class="img-fluid rounded border">
                </c:forEach>
            </div>
        </div>
        <div class="col-md-5">
            <c:choose>
                <c:when test="${not empty food.list_food_images}">
                    <c:set var="mainImage" value="${null}" scope="page"/>
                    <c:forEach var="img" items="${food.list_food_images}">
                        <c:if test="${img.is_primary}">
                            <c:set var="mainImage" value="${img}" scope="page"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${empty mainImage}">
                        <c:set var="mainImage" value="${food.list_food_images[0]}" scope="page"/>
                    </c:if>
                    <img src="${pageContext.request.contextPath}/foodSmartImages/product/${mainImage.image_path}"
                         alt="${food.product_name}"
                         class="img-fluid rounded border">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/foodSmartImages/product/product_default.jpg"
                         alt="No image available"
                         class="img-fluid rounded border">
                </c:otherwise>
            </c:choose>
        </div>
        <!-- Cột thông tin sản phẩm -->
        <div class="col-md-5">
            <h1 class="h2">${food.product_name}</h1>
            <a>Cửa hàng : ${store.store_name}</a>
            <div class="fs-4 fw-bold">
                <c:choose>
                    <c:when test="${food.discount gt 0}">
                        <span class="text-danger">
                            <c:set var="discountedPrice" value="${food.price - (food.price * food.discount / 100)}"/>
                             <fmt:formatNumber value="${discountedPrice}" pattern="#,###"/> ₫
                        </span>
                        <span class="text-muted text-decoration-line-through ms-2">
                                       <fmt:formatNumber value="${food.price}" pattern="#,###"/> ₫
                        </span>
                    </c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${food.price}" pattern="#,###"/> ₫
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="my-3 d-flex align-items-center">
                <button class="btn btn-outline-secondary">-</button>
                <input type="text" value="1" class="form-control text-center mx-2" style="width: 60px;">
                <button class="btn btn-outline-secondary">+</button>
            </div>

            <div class="d-flex gap-3">
                <button class="btn btn-warning text-dark">
                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>
                <button class="btn btn-outline-dark">
                    <i class="fas fa-bolt"></i> Mua ngay
                </button>
            </div>

            <h2 class="h5 mt-4">Mô tả chi tiết sản phẩm</h2>
            <ul>
                <li>Bánh mì kẹp thập cẩm:</li>
                <li>Thịt nguội (chả lụa, jambon, xúc xích, pate, thịt xá xíu...)</li>
                <li>Trứng chiên hoặc trứng ốp la</li>
                <li>Dưa chua (đồ chua gồm cà rốt, củ cải muối chua ngọt)</li>
                <li>Rau thơm (ngò, húng quế, rau răm...)</li>
                <li>Dưa leo</li>
                <li>Ớt tươi hoặc ớt sa tế</li>
                <li>Sốt mayonnaise, bơ, nước tương, hoặc tương ớt</li>
                <li>Sản phẩm đi kèm: đũa tương ớt, tương cà, gói sốt mayonnaise.</li>
            </ul>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
