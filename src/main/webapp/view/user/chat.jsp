<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="merchantAvatar" value="${pageContext.request.contextPath}/images/avatars/${merchant.avt_path}" />
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <title>Chat tư vấn</title>
</head>
<body class="bg-white flex items-center justify-center min-h-screen">
<div class="container mx-auto p-4">
    <!-- Tiêu đề trang -->
    <div class="flex items-center mb-4">
        <i class="fas fa-home text-xl"></i>
        <span class="ml-2 text-lg">Liên hệ hỗ trợ</span>
    </div>
    <div class="border border-blue-500 rounded-lg overflow-hidden">
        <div class="flex">
            <!-- Sidebar: danh sách chat (ở đây hiển thị tạm một vài mục ví dụ) -->
            <div class="w-1/4 bg-yellow-200 p-4">
                <div class="mb-4">
                    <div class="relative flex items-center p-2 bg-white rounded-lg shadow">
                        <img alt="Avatar của ${merchant.store_name}" class="w-12 h-12 rounded-full" height="50" src="${merchantAvatar}" width="50"/>
                        <span class="ml-2">${merchant.store_name}</span>
                        <!-- Ví dụ số tin nhắn chưa đọc -->
                        <span class="absolute top-0 right-0 bg-red-500 text-white text-xs rounded-full px-2">5</span>
                    </div>
                </div>
                <!-- Có thể lặp thêm danh sách chat khác nếu cần -->
                <div class="mb-4">
                    <div class="flex items-center p-2 bg-white rounded-lg shadow">
                        <img alt="Avatar của ${merchant.store_name}" class="w-12 h-12 rounded-full" height="50" src="${merchantAvatar}" width="50"/>
                        <span class="ml-2">${merchant.store_name}</span>
                    </div>
                </div>
            </div>
            <!-- Khu vực chat chính -->
            <div class="w-3/4 bg-white p-4">
                <!-- Header Chat: hiển thị thông tin merchant và món ăn đang được tư vấn -->
                <div class="bg-yellow-500 p-4 rounded-t-lg flex items-center">
                    <img alt="Avatar của ${merchant.store_name}" class="w-12 h-12 rounded-full" height="50" src="${merchantAvatar}" width="50"/>
                    <div class="ml-2">
                        <span class="text-white text-lg font-bold">${merchant.store_name}</span>
                        <div class="text-white text-sm">Tư vấn về: ${food.product_name}</div>
                    </div>
                </div>
                <!-- Khu vực hiển thị tin nhắn -->
                <div class="p-4">
                    <!-- Tin nhắn từ merchant -->
                    <div class="flex items-start mb-4">
                        <img alt="Avatar của ${merchant.store_name}" class="w-12 h-12 rounded-full" height="50" src="${merchantAvatar}" width="50"/>
                        <div class="ml-2">
                            <p class="font-bold text-lg">
                                Xin chào, bạn cần tư vấn về sản phẩm "<strong>${food.product_name}</strong>"?
                            </p>
                        </div>
                    </div>
                    <!-- Ví dụ tin nhắn từ user -->
                    <div class="flex items-start mb-4">
                        <div class="ml-auto">
                            <p class="text-lg">Món ăn này có thành phần gì và có khuyến mãi không?</p>
                        </div>
                        <img alt="Avatar của bạn" class="w-12 h-12 rounded-full" height="50" src="${pageContext.request.contextPath}/images/avatars/${loggedInAccount.avtPath}" width="50"/>
                    </div>
                    <!-- Tin nhắn phản hồi của merchant -->
                    <div class="flex items-start">
                        <img  class="w-12 h-12 rounded-full" height="50" src="${pageContext.request.contextPath}/images/avatars/${merchant.avt_path}" width="50"/>
                        <div class="ml-2">
                            <p class="text-lg">
                                Chào bạn, sản phẩm "<strong>${food.product_name}</strong>" được làm từ những nguyên liệu tươi ngon.
                                Hiện tại đang giảm giá <strong>${food.discount}%</strong> nếu có khuyến mãi.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Khu vực nhập tin nhắn -->
                <div class="bg-green-200 p-4 rounded-b-lg flex items-center">
                    <input class="flex-grow p-2 rounded-lg border border-gray-300" placeholder="Nhập tin nhắn..." type="text"/>
                    <button class="ml-2 text-blue-500">
                        <i class="fas fa-paper-plane text-2xl"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
