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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <title>Nội dung chính</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
</head>
<body>
<div class="p-4">
    <h3 class="text-2xl font-bold mt-4 flex items-center">
        <i class="bi bi-fire text-red-500 text-3xl mr-2"></i>SẢN PHẨM BÁN CHẠY
    </h3>
    <!-- Swiper Container -->
    <div class="swiper mySwiper mt-4">
        <div class="swiper-wrapper">
            <c:forEach var="food" items="${foodListHotSale}">
                <div class="swiper-slide">
                    <div class="bg-white p-4 rounded relative group shadow-md"
                         style="border: 2px solid transparent; border-image: linear-gradient(to right, #fa9e15, #fb3c3c) 1;">


                        <div class="relative">
                            <c:if test="${not empty food.list_food_images}">
                                <img src="${pageContext.request.contextPath}/foodSmartImages/product/${food.list_food_images[0].image_path}"
                                     alt="${food.product_name}"
                                     class="w-64 h-64 object-cover rounded mx-auto">
                            </c:if>
                            <c:if test="${ empty food.list_food_images}">
                                <img src="../../../images/product_default.png"
                                     alt="Không có ảnh"
                                     class="w-64 h-64 object-cover rounded mx-auto">
                            </c:if>
                                <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-4 opacity-0 group-hover:opacity-100 transition-opacity">
                                    <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-red-500 hover:text-white">
                                        <i class="bi bi-heart" title="Thêm vào bộ sưu tập"></i>
                                    </button>
                                    <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-blue-500 hover:text-white">
                                        <i class="bi bi-cart" title="Thêm vào giỏ hàng"></i>
                                    </button>
                                    <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-green-500 hover:text-white">
                                        <a href="/homeUser?action=showFoodDetail&id=${food.product_id}"><i
                                                class="bi bi-eye" title="Xem chi tiết">
                                        </i></a>
                                    </button>
                                </div>
                            </div>

                        <div class="mt-2">
                            <h4 class="text-lg font-bold">${food.product_name}</h4>
                            <div class="flex items-center justify-between mt-2">
                                <p class="text-red-500 font-bold mt-1">
                                    <c:set var="discountPrice" value="${food.price * (1 - food.discount / 100.0)}"/>
                                    <fmt:formatNumber value="${discountPrice}" pattern="#,###"/> ₫

                                    <c:if test="${food.discount > 0}">
                                        <span class="line-through text-gray-500">
                                            <fmt:formatNumber value="${food.price}" pattern="#,###"/> ₫
                                        </span>
                                        <span class="text-green-500"> -${food.discount}%</span>
                                    </c:if>
                                </p>

                                <button class="flex items-center bg-orange-500 text-white py-2 px-4 rounded hover:bg-orange-600 transition-transform duration-300 group-hover:translate-x-2">
                                    <i class="bi bi-bag"></i><span class="ml-2 hidden lg:inline">Mua ngay</span>
                                </button>
                            </div>
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
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mt-4">
        <c:forEach var="food" items="${foodListFoodRandom}">
            <div class="bg-white p-4 rounded relative group shadow-md" style="border: 2px solid transparent; border-image: linear-gradient(to right, #FACC15, #FB923C) 1;">
                    <div class="relative">
                        <c:if test="${not empty food.list_food_images}">
                        <img src="${pageContext.request.contextPath}/foodSmartImages/product/${food.list_food_images[0].image_path}"
                             alt="${food.product_name}"
                             class="w-64 h-64 object-cover rounded mx-auto">
                        </c:if>
                        <c:if test="${ empty food.list_food_images}">
                            <img src="../../../images/product_default.png"
                                 alt="Không có ảnh"
                                 class="w-64 h-64 object-cover rounded mx-auto">
                        </c:if>
                        <!-- Các icon hiển thị khi hover -->
                        <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-4 opacity-0 group-hover:opacity-100 transition-opacity">
                            <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-red-500 hover:text-white">
                                <i class="bi bi-heart" title="Thêm vào bộ sưu tập"></i>
                            </button>
                            <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-blue-500 hover:text-white">
                                <i class="bi bi-cart" title="Thêm vào giỏ hàng"></i>
                            </button>
                            <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-green-500 hover:text-white">
                                <a href="/homeUser?action=showFoodDetail&id=${food.product_id}"><i class="bi bi-eye"
                                                                                                   title="Xem chi tiết">
                                </i></a>
                            </button>
                        </div>

                    </div>

                <div class="mt-2">
                    <h4 class="text-lg font-bold">${food.product_name}</h4>
                    <div class="flex items-center justify-between">
                        <p class="text-red-500 font-bold mt-1">
                            <c:set var="discountPrice" value="${food.price * (1 - food.discount / 100.0)}"/>
                            <fmt:formatNumber value="${discountPrice}" pattern="#,###"/> ₫

                            <c:if test="${food.discount > 0}">
                                        <span class="line-through text-gray-500">
                                            <fmt:formatNumber value="${food.price}" pattern="#,###"/> ₫
                                        </span>
                                <span class="text-green-500"> -${food.discount}%</span>
                            </c:if>
                        </p>
                        <button class="bg-orange-500 text-white py-2 px-4 rounded hover:bg-orange-600 transition-transform duration-300">
                            <i class="bi bi-bag"></i><span class="ml-2">Mua ngay</span>
                        </button>
                    </div>
                    <p class="text-yellow-500 mt-1">
                        <i class="fas fa-star"></i> 4.5 | Đã bán ${food.total_sold}
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Bootstrap Icons (nếu chưa có) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</div>

<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
    const swiper = new Swiper(".mySwiper", {
        slidesPerView: 1,
        spaceBetween: 20,
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
            1024: { slidesPerView: 3 },
        },
    });
</script>
</body>
</html>
