<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 27/02/2025
  Time: 10:38 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của tôi</title>
    <!-- Link Bootstrap CSS (CDN) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<!-- PHẦN NỘI DUNG GIỎ HÀNG (không có menu, không có footer) -->
<div class="container py-5">
    <div class="text-sm text-gray-600 mt-4 ml-4">
        <a href="/homeUser" class="hover:underline">Trang chủ</a> /
            <span>Giỏ hàng của tôi</span>
    </div>

    <!-- Sản phẩm 1 -->
    <div class="row align-items-center border-bottom py-3">
        <!-- Ảnh placeholder 80x80 -->
        <div class="col-auto">
            <img src="https://via.placeholder.com/80" alt="Placeholder Sản phẩm" width="80" height="80">
        </div>
        <!-- Thông tin sản phẩm -->
        <div class="col">
            <div class="fw-semibold">Cơm tấm Đại chỉ + Sườn Bì Chả</div>
            <div class="text-danger">120.000đ (3 phần)</div>
        </div>
        <!-- Nút Đặt hàng -->
        <div class="col-auto">
            <button class="btn btn-warning btn-hover-dark">
                <i class="fa fa-shopping-cart"></i> Đặt hàng
            </button>

        </div>
        <!-- Nút Xoá (icon thùng rác) -->
        <div class="col-auto">
            <button class="btn btn-link text-decoration-none p-0 text-danger">
                <i class="fa fa-trash"></i> Xóa
            </button>
        </div>
    </div>

</div>


<!-- Bootstrap JS (CDN) -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</body>
</html>
