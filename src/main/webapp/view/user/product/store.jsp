<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* Điều chỉnh kích thước banner nhỏ lại */
        .store-banner {
            width: 100%;
            max-height: 300px; /* Bạn có thể điều chỉnh giá trị này */
            object-fit: cover;
        }
        /* Tăng kích thước avatar cửa hàng */
        .store-avatar {
            max-width: 200px; /* Đã tăng từ 150px */
            width: 100%;
            height: auto;
            border-radius: 50%;
        }
    </style>
</head>
<body class="bg-light">
<!-- Breadcrumb Navigation với icon -->
<div class="container mt-3">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/homeUser">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
            </li>
            <li class="breadcrumb-item active" aria-current="page">
                <i class="fas fa-store"></i> ${store.store_name}
            </li>
        </ol>
    </nav>
</div>

<!-- Banner -->
<div>
    <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.banner_path}" alt="Banner" class="store-banner img-fluid">
</div>

<!-- Thông tin cửa hàng: Avatar lớn bên cạnh thông tin -->
<div class="container mt-4">
    <div class="row align-items-center">
        <div class="col-md-3 text-center">
            <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.avt_path}" alt="Avatar" class="store-avatar">
        </div>
        <div class="col-md-9">
            <h1>
                <i class="fas fa-store"></i> ${store.store_name}
            </h1>
            <p>
                <i class="fas fa-map-marker-alt"></i> ${store.store_address}
            </p>
            <p>
                <i class="fas fa-phone-alt"></i> ${store.contact_number}
            </p>
        </div>
    </div>
</div>

<!-- Phần hiển thị danh mục và sản phẩm -->
<div class="container mt-4">
    <c:if test="${not empty storeCategories}">
        <c:forEach var="category" items="${storeCategories}">
            <section class="mb-5">
                <h2 class="fw-bold border-bottom pb-2">
                    <i class="fas fa-utensils"></i> ${category.category_name}
                </h2>
                <c:if test="${not empty category.foodList}">
                    <div class="row">
                        <c:forEach var="food" items="${category.foodList}">
                            <div class="col-md-4 col-lg-3 mb-4">
                                <div class="card h-100 shadow-sm">
                                    <c:choose>
                                        <c:when test="${not empty food.list_food_images}">
                                            <img src="${pageContext.request.contextPath}/foodSmartImages/product/${food.list_food_images[0].image_path}"
                                                 class="card-img-top" style="height: 250px; object-fit: cover;" alt="${food.product_name}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/images/product_default.png"
                                                 class="card-img-top" style="height: 250px; object-fit: cover;" alt="Không có ảnh">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${food.product_name}</h5>
                                        <div class="text-danger fw-bold">
                                            <c:set var="discountPrice" value="${food.price * (1 - food.discount / 100.0)}"/>
                                            <fmt:formatNumber value="${discountPrice}" pattern="#,###"/> ₫
                                            <c:if test="${food.discount > 0}">
                                                    <span class="text-muted text-decoration-line-through ms-2">
                                                        <fmt:formatNumber value="${food.price}" pattern="#,###"/> ₫
                                                    </span>
                                                <span class="text-success"> -${food.discount}%</span>
                                            </c:if>
                                        </div>
                                        <p class="text-warning">
                                            <i class="fas fa-star"></i> 4.5 | Đã bán ${food.total_sold}
                                        </p>
                                        <div class="mt-auto">
                                            <a href="/homeUser?action=showFoodDetail&id=${food.product_id}" class="btn btn-outline-primary w-100 mb-2">
                                                <i class="fas fa-eye"></i> Xem chi tiết
                                            </a>
                                            <button class="btn btn-warning w-100" onclick="addToCart(${food.product_id}, ${food.price})">
                                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty category.foodList}">
                    <p class="text-muted">Không có sản phẩm nào trong danh mục này!</p>
                </c:if>
            </section>
        </c:forEach>
    </c:if>
    <c:if test="${empty storeCategories}">
        <p class="text-muted">Không có danh mục nào!</p>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/view/user/product/addToCart.js"></script>
</body>
</html>
