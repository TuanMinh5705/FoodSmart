<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 26/02/2025
  Time: 3:54 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <title>Nội dung chính</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
</head>
<body style="background-color: rgba(201,201,201,0.25)">
<div class="p-4">
    <h3 class="text-2xl font-bold mt-4 flex items-center">
        <i class="bi bi-fire text-red-500 text-3xl mr-2"></i>SẢN PHẨM BÁN CHẠY
    </h3>
    <div class="swiper mySwiper mt-4 px-4 " style="margin-right: 80px;margin-left: 80px;">
        <div class="swiper-wrapper">
            <c:forEach var="food" items="${foodListHotSale}">
                <div class="swiper-slide">
                    <div class="bg-white p-4 rounded relative group shadow-md"
                         style="border: 2px solid rgba(255,190,42,0.15); border-radius: 10px;">
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
                                <!-- Thêm vào bộ sưu tập -->
                                <button class="bg-gray-200 text-gray-600 bg-opacity-50  p-2 rounded-full hover:bg-red-500 hover:text-white"
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
                                        <button class="bg-gray-200 text-gray-600 bg-opacity-50  p-2 rounded-full hover:bg-blue-500 hover:text-white"
                                                onclick="addToCart(${food.product_id}, ${food.price * (1 - food.discount / 100.0)})">
                                            <i class="bi bi-cart-plus-fill text-lg" title="Thêm vào giỏ hàng"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>

                                <button class="bg-gray-200 bg-opacity-60  text-gray-600 p-2 rounded-full hover:bg-green-500 hover:text-white">
                                    <a href="/homeUser?action=showFoodDetail&id=${food.product_id}">
                                        <i class="bi bi-eye text-lg" title="Xem chi tiết"></i>
                                    </a>
                                </button>
                            </div>
                        </div>
                        <div class="mt-2">
                            <!-- Tên món ăn -->
                            <h4 class="text-lg font-bold">${food.product_name}</h4>

                            <!-- Khu vực giá có chiều cao cố định để đồng nhất kích thước -->
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

                                <!-- Nút mua ngay căn ngang với giá -->
                                <c:choose>
                                    <c:when test="${food.stock_quantity == 0}">
                <span class="text-gray-500 font-bold flex items-center">
                    <i class="bi bi-exclamation-circle-fill text-red-500 mr-1"></i> Hết hàng
                </span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/homeUser?action=buyNow&id=${food.product_id}"
                                           class="bg-orange-500 text-white py-2 px-3 rounded text-sm hover:bg-orange-600 transition-transform duration-300 flex items-center">
                                            <i class="bi bi-bag-check-fill text-sm mr-1"></i> Mua ngay
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Đánh giá và số lượng đã bán -->
                            <p class="text-yellow-500 mt-1">
                                <i class="fas fa-star"></i> 4.5 | Đã bán ${food.total_sold}
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Nút điều hướng -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>


    <h3 class="text-2xl font-bold mt-8 flex items-center">
        <i class="bi bi-lightbulb text-yellow-500 text-3xl mr-2"></i>SẢN PHẨM ĐỀ XUẤT
    </h3>

    <div class="px-20">
        <div class="grid grid-cols-6 gap-x-[7px] gap-y-[7px] mt-4 mb-4">
            <c:forEach var="food" items="${foodListFoodRandom}">
                <div class="bg-white p-4 rounded relative group shadow-md"
                     style="border: 2px solid rgba(255,190,42,0.15); border-radius: 10px;">
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
        </div>
    </div>



    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="/view/user/product/addToCart.js"></script>
<script>
    const swiper = new Swiper(".mySwiper", {
        slidesPerView: 5,
        spaceBetween: 7,
        loop: true,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        breakpoints: {
            640: { slidesPerView: 1 },
            768: { slidesPerView: 2 },
            1024: { slidesPerView: 5 },
        },
    });
</script>
</body>
</html>
