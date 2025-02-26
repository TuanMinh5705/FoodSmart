<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Food</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>

<body class="font-sans">
<!-- Header -->
<header class="bg-yellow-400 p-4 flex items-center">
    <!-- Left: Logo & Navigation -->
    <div class="flex items-center space-x-4">
        <img src="../../images/logo.png" alt="Smart Food Logo" class="h-[80px]">
        <nav class="space-x-4">
            <a href="#" class="text-black font-bold text-xl py-2 px-4">Trang chủ</a>
            <a href="#" class="text-black font-bold text-xl py-2 px-4">Khuyến mãi</a>
        </nav>
    </div>

    <div class="flex-1 mx-4 flex justify-center relative">
        <input type="text" placeholder="Tìm kiếm..." class="w-1/2 p-2 pl-10 rounded">
        <i class="fas fa-search absolute left-[26%] top-1/2 transform -translate-y-1/2 text-gray-500"></i>
    </div>



    <!-- Right: Account & Icons -->
    <div class="flex items-center space-x-4">
        <i class="fas fa-shopping-cart text-black text-2xl" title="Giỏ hàng"></i>
        <div class="w-[2px] h-8 bg-black"></div>

        <i class="fas fa-heart text-black text-2xl" title="Bộ sưu tập"></i>
        <div class="w-[2px] h-8 bg-black"></div>

        <i class="fas fa-bell text-black text-2xl" title="Thông báo"></i>
        <div class="w-[2px] h-8 bg-black"></div>

        <i class="fas fa-user text-black text-2xl" title="Tài khoản"></i>
    </div>



</header>

<!-- Categories -->
<div class="bg-white p-6 flex justify-around items-center">
    <div class="text-center space-y-2">
        <img src="https://placehold.co/80x80" alt="Bánh mì" class="mx-auto">
        <p class="text-xl font-semibold">Bánh mì</p>
    </div>
    <div class="text-center space-y-2">
        <img src="https://placehold.co/80x80" alt="Đồ tráng miệng" class="mx-auto">
        <p class="text-xl font-semibold">Đồ tráng miệng</p>
    </div>
    <div class="text-center space-y-2">
        <img src="https://placehold.co/80x80" alt="Cơm" class="mx-auto">
        <p class="text-xl font-semibold">Cơm</p>
    </div>
    <div class="text-center space-y-2">
        <img src="https://placehold.co/80x80" alt="Đồ uống" class="mx-auto">
        <p class="text-xl font-semibold">Đồ uống</p>
    </div>
    <div class="text-center space-y-2">
        <img src="https://placehold.co/80x80" alt="Mì" class="mx-auto">
        <p class="text-xl font-semibold">Mì</p>
    </div>
    <div class="text-center space-y-2">
        <img src="https://placehold.co/80x80" alt="Đồ ăn nhanh" class="mx-auto">
        <p class="text-xl font-semibold">Đồ ăn nhanh</p>
    </div>
</div>


<!-- Banner -->
<div class="relative">
    <img src="https://nhathauxaydung24h.com/wp-content/uploads/2021/05/hinh-nen-powerpoint-am-thuc-3.jpg" alt="Banner Image" class="w-full h-[650px] object-cover">
    <div class="absolute inset-0 bg-black bg-opacity-50 flex flex-col justify-center items-center text-white text-center">
        <h1 class="text-3xl font-bold">CHÀO MỪNG ĐẾN VỚI THẾ GIỚI ẨM THỰC SMART FOOD!</h1>
        <p class="text-xl">KHÁM PHÁ CÁC MÓN ĂN & ĐẶC SẢN NƠI HƯƠNG VỊ BAY XA</p>
        <ul class="mt-4 space-y-2">
            <li>MIỄN PHÍ TƯ VẤN VÀ HỖ TRỢ</li>
            <li>ĐẠT CHUẨN TIÊU CHÍ CỦA ĐỒ ĂN SẠCH</li>
            <li>DỊCH VỤ GIAO HÀNG TẬN NƠI</li>
        </ul>
        <div class="mt-4 flex space-x-4">
            <p class="bg-gray-800 p-2 rounded">Bạn muốn đăng ký bán hàng trên SmartFood ?</p>
            <button class="bg-blue-500 text-white p-2 rounded">Đăng ký ngay</button>
        </div>
    </div>
