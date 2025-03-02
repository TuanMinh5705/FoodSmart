<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 28/02/2025
  Time: 11:20 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>
        Order Page
    </title>
    <script src="https://cdn.tailwindcss.com">
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
</head>
<body class="bg-gray-100">
<div class="max-w-4xl mx-auto p-4">
    <div class="flex items-center mb-4">
        <i class="fas fa-home text-xl">
        </i>
        <span class="ml-2 text-lg">
     Đơn hàng
    </span>
    </div>
    <div class="flex space-x-4 mb-4">
        <button class="px-4 py-2 bg-gray-200 rounded">
            Tất cả
        </button>
        <button class="px-4 py-2 bg-gray-200 rounded">
            Chờ xác nhận
        </button>
        <button class="px-4 py-2 bg-green-200 rounded">
            Đang vận chuyển
        </button>
        <button class="px-4 py-2 bg-green-200 rounded">
            Đã giao
        </button>
        <button class="px-4 py-2 bg-gray-200 rounded">
            Đã huỷ
        </button>
    </div>
    <div class="space-y-4">
        <div class="bg-white p-4 rounded-lg shadow-md">
            <div class="flex justify-between items-center mb-2">
      <span class="text-sm text-gray-500">
       07/12/2025, 12:25:00
      </span>
                <span class="px-2 py-1 bg-green-200 text-green-800 rounded">
       Giao thành công
      </span>
            </div>
            <div class="flex items-center mb-2">
                <img alt="Store icon" class="w-12 h-12 mr-4" height="50"
                     src="https://storage.googleapis.com/a1aa/image/kRzJYYWTAenidOGAONqsm6aBCB--dA5VVPXgCfKICUk.jpg"
                     width="50"/>
                <div>
                    <div class="text-lg font-semibold">
                        Bún Chả Và Cơm Tấm Hải Việt
                    </div>
                    <div class="text-sm text-gray-500">
                        6 phần - 672000 đ
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

