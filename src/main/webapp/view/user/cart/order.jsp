<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
</head>
<body class="bg-gray-200">
<div class="max-w-5xl mx-auto p-4">
    <div class="bg-white p-6 rounded-lg shadow-lg flex flex-col md:flex-row">

        <div class="w-full md:w-2/3 p-4">
            <div class="mb-4">
                <h2 class="text-lg font-bold">Chọn địa chỉ giao hàng</h2>
                <select class="w-full p-2 border rounded">
                    <c:forEach var="ad" items="${accountDetails}">
                        <option value="${ad.address}">${ad.address}</option>
                    </c:forEach>
                    <option value="new">Thêm địa chỉ mới...</option>
                </select>
                <button class="mt-2 text-blue-500">Chỉnh sửa địa chỉ</button>
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

            <button class="bg-orange-500 text-white px-4 py-2 rounded w-full">Đặt hàng</button>
        </div>

        <!-- Cột bên phải: Danh sách sản phẩm -->
        <div class="w-full md:w-1/3 p-4">
            <div class="bg-gray-100 p-4 rounded-lg shadow">
                <h2 class="text-lg font-bold mb-4">Tổng đơn hàng</h2>
                <div class="mb-4 border-b pb-2">
                    <div class="flex justify-between font-bold">
                        <span>Sản phẩm</span>
                        <span>Giá</span>
                        <span>SL</span>
                    </div>
                </div>

                <div class="mb-4">
                    <c:forEach var="item" items="${order.orderItems}">
                        <c:set var="food" value="${productMap[item.productId]}" />
                        <div class="flex justify-between items-center border-b py-2">
                            <span>${food.product_name}</span>
                            <span>${item.priceAtTime} đ</span>
                            <span>${item.quantity}</span>
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
</body>
</html>