</div>

<!-- Featured Products -->
<div class="p-4">
    <h3 class="text-2xl font-bold mt-4">SẢN PHẨM NỔI BẬT</h3>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mt-4">
        <div class="bg-white p-4 rounded shadow">
            <img src="https://placehold.co/200x150" alt="Bánh mì kẹp thập cẩm" class="w-full rounded">
            <h4 class="text-lg font-bold mt-2">Bánh mì kẹp thập cẩm</h4>
            <p class="text-red-500 font-bold">25.000 ₫ <span class="line-through text-gray-500">40.000 ₫</span></p>
            <p class="text-red-500">Flash sale <span class="text-gray-500">09:30:00</span></p>
            <p class="text-yellow-500"><i class="fas fa-star"></i> 4.5 | Đã bán 9999</p>
        </div>
    </div>
</div>

<footer class="bg-yellow-400 pt-6">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 border-black pb-4">
        <!-- Thông tin liên hệ -->
        <div class="relative pl-6">
            <h4 class="text-2xl font-bold mb-4">Thông tin liên hệ</h4>
            <div class="space-y-6">
                <!-- Địa chỉ -->
                <div class="pb-4 border-b border-black text-xl flex items-start">
                    <i class="fas fa-map-marker-alt text-2xl mr-4"></i>
                    <div>
                        <p class="font-semibold">ĐỊA CHỈ:</p>
                        <p>Đại học thành đô</p>
                    </div>
                </div>

                <!-- Điện thoại -->
                <div class="pb-4 border-b border-black text-xl flex items-start">
                    <i class="fas fa-phone text-2xl mr-4"></i>
                    <div>
                        <p class="font-semibold">ĐIỆN THOẠI:</p>
                        <p>(+84)123456789</p>
                    </div>
                </div>

                <!-- Email -->
                <div class="pb-4 border-b border-black text-xl flex items-start">
                    <i class="fas fa-envelope text-2xl mr-4"></i>
                    <div>
                        <p class="font-semibold">EMAIL:</p>
                        <p>NewEra2025@gmail.com</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hỗ trợ khách hàng -->
        <div class="md:ml-[80px] flex justify-between items-start">
            <div>
                <h4 class="text-2xl font-bold mb-4">Hỗ trợ khách hàng</h4>
                <div class="space-y-6">
                    <p class="text-xl">Câu hỏi thường gặp ?</p>
                    <p class="text-xl">Chính sách khiếu nại</p>
                    <p class="text-xl">Chính sách vận chuyển</p>
                    <p class="text-xl">Chính sách bảo mật</p>
                    <p class="text-xl">Quy định</p>
                </div>

                <!-- Mạng xã hội -->
                <div class="flex space-x-6 mt-6">
                    <i class="fab fa-facebook text-3xl"></i>
                    <i class="fab fa-tiktok text-3xl"></i>
                    <i class="fab fa-youtube text-3xl"></i>
                </div>
            </div>

            <div class="ml-0 mr-12">
                <p class="text-2xl font-bold mb-4">Giấy phép</p>
                <a href="#" class="text-xl">K15 363/GP-CODEGYM</a>
                <img src="../../images/footer.png" alt="Giấy phép Bộ Công Thương" class="w-[13rem] h-auto mt-4 mr-[5px]" />
            </div>
        </div>
    </div>

    <!-- Phần bản quyền -->
    <div class="text-center mt-4 border-t-4 border-black pt-2 pd-2 bg-blue-500">
        <p class="text-xl text-white">Bản quyền &copy; 2025 SmartFood</p>
    </div>
</footer>






</body>

</html>
