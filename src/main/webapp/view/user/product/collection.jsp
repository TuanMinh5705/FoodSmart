<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Bộ sưu tập yêu thích</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>
<body>
<h2 class="text-2xl font-bold text-orange-500 mt-4 ml-4">SẢN PHẨM YÊU THÍCH ❤️</h2>
<div class="mt-4 mx-4 bg-white shadow-lg p-4 rounded-lg">
    <c:choose>
        <c:when test="${not empty foodList}">
            <table class="w-full border-collapse border border-gray-300">
                <tbody>
                <c:forEach var="food" items="${foodList}">
                    <tr class="border-b border-gray-200">
                        <td class="p-2 text-center">
                            <input type="checkbox" class="form-checkbox h-5 w-5 text-orange-500">
                        </td>
                        <td class="p-2 w-20">
                            <c:if test="${not empty food.list_food_images}">
                                <img src="${pageContext.request.contextPath}/foodSmartImages/product/${food.list_food_images[0].image_path}"
                                     alt="${food.product_name}"
                                     class="w-64 h-64 object-contain object-center rounded mx-auto">
                            </c:if>
                            <c:if test="${empty food.list_food_images}">
                                <img src="../../../images/product_default.png"
                                     alt="Không có ảnh"
                                     class="w-64 h-64 object-contain object-center rounded mx-auto">
                            </c:if>
                     </td>
                        <td class="p-2 font-medium">${food.product_name}</td>
                        <td class="p-2 text-red-500 font-bold">
                            <fmt:formatNumber value="${food.price}" pattern="#,###"/> đ
                        </td>
                        <td class="p-2 text-center">
                            <a href="/homeUser?action=buyNow&id=${food.product_id}">
                            <button class="text-blue-500 hover:text-blue-700" onclick="addToCart(${food.product_id}, ${food.price})">
                                <i class="bi bi-cart text-xl" title="Thêm vào giỏ hàng"></i>
                            </button>
                            </a>

                        </td>
                        <td class="p-2 text-center">
                            <button class="text-red-500 hover:text-red-700"  onclick="showDeleteModal({ id: ${food.product_id}, url: '/homeUser', action: 'removeCollection' })">
                                <i class="bi bi-trash text-xl" title="Xóa khỏi danh sách"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="text-center text-gray-500 text-lg">Không có sản phẩm nào trong bộ sưu tập.</p>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function addToCart(productId, price) {
        alert('Đã thêm sản phẩm ' + productId + ' vào giỏ hàng với giá ' + price + 'đ');
    }
</script>
<jsp:include page="../../admin/system/modalConfirmDelete.jsp" />
</body>
</html>
