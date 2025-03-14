
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <!-- Link Tailwind CSS (nếu chưa có) -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<footer class="bg-yellow-400 pt-6 mt-3">
        <div class="w-full">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 pb-4">
            <!-- Thông tin liên hệ -->
            <div class="pl-6">
                <h4 class="text-2xl font-bold mb-4">Thông tin liên hệ</h4>
                <div class="space-y-6">
                    <!-- Địa chỉ -->
                    <div class="pb-4 border-b border-black text-xl flex items-start">
                        <i class="fas fa-map-marker-alt text-2xl mr-4"></i>
                        <div>
                            <p class="font-semibold">ĐỊA CHỈ:</p>
                            <p>Đại học Thành Đô</p>
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
                    <div class="pb-4 text-xl flex items-start">
                        <i class="fas fa-envelope text-2xl mr-4"></i>
                        <div>
                            <p class="font-semibold">EMAIL:</p>
                            <p>NewEra2025@gmail.com</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hỗ trợ khách hàng & Giấy phép -->
            <div class="flex flex-col md:flex-row md:items-start md:justify-between md:ml-20 gap-6">
                <div class="flex-1">
                    <h4 class="text-2xl font-bold mb-4">Hỗ trợ khách hàng</h4>
                    <div class="space-y-4">
                        <p class="text-xl">Câu hỏi thường gặp?</p>
                        <p class="text-xl">Chính sách khiếu nại</p>
                        <p class="text-xl">Chính sách vận chuyển</p>
                        <p class="text-xl">Chính sách bảo mật</p>
                        <p class="text-xl">Quy định</p>
                    </div>
                    <!-- Mạng xã hội -->
                    <div class="flex space-x-6 mt-6">
<<<<<<< HEAD
                        <div class="flex space-x-6 mt-6">
                            <a href="#" class="transition-colors duration-300 hover:text-blue-700">
                                <i class="fab fa-facebook text-3xl text-blue-600"></i>
                            </a>
                            <a href="#" class="transition-colors duration-300 hover:text-black-700">
                                <i class="fab fa-tiktok text-3xl"></i>
                            </a>
                            <a href="#" class="transition-colors duration-300 hover:text-red-700">
                                <i class="fab fa-youtube text-3xl text-red-600"></i>
                            </a>
                        </div>
=======
                        <i class="fab fa-facebook text-3xl" style="color: #1877F2;"></i>
                        <i class="fab fa-tiktok text-3xl" style="color: #000000;"></i>
                        <i class="fab fa-youtube text-3xl" style="color: #FF0000;"></i>
                        <i class="fab fa-instagram text-3xl" style="color: #E1306C;"></i>
>>>>>>> c7f1aca7096ea03cb08b2b23494a6f0e07289f12
                    </div>

                </div>
                <div class="flex-1 md:ml-8 flex flex-col items-center text-center">
                    <h4 class="text-2xl font-bold mb-4">Giấy phép</h4>
                    <a href="#" class="text-xl block">K15 363/GP-CODEGYM</a>
                    <img src="../../../imageDefault/footer.png" alt="Giấy phép Bộ Công Thương" class="w-52 h-auto mt-4" />
                </div>
            </div>
        </div>
<<<<<<< HEAD
    </div>
    <!-- Phần bản quyền được đưa ra ngoài container để full width -->
    <div class="w-full text-center mt-4 pt-2 bg-blue-500">
        <p class="text-xl text-white">Bản quyền &copy; 2025 SmartFood</p>
=======
        <!-- Phần bản quyền -->
        <div class="text-center mt-4 pt-2 bg-blue-500">
            <p class="text-xl text-white">Bản quyền &copy; 2025 SmartFood</p>
        </div>
>>>>>>> 62c5b813d613f471d16d6db3eb86ea92fa8ad4a3
    </div>
</footer>
</body>
</html>
