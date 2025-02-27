<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<jsp:include page="system/header.jsp"></jsp:include>

<main class="mt-[125px] mb-4">
    <c:choose>
<%--        Thông tin tài khoản--%>
        <c:when test="${param.page == 'infoUser'}">
            <jsp:include page="infoAccount/infoUser.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editUser'}">
            <jsp:include page="infoAccount/editInfoUser.jsp"/>
        </c:when>
        <c:when test="${param.page == 'addressUser'}">
            <jsp:include page="infoAccount/addressUser.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editAddressUser'}">
            <jsp:include page="infoAccount/editAddressUser.jsp"/>
        </c:when>
<%--Chi tiết sản phẩm --%>
        <c:when test="${param.page == 'productDetail'}">
            <jsp:include page="product/productDetail.jsp"/>
        </c:when>
        <c:when test="${param.page == 'foodsByCategory'}">
            <jsp:include page="product/foodsByCategory.jsp"/>
        </c:when>


        <c:when test="${param.page == 'cart_store'}">
            <jsp:include page="cart/cart_store.jsp"/>
        </c:when>

        <c:otherwise>
            <jsp:include page="system/menu.jsp"></jsp:include>
            <!-- Banner -->
            <div class="relative mt-8">
                <img src="https://nhathauxaydung24h.com/wp-content/uploads/2021/05/hinh-nen-powerpoint-am-thuc-3.jpg"
                     alt="Banner Image"
                     class="w-full h-[650px] object-cover">
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
            <jsp:include page="system/content.jsp"></jsp:include>
        </c:otherwise>
    </c:choose>
</main>

<!-- Footer -->
<jsp:include page="system/footer.jsp"></jsp:include>
</body>
</html>
