<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 27/02/2025
  Time: 7:32 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <title>Nội dung sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
</head>
<body>
<jsp:include page="../system/menu.jsp" />

<div class="text-sm text-gray-600 mt-4 ml-4">
    <a href="/homeUser" class="hover:underline">Trang chủ</a> /
    <c:if test="${not empty category.category_name}">
        <span>${category.category_name}</span>
    </c:if>
    <c:if test="${not empty keyword}">
        <span>Tìm kiếm với từ khoá : `${keyword}`</span>
    </c:if>
</div>
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mt-4">
    <c:choose>
        <c:when test="${not empty foodList}">
            <c:forEach var="food" items="${foodList}">
                <div class="bg-white p-4 rounded relative group shadow-md" style="border: 2px solid transparent; border-image: linear-gradient(to right, #FACC15, #FB923C) 1;">
                    <div class="relative">
                        <c:if test="${not empty food.list_food_images}">
                            <img src="${pageContext.request.contextPath}/foodSmartImages/product/${food.list_food_images[0].image_path}"
                                 alt="${food.product_name}"
                                 class="w-64 h-64 object-cover rounded mx-auto">
                        </c:if>
                        <c:if test="${empty food.list_food_images}">
                            <img src="../../../images/product_default.png"
                                 alt="Không có ảnh"
                                 class="w-64 h-64 object-cover rounded mx-auto">
                        </c:if>

                        <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-4 opacity-0 group-hover:opacity-100 transition-opacity">
                            <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-red-500 hover:text-white">
                                <i class="bi bi-heart" title="Thêm vào bộ sưu tập"></i>
                            </button>
                            <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-blue-500 hover:text-white"
                                    onclick="addToCart(${food.product_id}, ${food.price})">
                                <i class="bi bi-cart" title="Thêm vào giỏ hàng"></i>
                            </button>
                            <button class="bg-gray-200 text-gray-600 p-4 rounded-full hover:bg-green-500 hover:text-white">
                                <a href="/homeUser?action=showFoodDetail&id=${food.product_id}">
                                    <i class="bi bi-eye" title="Xem chi tiết"></i>
                                </a>
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
        </c:when>

        <c:otherwise>
                    <p class="text-muted fs-3">Không có sản phẩm nào!</p>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/view/user/product/addToCart.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

</body>
</html>
