<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Chi Tiết Đơn Hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/homeUser" class="text-decoration-none">
                    <i class="fas fa-home me-1"></i>Trang chủ
                </a>
            </li>
            <li class="breadcrumb-item active" aria-current="page">Chi tiết đơn hàng</li>
        </ol>
    </nav>

    <!-- Thông tin đơn hàng -->
    <div class="card mb-4">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-secondary">
                    Mã đơn hàng: #<c:out value="${order.orderId}"/>
                </span>
                <!-- Badge trạng thái -->
                <span class="badge bg-primary">
                    <c:out value="${order.orderStatus}"/>
                </span>
            </div>
            <div class="text-muted">
                <p>
                    <i class="fas fa-calendar-day me-1"></i>
                    Ngày đặt: <c:out value="${order.orderDate}"/>
                </p>
                <p>
                    <i class="fas fa-money-bill-wave me-1"></i>
                    Phương thức thanh toán: <c:out value="${order.paymentMethod}"/>
                </p>
                <p>
                    <i class="fas fa-credit-card me-1"></i>
                    Trạng thái thanh toán: <c:out value="${order.paymentStatus}"/>
                </p>
            </div>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="fas fa-shopping-basket me-2"></i>Danh sách sản phẩm
            </h5>
            <c:forEach var="item" items="${foodList}">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <div class="d-flex align-items-center">
                        <!-- Ảnh sản phẩm -->
                        <img src="${pageContext.request.contextPath}/foodSmartImages/product/${item.avt_path}"
                             alt="Sản phẩm"
                             class="rounded me-3"
                             style="width: 50px; height: 50px; object-fit: cover;" />
                        <div>
                            <!-- Tên sản phẩm -->
                            <p class="fw-semibold mb-1">
                                <c:out value="${item.produc_name}"/>
                            </p>
                            <!-- Số lượng -->
                            <small class="text-muted">
                                Số lượng:
                                <fmt:formatNumber value="${item.quantity}" pattern="#,###"/>
                            </small>
                        </div>
                    </div>
                    <!-- Giá = priceAtTime * quantity -->
                    <p class="fw-bold mb-0 text-danger">
                        <fmt:formatNumber value="${item.priceAtTime * item.quantity}" pattern="#,###"/> đ
                    </p>
                </div>
                <c:set var="subTotal" value="${item.priceAtTime * item.quantity}" />
                <c:set var="shippingFee" value="25000" />
                <c:set var="discount" value="0" />
            </c:forEach>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="fas fa-file-invoice-dollar me-2"></i>Tổng đơn hàng
            </h5>

            <div class="d-flex justify-content-between text-muted mb-2">
                <span>Tổng phụ:</span>
                <span>
                    <fmt:formatNumber value="${subTotal}" pattern="#,###"/> đ
                </span>
            </div>
            <div class="d-flex justify-content-between text-muted mb-2">
                <span>Phí vận chuyển:</span>
                <span>
                    <fmt:formatNumber value="${shippingFee}" pattern="#,###"/> đ
                </span>
            </div>
            <div class="d-flex justify-content-between text-muted mb-2">
                <span>Mã giảm giá:</span>
                <span>
                    <fmt:formatNumber value="${discount}" pattern="#,###"/> đ
                </span>
            </div>
            <hr/>
            <div class="d-flex justify-content-between fw-bold">
                <span>Tổng cộng:</span>
                <span>
                    <fmt:formatNumber value="${subTotal + shippingFee - discount}" pattern="#,###"/> đ
                </span>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
