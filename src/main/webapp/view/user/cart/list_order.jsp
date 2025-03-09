<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đơn hàng của bạn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
<div class="container mt-4">
    <h1 class="mb-3">Đơn hàng của bạn</h1>

    <c:set var="selectedStatus" value="${param.status}" />

    <div class="btn-group mb-3">
        <a href="?status=all" class="btn ${empty selectedStatus || selectedStatus == 'all' ? 'btn-success' : 'btn-outline-success'}">Tất cả</a>
        <a href="?status=pending" class="btn ${selectedStatus == 'pending' ? 'btn-success' : 'btn-outline-secondary'}">Chờ xác nhận</a>
        <a href="?status=shipping" class="btn ${selectedStatus == 'shipping' ? 'btn-success' : 'btn-outline-secondary'}">Đang giao</a>
        <a href="?status=completed" class="btn ${selectedStatus == 'completed' ? 'btn-success' : 'btn-outline-secondary'}">Đã hoàn thành</a>
        <a href="?status=canceled" class="btn ${selectedStatus == 'canceled' ? 'btn-success' : 'btn-outline-secondary'}">Đã hủy</a>
    </div>

    <c:forEach var="order" items="${orders}">
        <c:if test="${empty selectedStatus || selectedStatus == 'all' || order.orderStatus == selectedStatus}">
            <c:set var="totalPrice" value="0" />

            <c:forEach var="item" items="${order.cartItems}">
                <c:set var="totalPrice" value="${totalPrice + (item.priceAtTime * item.quantity)}" />
            </c:forEach>

            <c:set var="shippingFee" value="25000" />
            <c:set var="totalPrice" value="${totalPrice + shippingFee}" />

            <div class="card mb-3 shadow-sm">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="text-muted">
                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy, HH:mm:ss"/>
                        </span>
                        <span class="badge bg-${order.orderStatus == 'shipping' ? 'info' : (order.orderStatus == 'completed' ? 'success' : (order.orderStatus == 'canceled' ? 'danger' : 'secondary'))}">
                            <c:choose>
                                <c:when test="${order.orderStatus == 'pending'}">Chờ xác nhận</c:when>
                                <c:when test="${order.orderStatus == 'shipping'}">Đang Giao</c:when>
                                <c:when test="${order.orderStatus == 'completed'}">Hoàn Thành</c:when>
                                <c:when test="${order.orderStatus == 'canceled'}">Đã Hủy</c:when>
                                <c:otherwise>Không Xác Định</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="d-flex align-items-center mt-3">
                        <img src="${pageContext.request.contextPath}/images/avatars/${merchantMap[order.orderId].avt_path}"
                             alt="Store Icon" class="me-3 rounded-circle" width="60" height="60">
                        <div>
                            <h5 class="card-title mb-1">${merchantMap[order.orderId].store_name}</h5>
                            <p class="text-muted mb-1">
                                    ${fn:length(order.cartItems)} phần - <strong><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/> đ</strong>
                            </p>
                            <a href="/order?action=showOrderDetail&id=${order.orderId}" class="text-primary">Xem chi tiết đơn hàng</a>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end mt-3">
                        <c:if test="${order.orderStatus == 'shipping'}">
                            <button class="btn btn-primary me-2">Theo dõi</button>
                        </c:if>
                        <c:if test="${order.orderStatus == 'completed'}">
                            <button class="btn btn-success">Đặt lại</button>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
</div>
</body>
</html>
