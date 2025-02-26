<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Header</title>
</head>
<body>
<!-- Header -->
<header class="bg-yellow-400 p-4">
    <div class="container mx-auto flex flex-col md:flex-row items-center justify-between">
        <!-- Left: Logo & Navigation -->
        <div class="flex flex-col md:flex-row items-center space-y-4 md:space-y-0 md:space-x-4">
            <img src="../../../images/logo.png" alt="Smart Food Logo" class="h-16">
            <nav class="flex flex-col md:flex-row space-y-2 md:space-y-0 md:space-x-4">
                <a href="/view/user/homeUser.jsp" class="text-black font-bold text-lg md:text-xl py-2 px-4">Trang chủ</a>
                <a href="#" class="text-black font-bold text-lg md:text-xl py-2 px-4">Khuyến mãi</a>
            </nav>
        </div>

        <!-- Center: Search -->
        <div class="w-full md:w-1/2 my-4 md:my-0 relative">
            <input type="text" placeholder="Tìm kiếm..." class="w-full p-2 pl-10 rounded">
            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
        </div>

        <!-- Right: Account & Icons -->
        <div class="flex items-center space-x-4">
            <i class="fas fa-shopping-cart text-black text-2xl" title="Giỏ hàng"></i>
            <div class="w-px h-8 bg-black"></div>
            <i class="fas fa-heart text-black text-2xl" title="Bộ sưu tập"></i>
            <div class="w-px h-8 bg-black"></div>
            <i class="fas fa-bell text-black text-2xl" title="Thông báo"></i>
            <div class="w-px h-8 bg-black"></div>
            <i class="fas fa-user text-black text-2xl" title="Tài khoản"></i>
        </div>
    </div>
</header>
</body>
</html>
