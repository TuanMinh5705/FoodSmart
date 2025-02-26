<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="container mt-4">
    <a href="#" class="text-decoration-none text-dark mb-3 d-inline-block">
        <i class="fas fa-arrow-left"></i> Chi tiết sản phẩm
    </a>
    <div class="row">
        <div class="col-md-2">
            <div class="d-flex flex-column gap-2">
                <img src="thumb1.jpg" alt="Thumbnail 1" class="img-fluid rounded border">
                <img src="thumb2.jpg" alt="Thumbnail 2" class="img-fluid rounded border">
                <img src="thumb3.jpg" alt="Thumbnail 3" class="img-fluid rounded border">
                <img src="thumb4.jpg" alt="Thumbnail 4" class="img-fluid rounded border">
            </div>
        </div>
        <div class="col-md-5">
            <img src="main.jpg" alt="Bánh mì thập cẩm" class="img-fluid rounded border">
        </div>
        <div class="col-md-5">
            <h1 class="h3">BÁNH MÌ THẬP CẨM</h1>
            <p>Mô tả: bánh mì ngon nguyên liệu làm niên tươi mới,....</p>
            <div class="fs-4 fw-bold">25.000 ₫</div>

            <div class="my-3 d-flex align-items-center">
                <button class="btn btn-outline-secondary">-</button>
                <input type="text" value="1" class="form-control text-center mx-2" style="width: 60px;">
                <button class="btn btn-outline-secondary">+</button>
            </div>

            <div class="d-flex gap-3">
                <button class="btn btn-warning text-dark">
                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                </button>
                <button class="btn btn-outline-dark">
                    <i class="fas fa-bolt"></i> Mua ngay
                </button>
            </div>

            <h2 class="h5 mt-4">Mô tả chi tiết sản phẩm</h2>
            <ul>
                <li>Bánh mì kẹp thập cẩm:</li>
                <li>Thịt nguội (chả lụa, jambon, xúc xích, pate, thịt xá xíu...)</li>
                <li>Trứng chiên hoặc trứng ốp la</li>
                <li>Dưa chua (đồ chua gồm cà rốt, củ cải muối chua ngọt)</li>
                <li>Rau thơm (ngò, húng quế, rau răm...)</li>
                <li>Dưa leo</li>
                <li>Ớt tươi hoặc ớt sa tế</li>
                <li>Sốt mayonnaise, bơ, nước tương, hoặc tương ớt</li>
                <li>Sản phẩm đi kèm: đũa tương ớt, tương cà, gói sốt mayonnaise.</li>
            </ul>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
