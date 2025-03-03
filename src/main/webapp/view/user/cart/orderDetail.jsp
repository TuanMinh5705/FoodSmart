<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Chi Tiết Đơn Hàng</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<div class="max-w-4xl mx-auto p-4">
    <!-- Tiêu đề, breadcrumb -->
    <div class="flex items-center space-x-2 text-gray-600 mb-4">
        <a href="/homeUser" class="hover:underline">Trang chủ</a>
        <span>&gt;</span>
        <span>Chi tiết đơn hàng</span>
    </div>

    <!-- Thông tin cơ bản đơn hàng -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-4">
        <div class="flex justify-between items-center mb-2">
            <span class="text-gray-500">Mã đơn hàng: #<c:out value="${order.orderId}"/></span>
            <span class="bg-blue-500 text-white px-2 py-1 rounded-full text-sm">
                <c:out value="${order.orderStatus}"/>
            </span>
        </div>
        <div class="text-gray-600">
            <p>Ngày đặt: <c:out value="${order.orderDate}"/></p>
            <p>Phương thức thanh toán: <c:out value="${order.paymentMethod}"/></p>
            <p>Trạng thái thanh toán: <c:out value="${order.paymentStatus}"/></p>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="bg-white p-4 rounded-lg shadow-md mb-4">
        <h2 class="text-lg font-semibold mb-4">Danh sách sản phẩm</h2>
        <c:forEach var="item" items="${order.cartItems}">
            <div class="flex items-center justify-between mb-3">
                <div class="flex items-center">
                    <!-- Ảnh sản phẩm (nếu có) -->
                    <img src="https://via.placeholder.com/50"
                         alt="Sản phẩm"
                         class="w-12 h-12 rounded mr-4"/>
                    <div>
                        <!-- Lấy tên sản phẩm -->
                        <p class="font-medium text-gray-800">
                            <c:out value="${item.productName}"/>
                        </p>
                        <p class="text-sm text-gray-500">Số lượng: <c:out value="${item.quantity}"/></p>
                    </div>
                </div>
                <!-- Giá lúc mua * số lượng -->
                <p class="text-gray-700">
                    <c:out value="${item.priceAtTime * item.quantity}"/> đ
                </p>
            </div>
        </c:forEach>
    </div>

    <!-- Tổng đơn hàng -->
    <div class="bg-white p-4 rounded-lg shadow-md">
        <h2 class="text-lg font-semibold mb-4">Tổng đơn hàng</h2>
        <!-- Ví dụ hiển thị phí ship, mã giảm giá,... -->
        <div class="flex justify-between text-gray-700 mb-2">
            <span>Tổng phụ:</span>
            <span>150.000 đ</span> <!-- Tính từ order/cartItems -->
        </div>
        <div class="flex justify-between text-gray-700 mb-2">
            <span>Phí vận chuyển:</span>
            <span>20.000 đ</span>
        </div>
        <div class="flex justify-between text-gray-700 mb-2">
            <span>Mã giảm giá:</span>
            <span>-10.000 đ</span>
        </div>
        <hr class="my-2">
        <div class="flex justify-between text-gray-800 font-semibold">
            <span>Tổng cộng:</span>
            <span>160.000 đ</span>
        </div>
    </div>
</div>
</body>
</html>
git