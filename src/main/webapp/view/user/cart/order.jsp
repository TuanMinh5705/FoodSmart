<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
</head>
<body class="bg-gray-200">
<div class="text-sm text-gray-600 mb-4">
    <a href="/homeUser" class="hover:underline">Trang chủ</a> /
    <a href="/homeUser?action=showCartStore" class="hover:underline">Giỏ hàng</a> /<span>Đặt hàng</span>
</div>
<form action="/homeUser?action=payment" method="post">
    <div class="max-w-7xl mx-auto p-4">
        <div class="bg-white p-6 rounded-lg shadow-lg flex flex-col md:flex-row gap-4">
            <div class="w-full md:w-2/3 p-4">
                <div class="mb-4">
                    <div class="flex justify-between items-center mb-2">
                        <h2 class="text-lg font-bold">Chọn địa chỉ giao hàng</h2>
                        <button class="text-blue-500 hover:text-blue-700 flex items-center">
                            <i class="fas fa-plus mr-2"></i> Thêm địa chỉ mới
                        </button>
                    </div>
                    <div class="border rounded p-4 bg-gray-100">
                        <c:forEach var="ad" items="${accountDetails}">
                            <div class="flex justify-between items-center p-3 mb-2 border rounded bg-white">
                                <div class="flex items-start">
                                    <input type="radio" name="address" value="${ad.accountDetailID}" class="mr-2">
                                    <div>
                                        <c:if test="${ad.isDefault}">
                                            <div class="text-sm text-blue-500">Địa chỉ mặc định</div>
                                        </c:if>
                                        <div class="font-bold">Tên người nhận: <c:out
                                                value="${sessionScope.loggedInAccount.username}"/></div>
                                        <div class="text-sm text-gray-600">Số điện thoại: <c:out
                                                value="${ad.phonenumber}"/></div>
                                        <div class="text-sm text-gray-600">Địa chỉ: <c:out value="${ad.address}"/></div>
                                    </div>
                                </div>
                                <button class="text-blue-500 hover:text-blue-700 flex items-center">
                                    <i class="fas fa-edit mr-1"></i> Chỉnh sửa
                                </button>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="mb-4">
                    <h2 class="text-lg font-bold">Phương thức thanh toán</h2>
                    <label class="flex items-center mb-2">
                        <input type="radio" name="payment" value="cod" class="mr-2" checked>
                        Thanh toán khi nhận hàng
                    </label>
                    <label class="flex items-center">
                        <input type="radio" name="payment" value="bank" class="mr-2">
                        Chuyển khoản ngân hàng
                    </label>
                </div>

                <button type="submit" class="bg-orange-500 text-white px-4 py-2 rounded w-full"
                onclick="showToast('Đặt hàng thành công!','success')">Đặt hàng</button>
            </div>

            <!-- Cột bên phải: Danh sách sản phẩm -->
            <div class="w-full md:w-1/3 p-4">
                <div class="bg-gray-100 p-4 rounded-lg shadow">
                    <h2 class="text-lg font-bold mb-4">Tổng đơn hàng</h2>
                    <div class="mb-4 border-b pb-2">
                        <div class="flex justify-between font-bold">
                            <span class="w-1/2">Sản phẩm</span>
                            <span class="w-1/4">Giá</span>
                            <span class="w-1/4 text-center">Số lượng</span>
                        </div>
                    </div>

                    <div class="mb-4">
                        <c:forEach var="item" items="${order.orderItems}">
                            <c:set var="food" value="${productMap[item.productId]}"/>
                            <div class="flex justify-between items-center border-b py-2">
                                <span class="w-1/2">${food.product_name}</span>
                                <span class="w-1/4"><fmt:formatNumber pattern="#,###" value="${item.priceAtTime}"/> đ</span>
                                <span class="w-1/4 text-center">${item.quantity}</span>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="flex justify-between items-center font-bold">
                        <span>Tổng:</span>
                        <span>
                       <fmt:formatNumber pattern="#,###" value="${totalAmount}"/> đ</span>
                        </span>
                    </div>
                </div>
            </div>

        </div>
    </div>
</form>
</body>
</html>
