<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <!-- Load Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
          integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/5hb7U6f9vK5QFRh5H7g+sklh0xI1n6i7dzW4v3"
          crossorigin="anonymous">
</head>
<header class="fixed top-0 left-0 w-full z-50 shadow-md" style="background-color: rgb(255 237 56 / 97%);">
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

        <div class="flex-1 mx-10 relative">
            <form id="searchForm" action="/homeUser?action=searchProduct" method="post">
                <input type="text" placeholder="Tìm kiếm món ăn hoặc nhà hàng" name="keyword"
                       class="w-full p-2 pl-4 pr-10 rounded-lg border border-gray-300 shadow-sm focus:outline-none"
                       id="searchInput" value="${param.keyword}">
                <i class="fas fa-search absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
            </form>
        </div>


        <!-- Right: Account & Icons -->
        <div class="flex items-center space-x-6">
            <!-- Giỏ hàng -->
            <a href="/homeUser?action=showCartStore" title="Giỏ hàng" class="relative text-black text-2xl">
                <i class="fas fa-shopping-cart"></i>
                <span id="cartCount" class="absolute -top-1 -right-3 bg-red-500 text-white text-sm rounded-full px-2">
        <c:out value="${not empty sessionScope.cartCount ? sessionScope.cartCount : 0}" />
    </span>
            </a>

            <!-- Bộ sưu tập -->
            <a href="/homeUser?action=showCollection" title="Bộ sưu tập" class="relative text-black text-2xl">
                <i class="fas fa-heart"></i>
                <span id="collectionCount" class="absolute -top-1 -right-3 bg-red-500 text-white text-sm rounded-full px-2">
        <c:out value="${not empty sessionScope.collectionCount ? sessionScope.collectionCount : 0}" />
    </span>
            </a>
            <a href="/notifications" title="Thông báo" class="text-black text-2xl">
                <i class="fas fa-bell"></i>
            </a>

            <!-- Account Section -->
            <div class="relative group">
                <button class="flex items-center focus:outline-none">
                    <i class="fas fa-user-circle text-black text-2xl"></i>
                    <span class="ml-2 text-black text-lg">
            <c:out value="${sessionScope.loggedInAccount.username}" default="Đăng nhập"/>
        </span>
                </button>
                <!-- Dropdown menu -->
                <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300 z-50 group-hover:block hidden">
                    <a href="/userInformation" class="block px-4 py-2 text-gray-800 hover:bg-gray-200">
                        <i class="fas fa-user-circle"></i> Thông tin tài khoản
                    </a>
                    <a href="/order" class="block px-4 py-2 text-gray-800 hover:bg-gray-200">
                        <i class="bi bi-clipboard-minus-fill"></i> Đơn hàng
                    </a>
                    <a href="javascript:void(0);" onclick="confirmLogout()" class="block px-4 py-2 text-gray-800 hover:bg-gray-200">
                        <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất
                    </a>
                </div>
            </div>

        </div>
    </div>
</header>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function updateBadge(id, count) {
        let badge = document.getElementById(id);
        if (badge) {
            if (count > 0) {
                badge.textContent = count;
                badge.style.display = 'inline-block';
            } else {
                badge.style.display = 'none';
            }
        } else if (count > 0) {
            let parentLink = document.querySelector(`a[title="${id == 'cartCount' ? 'Giỏ hàng' : 'Bộ sưu tập'}"]`);
            if (parentLink) {
                badge = document.createElement('span');
                badge.id = id;
                badge.className = 'absolute -top-1 -right-3 bg-red-500 text-white text-sm rounded-full px-2';
                badge.textContent = count;
                parentLink.appendChild(badge);
            }
        }
    }

    function updateCartCount(count) {
        updateBadge('cartCount', count);
    }

    function updateCollectionCount(count) {
        updateBadge('collectionCount', count);
    }

    let timer;
    document.getElementById('searchInput').addEventListener('input', function () {
        clearTimeout(timer);
        timer = setTimeout(() => {
            document.getElementById('searchForm').submit();
        }, 2000);
    });

    function simulateAddToCart() {
        let count = parseInt(document.getElementById('cartCount')?.textContent || '0', 10) + 1;
        updateCartCount(count);
    }

    function simulateAddToCollection() {
        let count = parseInt(document.getElementById('collectionCount')?.textContent || '0', 10) + 1;
        updateCollectionCount(count);
    }

        function confirmLogout() {
        Swal.fire({
            title: "Bạn có chắc chắn muốn đăng xuất?",
            text: "Bạn sẽ cần đăng nhập lại để tiếp tục sử dụng dịch vụ!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Đăng xuất",
            cancelButtonText: "Hủy"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "/authenticate?action=logout";
            }
        });
    }

</script>
