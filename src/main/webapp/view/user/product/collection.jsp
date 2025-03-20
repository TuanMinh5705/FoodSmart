<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bộ sưu tập yêu thích</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">
<header class="p-4 bg-white shadow">
    <h2 class="text-xl font-bold text-orange-500">SẢN PHẨM YÊU THÍCH ❤️</h2>
</header>
<main class="flex-grow flex items-center justify-center py-16">
    <div class="container mx-auto">
        <c:choose>
            <c:when test="${not empty foodList}">
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-2">
                    <c:forEach var="food" items="${foodList}">
                        <div class="bg-white shadow rounded-lg overflow-hidden flex flex-col">
                            <div class="relative">
                                <c:if test="${not empty food.list_food_images}">
                                    <img src="${pageContext.request.contextPath}/images/product/${food.list_food_images[0].image_path}"
                                         alt="${food.product_name}"
                                         class="w-full h-36 object-contain">
                                </c:if>
                                <c:if test="${empty food.list_food_images}">
                                    <img src="../../../images/product_default.png"
                                         alt="Không có ảnh"
                                         class="w-full h-36 object-contain">
                                </c:if>
                            </div>
                            <div class="p-2 flex flex-col flex-grow">
                                <h3 class="font-medium text-base mb-1">${food.product_name}</h3>
                                <p class="text-red-500 font-bold text-sm mb-2">
                                    <fmt:formatNumber value="${food.price}" pattern="#,###"/> đ
                                </p>
                                <div class="mt-auto flex justify-between">
                                    <a href="/homeUser?action=buyNow&id=${food.product_id}" class="text-blue-500 hover:text-blue-700">
                                        <button onclick="addToCart(${food.product_id}, ${food.price})">
                                            <i class="bi bi-cart text-lg" title="Thêm vào giỏ hàng"></i>
                                        </button>
                                    </a>
                                    <button class="text-red-500 hover:text-red-700" onclick="showDeleteModal({ id: ${food.product_id}, url: '/homeUser', action: 'removeCollection' })">
                                        <i class="bi bi-trash text-lg" title="Xóa khỏi danh sách"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-center text-gray-500 text-base">Không có sản phẩm nào trong bộ sưu tập.</p>
            </c:otherwise>
        </c:choose>
    </div>
</main>
<jsp:include page="../../admin/system/modalConfirmDelete.jsp" />
<script>
    function addToCart(productId, price) {
        alert('Đã thêm sản phẩm ' + productId + ' vào giỏ hàng với giá ' + price + 'đ');
    }
</script>
</body>
</html>
