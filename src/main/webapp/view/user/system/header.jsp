<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="bg-yellow-400 fixed top-0 left-0 w-full z-50 shadow-md">
    <!-- Xoá max-w-7xl mx-auto, thay bằng w-full + px-4/px-6 -->
    <div class="w-full px-6 py-3 flex items-center justify-between">
        <!-- Left: Logo & Navigation -->
        <div class="flex items-center space-x-6">
            <a href="/homeUser">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Smart Food Logo" class="h-20">
            </a>
            <nav class="flex space-x-6">
                <a href="/homeUser" class="text-black font-bold text-lg">Trang chủ</a>
                <a href="#" class="text-black font-bold text-lg">Khuyến mãi</a>
            </nav>
        </div>

        <!-- Center: Search -->
        <div class="flex-1 mx-10 relative">
            <form action="/homeUser?action=searchProduct" method="post">
                <input type="text" placeholder="Tìm kiếm món ăn hoặc nhà hàng" name="keyword"
                       class="w-full p-2 pl-4 pr-10 rounded-lg border border-gray-300 shadow-sm focus:outline-none">
                <i class="fas fa-search absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
            </form>
        </div>

        <!-- Right: Account & Icons -->
        <div class="flex items-center space-x-6">
            <a href="/cart" title="Giỏ hàng" class="text-black text-2xl">
                <i class="fas fa-shopping-cart"></i>
            </a>
            <a href="/favorites" title="Bộ sưu tập" class="text-black text-2xl">
                <i class="fas fa-heart"></i>
            </a>
            <a href="/notifications" title="Thông báo" class="text-black text-2xl">
                <i class="fas fa-bell"></i>
            </a>

            <div class="relative group">
                <button class="flex items-center focus:outline-none">
                    <i class="fas fa-user-circle text-black text-2xl"></i>
                    <span class="ml-2 text-black text-lg">
                        <c:out value="${sessionScope.loggedInAccount.username}" default="Đăng nhập"/>
                    </span>
                </button>
                <!-- Dropdown menu -->
                <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300 z-50">
                    <a href="/userInformation?action=showUserInformation" class="block px-4 py-2 text-gray-800 hover:bg-gray-200">
                        Thông tin tài khoản
                    </a>
                    <a href="/orders" class="block px-4 py-2 text-gray-800 hover:bg-gray-200">Đơn hàng</a>
                    <a href="/authenticate?action=logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-200">
                        <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>
