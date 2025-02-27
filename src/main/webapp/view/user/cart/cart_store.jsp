<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của tôi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container py-5">
    <div class="text-sm text-gray-600 ">
        <a href="/homeUser" class="hover:underline">Trang chủ</a> / <span>Giỏ hàng của tôi</span>
    </div>

    <c:choose>
        <c:when test="${empty cartDisplayList}">
            <div class="d-flex flex-column align-items-center justify-content-center" style="height: 70vh;">
                <img src="../../../images/cart_emty.png" style="width: 45rem; height: 25rem;" alt="Giỏ hàng trống">
                <p class="text-center text-muted mt-4">Giỏ hàng của bạn đang trống.</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="group" items="${cartDisplayList}">
                <div class="row align-items-center border-bottom py-4" id="store-${group.storeId}">
                    <!-- Logo cửa hàng -->
                    <div class="col-auto">
                        <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${group.storeLogo}"
                             alt="Logo của ${group.storeName}" width="80" height="80" class="rounded-3 shadow-sm">
                    </div>

                    <!-- Thông tin cửa hàng -->
                    <div class="col">
                        <h5 class="fw-bold mb-1">${group.storeName}</h5>
                        <p class="text-danger mb-0">
                            Tổng tiền: <span class="fw-semibold">
                    <fmt:formatNumber value="${group.totalAmount}" pattern="#,###"/>đ
                </span>
                            <span class="text-muted">(${group.totalItems} phần)</span>
                        </p>
                    </div>

                    <!-- Nút đặt hàng -->
                    <div class="col-auto">
                        <button class="btn btn-warning btn-sm">
                            <i class="fa fa-shopping-cart"></i> Đặt hàng
                        </button>
                    </div>

                    <!-- Nút xóa -->
                    <div class="col-auto">
                        <button type="button" class="btn btn-outline-danger btn-sm"
                                onclick="showDeleteModal({ id: ${group.storeId}, url: '/homeUser', action: 'deleteStore' })">
                            <i class="fa fa-trash"></i> Xóa cửa hàng
                        </button>
                    </div>
                </div>
            </c:forEach>

        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="../../admin/system/modalConfirmDelete.jsp" />

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</body>
</html>
