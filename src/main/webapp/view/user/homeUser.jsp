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
<!-- Nhúng thư viện SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    function showNotification(message, type) {
        Swal.fire({
            toast: true,
            position: 'top-end',
            icon: type,
            title: message,
            showConfirmButton: false,
            timer: 2500,
            timerProgressBar: true
        });
    }
    <c:if test="${not empty sessionScope.success}">
    showNotification("${sessionScope.success}", "success");
    <c:remove var="success" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.error}">
    showNotification("${sessionScope.error}", "error");
    <c:remove var="error" scope="session"/>
    </c:if>
</script>



<!-- Header -->
<jsp:include page="system/header.jsp"></jsp:include>

<main class="mt-[109px] mb-4">
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
        <c:when test="${param.page == 'addAddressUser'}">
            <jsp:include page="infoAccount/addAddressUser.jsp"/>
        </c:when>
<%--Chi tiết sản phẩm --%>
        <c:when test="${param.page == 'productDetail'}">
            <jsp:include page="product/productDetail.jsp"/>
        </c:when>
        <c:when test="${param.page == 'foodsByCategory'}">
            <jsp:include page="product/foodsByCategory.jsp"/>
        </c:when>
        <c:when test="${param.page == 'collection'}">
            <jsp:include page="product/collection.jsp"/>
        </c:when>
        <c:when test="${param.page == 'showOrder'}">
            <jsp:include page="cart/list_order.jsp"/>
        </c:when>


        <c:when test="${param.page == 'cart_store'}">
            <jsp:include page="cart/cart_store.jsp"/>
        </c:when>
        <c:when test="${param.page == 'showCartProduct'}">
            <jsp:include page="cart/cart_product.jsp"/>
        </c:when>
        <c:when test="${param.page == 'showStore'}">
            <jsp:include page="product/store.jsp"/>
        </c:when>
        <c:when test="${param.page == 'orderProduct'}">
            <jsp:include page="cart/order.jsp"/>
        </c:when>
        <c:when test="${param.page == 'showOrderDetail'}">
            <jsp:include page="cart/orderDetail.jsp"/>
        </c:when>
<%--     Mã giảm giá   --%>
        <c:when test="${param.page == 'displayVouchers'}">
            <jsp:include page="voucher/infoVoucher.jsp"/>
        </c:when>

        <c:when test="${param.page == 'chat'}">
            <jsp:include page="chat.jsp"/>
        </c:when>
        <c:when test="${param.page == 'showComplaint'}">
            <jsp:include page="complaint.jsp"/>
        </c:when>
        <c:when test="${param.page == 'notification'}">
            <jsp:include page="../notification.jsp"/>
        </c:when>



        <c:otherwise>
            <jsp:include page="system/menu.jsp" />
            <!-- Banner -->
            <div class="relative mt-1">
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
                        <p class="p-2 rounded">Bạn muốn đăng ký mua bán hàng trên SmartFood?</p>
                        <a href="/authenticate?action=showFormRegisterStore"><button class="bg-blue-500 text-white p-2 rounded">Đăng ký ngay</button></a>
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
