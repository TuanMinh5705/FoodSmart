<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
          integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/5hb7U6f9vK5QFRh5H7g+sklh0xI1n6i7dzW4v3"
          crossorigin="anonymous">
    <style>
        #mainImage {
            width: 100%;
            height: 500px;
            object-fit: contain;
            object-position: center;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <!-- Breadcrumb sử dụng Bootstrap -->
    <div class="small text-muted mb-4 ms-4" style="margin-top: 160px">
        <a href="/homeUser" class="text-decoration-underline">Trang chủ</a> /
        <c:if test="${not empty food.product_name}">
            <span>${food.product_name}</span>
        </c:if>
    </div>

    <div class="row">
        <!-- Phần hiển thị ảnh sản phẩm -->
        <div class="col-md-6 mb-4">
            <c:choose>
                <c:when test="${not empty food.list_food_images}">
                    <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <c:forEach var="img" items="${food.list_food_images}" varStatus="status">
                                <button type="button" data-bs-target="#productCarousel" data-bs-slide-to="${status.index}"
                                        class="${status.first ? 'active' : ''}"
                                        aria-current="${status.first ? 'true' : 'false'}"
                                        aria-label="Slide ${status.index + 1}"></button>
                            </c:forEach>
                        </div>
                        <div class="carousel-inner">
                            <c:forEach var="img" items="${food.list_food_images}" varStatus="status">
                                <div class="carousel-item ${status.first ? 'active' : ''}">
                                    <img src="${pageContext.request.contextPath}/images/product/${img.image_path}"
                                         class="d-block w-100" alt="${food.product_name}"
                                         style="height: 350px; object-fit: contain; object-position: center;">
                                </div>
                            </c:forEach>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </c:when>
            </c:choose>
        </div>

        <!-- Phần hiển thị thông tin sản phẩm -->
        <div class="col-md-5">
            <h1 class="h2">${food.product_name}</h1>
            <p class="mb-3">Cửa hàng: ${store.store_name}</p>
            <div class="fs-4 fw-bold mb-3">
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

            <!-- Điều khiển số lượng -->
            <div class="d-flex align-items-center mb-3">
                <button id="decrease" class="btn btn-outline-secondary" onclick="changeQuantity(${food.product_id}, -1)">-</button>
                <input id="quantity_${food.product_id}" type="number" value="1" class="form-control text-center mx-2" style="width: 60px;" min="1" max="${food.stock_quantity}">
                <button id="increase" class="btn btn-outline-secondary" onclick="changeQuantity(${food.product_id}, 1)">+</button>
            </div>

            <!-- Nút chức năng: Thêm vào giỏ hàng, Mua ngay, Chat -->
            <div class="d-flex gap-3 mb-3">
                <c:choose>
                    <c:when test="${food.stock_quantity == 0}">
                        <span class="text-muted fw-bold d-flex align-items-center">
                            <i class="fas fa-exclamation-circle text-danger me-1"></i> Hết hàng
                        </span>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-warning text-dark" onclick="addToCart(${food.product_id}, ${food.price}, getQuantity(${food.product_id}))">
                            <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                        </button>
                        <a href="/homeUser?action=buyNow&id=${food.product_id}" class="btn btn-danger">
                            <i class="fas fa-bolt"></i> Mua ngay
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="/chat?product_id=${food.product_id}" class="btn btn-primary">
                    <i class="fas fa-comments"></i> Chat ngay
                </a>
            </div>

            <script>
                function getQuantity(productId) {
                    const input = document.querySelector(`#quantity_${productId}`);
                    return input ? parseInt(input.value, 10) : 1;
                }

                function changeQuantity(productId, delta) {
                    const input = document.querySelector(`#quantity_${productId}`);
                    if (input) {
                        let currentValue = parseInt(input.value, 10) || 1;
                        let newValue = currentValue + delta;
                        const max = parseInt(input.max, 10) || Infinity;
                        if (newValue >= 1 && newValue <= max) {
                            input.value = newValue;
                        }
                    }
                }
            </script>

            <!-- Thông tin bổ sung -->
            <h2 class="h5 mt-4">Cam kết chất lượng</h2>
            <ul class="ms-3">
                <li>Chế biến đảm bảo an toàn vệ sinh thực phẩm.</li>
                <li>Sử dụng nguyên liệu chất lượng, tươi sạch, có nguồn gốc rõ ràng.</li>
                <li>Hương vị đặc trưng, thơm ngon, hấp dẫn.</li>
                <li>Đáp ứng tiêu chí nhanh chóng, tiện lợi nhưng vẫn đầy đủ dinh dưỡng</li>
            </ul>
            <h2 class="h5 mt-4">Sản phẩm đi kèm</h2>
            <ul class="ms-3">
                <li>Dụng cụ hỗ trợ ăn uống như muỗng, đũa, ống hút, khăn giấy…</li>
                <li>Gia vị bổ sung như tương ớt, tương cà, đường, chanh… (tùy món).</li>
            </ul>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/view/user/product/addToCart.js"></script>
<script>
    // Sự kiện điều khiển số lượng (song song với hàm changeQuantity)
    const quantityInput = document.getElementById('quantity_${food.product_id}');
    const increaseBtn = document.getElementById('increase');
    const decreaseBtn = document.getElementById('decrease');

    increaseBtn.addEventListener('click', () => {
        if (parseInt(quantityInput.value) < ${food.stock_quantity})
            quantityInput.value = parseInt(quantityInput.value) + 1;
    });

    decreaseBtn.addEventListener('click', () => {
        if (parseInt(quantityInput.value) > 1)
            quantityInput.value = parseInt(quantityInput.value) - 1;
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
