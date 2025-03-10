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
                <p class="text-center text-muted fs-3">Giỏ hàng của bạn đang trống.</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="group" items="${cartDisplayList}">
                <div class="row align-items-center border-bottom py-4" id="store-${group.storeId}">
                    <!-- Logo cửa hàng -->
                    <div class="col-auto">
                        <img src="${pageContext.request.contextPath}/images/avatars/${group.storeLogo}"
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
                        <a href="/homeUser?action=showCartProduct&storeId=${group.storeId}">
                            <button class="btn btn-warning btn-sm">
                                <i class="fa fa-shopping-cart"></i> Đặt hàng
                            </button>
                        </a>
                    </div>

                    <!-- Nút xóa -->
                    <div class="col-auto">
                        <button type="button" class="btn btn-outline-danger btn-sm"
                                onclick="showDeleteModal({ id: ${group.storeId}, url: '/homeUser', action: 'deleteStore' })">
                            <i class="fa fa-trash"></i> Xóa cửa hàng
                        </button>
                    </div>
                </div>

                <!-- Danh sách sản phẩm của cửa hàng -->
                <div class="mb-5">
                    <div class="list-group">
                        <c:forEach var="item" items="${group.items}">
                            <div class="list-group-item product-item">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <img src="${pageContext.request.contextPath}/images/product/${item.productImage}" alt="${item.productName}" class="img-fluid img-thumbnail" style="width: 100px; height: 100px;">
                                    </div>
                                    <div class="col-md-4">
                                        <h6 class="mb-1">${item.productName}</h6>
                                        <p class="mb-0 text-muted">
                                            Giá: <fmt:formatNumber pattern="#,###" value="${item.priceAtTime}"/> đ
                                        </p>
                                    </div>
                                    <div class="col-md-3 text-center">
                                        Số lượng: ${item.quantity}
                                    </div>
                                    <div class="col-md-3 text-center">
                                        <p class="mb-0 fw-bold">
                                            <fmt:formatNumber pattern="#,###" value="${item.priceAtTime * item.quantity}"/> đ
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="../../admin/system/modalConfirmDelete.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</body>
</html>
