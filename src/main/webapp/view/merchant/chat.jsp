<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <title>Merchant Chat Layout</title>
</head>
<body class="bg-white">
<div class="flex h-screen">
    <!-- Sidebar -->
    <div class="w-1/4 bg-yellow-200 p-4 overflow-auto">
        <!-- Sidebar content -->
        <div class="mb-4">
            <div class="relative flex items-center p-2 bg-white rounded-lg shadow">
                <img alt="User Avatar" class="w-12 h-12 rounded-full" src="https://placehold.co/50x50"/>
                <span class="ml-2">Nguyễn Văn A</span>
                <span class="absolute top-0 right-0 bg-red-500 text-white text-xs rounded-full px-2">2</span>
            </div>
        </div>
        <div class="mb-4">
            <div class="flex items-center p-2 bg-white rounded-lg shadow">
                <img alt="User Avatar" class="w-12 h-12 rounded-full" src="https://placehold.co/50x50"/>
                <span class="ml-2">Trần Thị B</span>
            </div>
        </div>
    </div>

    <div class="w-3/4 flex flex-col h-full">
        <!-- Menubar -->
        <div class="bg-yellow-500 p-4 flex items-center">
            <img alt="User Avatar" class="w-12 h-12 rounded-full" src="https://placehold.co/50x50"/>
            <div class="ml-2">
                <span class="text-white text-lg font-bold">Nguyễn Văn A</span>
                <div class="text-white text-sm">Hỏi về: Bún bò Huế</div>
            </div>
        </div>
        <div class="flex-1 p-4 overflow-auto">
            <div class="flex items-start mb-4">
                <img alt="User Avatar" class="w-12 h-12 rounded-full" src="https://placehold.co/50x50"/>
                <div class="ml-2">
                    <p class="text-lg">Món ăn này có thành phần gì và có khuyến mãi không?</p>
                </div>
            </div>
            <div class="flex items-start mb-4">
                <div class="ml-auto bg-blue-100 p-2 rounded-lg">
                    <p class="text-lg">Chào bạn, món Bún bò Huế có nguyên liệu chính là thịt bò, giò heo và các gia vị đặc trưng. Hiện tại đang giảm 10%!</p>
                </div>
                <img alt="Merchant Avatar" class="w-12 h-12 rounded-full" src="https://placehold.co/50x50"/>
            </div>
        </div>
        <div class="bg-green-200 p-4 flex items-center">
            <input class="flex-grow p-2 rounded-lg border border-gray-300" placeholder="Nhập tin nhắn..." type="text"/>
            <button class="ml-2 text-blue-500">
                <i class="fas fa-paper-plane text-2xl"></i>
            </button>
        </div>
    </div>
</div>
</body>
</html>
