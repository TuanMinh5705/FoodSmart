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
<div class="container mt-8">
    <div class="text-sm text-gray-600 mb-16 ml-4" style="margin-top: 160px">
        <a href="/homeUser" class="hover:underline">Trang chủ</a> /
        <c:if test="${not empty food.product_name}">
            <span>${food.product_name}</span>
        </c:if>
    </div>

    <div class="row ">
        <div class="col-md-6 mt-8">
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

                        <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev" style="background: none; border-radius: 50%;">
                            <span class="carousel-control-prev-icon" aria-hidden="true" style="filter: invert(56%) sepia(72%) saturate(861%) hue-rotate(1deg) brightness(102%) contrast(104%);"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next" style="background: none; border-radius: 50%;">
                            <span class="carousel-control-next-icon" aria-hidden="true" style="filter: invert(56%) sepia(72%) saturate(861%) hue-rotate(1deg) brightness(102%) contrast(104%);"></span>
                            <span class="visually-hidden">Next</span>
                        </button>

                    </div>
                </c:when>
            </c:choose>
        </div>


        <div class="col-md-5 ">
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
                <button id="decrease" class="btn btn-outline-secondary" onclick="changeQuantity(${food.product_id}, -1)">-</button>
                <input id="quantity_${food.product_id}" type="number" value="1" class="form-control text-center mx-2" style="width: 60px;" min="1" max="${food.stock_quantity}">
                <button id="increase" class="btn btn-outline-secondary" onclick="changeQuantity(${food.product_id}, 1)">+</button>
            </div>

            <div class="d-flex gap-3">
                <button class="btn btn-warning text-dark" onclick="addToCart(${food.product_id}, ${food.price}, getQuantity(${food.product_id}))">
                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>

                <a href="/homeUser?action=buyNow&id=${food.product_id}"
                   class="bg-orange-500 text-white py-2 px-4 rounded hover:bg-orange-600 transition-transform duration-300">
                    <i class="bi bi-bag"></i> <span class="ml-2">Mua ngay</span>
                </a>

                <a href="/chat?storeId=${store.id}" class="btn btn-primary">
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


            <h2 class="h5 mt-4">Mô tả chi tiết sản phẩm</h2>
            <ul style="list-style-type: disc; margin-left: 1.5rem;">
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
<script src="/view/user/product/addToCart.js"></script>
<script>
    function changeMainImage(imagePath) {
        document.getElementById('mainImage').src = imagePath;
    }


        const quantityInput = document.getElementById('quantity_${food.product_id}');
        const increaseBtn = document.getElementById('increase');
        const decreaseBtn = document.getElementById('decrease');

        increaseBtn.addEventListener('click', () => {
            if(parseInt(quantityInput.value) < ${food.stock_quantity})
        quantityInput.value = parseInt(quantityInput.value) + 1;
    });

        decreaseBtn.addEventListener('click', () => {
        if (parseInt(quantityInput.value) > 1) {
        quantityInput.value = parseInt(quantityInput.value) - 1;
    }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
