<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <title>Nội dung sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
</head>
<body>
<jsp:include page="../system/menu.jsp" />

<!-- Breadcrumb -->
<div class="text-sm text-gray-600 mt-6 ml-4 mb-4">
    <a href="/homeUser" class="hover:underline">Trang chủ</a> /
    <c:if test="${not empty category.category_name}">
        <span>${category.category_name}</span>
    </c:if>
    <c:if test="${not empty keyword}">
        <span>Tìm kiếm</span>
        <p>Kết quả tìm kiếm của từ khoá : `${keyword}`</p>
    </c:if>
    <c:if test="${not empty sessionScope.collection}">
        <span>Bộ sưu tập</span>
    </c:if>
</div>

<!-- Phần Cửa hàng -->
<h3 class="text-2xl font-bold mt-4 flex items-center">Cửa hàng</h3>
<!-- Sử dụng px-4 để tạo khoảng cách lề 2 bên -->
<div class="px-4">
    <!-- Grid 4 cột cho màn hình nhỏ -->
    <div class="grid grid-cols-4 gap-6 mt-4">
        <c:choose>
            <c:when test="${not empty storeList}">
                <c:forEach var="store" items="${storeList}">
                    <a href="/homeUser?action=showStore&store_id=${store.store_id}" class="block border rounded-2xl p-4 shadow-lg hover:shadow-xl transition">
                        <img src="${pageContext.request.contextPath}/images/avatars/${store.avt_path}"
                             alt="Ảnh đại diện cửa hàng"
                             class="w-24 h-24 object-cover rounded-full mx-auto">
                        <p class="text-xl font-semibold text-center mt-4">${store.store_name}</p>
                    </a>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-muted fs-3">Không có cửa hàng nào!</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Phần Sản phẩm -->
<h3 class="text-2xl font-bold mt-4 flex items-center">Sản phẩm</h3>
<div class="px-4">
    <!-- Grid 4 cột trên màn hình nhỏ -->
    <div class="grid grid-cols-6 gap-2 mt-2">
        <c:choose>
            <c:when test="${not empty foodList}">
                <c:forEach var="food" items="${foodList}">
                    <div class="bg-white p-4 rounded relative group shadow-md" style="border: 2px solid transparent; border-image: linear-gradient(to right, #FACC15, #FB923C) 1;">
                        <div class="relative">
                            <c:if test="${not empty food.list_food_images}">
                                <img src="${pageContext.request.contextPath}/images/product/${food.list_food_images[0].image_path}"
                                     alt="${food.product_name}"
                                     class="w-48 h-48 object-contain object-center rounded mx-auto">
                            </c:if>
                            <c:if test="${empty food.list_food_images}">
                                <img src="../../../images/product_default.png"
                                     alt="Không có ảnh"
                                     class="w-48 h-48 object-contain object-center rounded mx-auto">
                            </c:if>

                            <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-3 opacity-0 group-hover:opacity-100 transition-opacity">
                                <button class="bg-gray-200 text-gray-600 bg-opacity-50 p-2 rounded-full hover:bg-red-500 hover:text-white"
                                        onclick="addToCollection(${food.product_id})">
                                    <i class="bi bi-bookmark-heart-fill text-lg" title="Thêm vào bộ sưu tập"></i>
                                </button>

                                <c:choose>
                                    <c:when test="${food.stock_quantity == 0}">
                                        <button class="bg-gray-300 text-gray-500 bg-opacity-50 p-2 rounded-full cursor-not-allowed" disabled>
                                            <i class="bi bi-lock-fill text-lg" title="Hết hàng"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="bg-gray-200 text-gray-600 bg-opacity-50 p-2 rounded-full hover:bg-blue-500 hover:text-white"
                                                onclick="addToCart(${food.product_id}, ${food.price * (1 - food.discount / 100.0)})">
                                            <i class="bi bi-cart-plus-fill text-lg" title="Thêm vào giỏ hàng"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>

                                <button class="bg-gray-200 bg-opacity-60 text-gray-600 p-2 rounded-full hover:bg-green-500 hover:text-white">
                                    <a href="/homeUser?action=showFoodDetail&id=${food.product_id}">
                                        <i class="bi bi-eye text-lg" title="Xem chi tiết"></i>
                                    </a>
                                </button>
                            </div>
                        </div>
                        <div class="mt-2">
                            <h4 class="text-lg font-bold">${food.product_name}</h4>

                            <div class="flex items-center justify-between mt-1">
                                <div class="min-h-[50px] flex flex-col justify-end">
                                    <c:if test="${food.discount > 0}">
                                        <div class="text-gray-500 text-sm line-through">
                                            <fmt:formatNumber value="${food.price}" pattern="#,###"/> ₫
                                            <span class="text-green-500 font-semibold">-${food.discount}%</span>
                                        </div>
                                    </c:if>

                                    <p class="text-red-500 font-bold text-lg">
                                        <c:set var="discountPrice" value="${food.price * (1 - food.discount / 100.0)}"/>
                                        <fmt:formatNumber value="${discountPrice}" pattern="#,###"/> ₫
                                    </p>
                                </div>

                                <c:choose>
                                    <c:when test="${food.stock_quantity == 0}">
                <span class="text-gray-500 font-bold flex items-center">
                    <i class="bi bi-exclamation-circle-fill text-red-500 mr-1"></i> Hết hàng
                </span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/homeUser?action=buyNow&id=${food.product_id}"
                                           class="bg-orange-500 text-white py-2 px-3 rounded text-sm hover:bg-orange-600 transition-transform duration-300 flex items-center mt-2">
                                            <i class="bi bi-bag-check-fill text-sm mr-1"></i> Mua ngay
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <p class="text-yellow-500 mt-1">
                                <i class="fas fa-star"></i> 4.5 | Đã bán ${food.total_sold}
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <p class="text-muted fs-3">Không có sản phẩm nào!</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/view/user/product/addToCart.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</body>
</html>