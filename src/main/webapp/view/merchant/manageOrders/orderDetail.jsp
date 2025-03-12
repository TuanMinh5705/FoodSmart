<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết đơn hàng</title>
    <!-- Sử dụng Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .order-header {
            background: #ffffff;
            border: 1px solid #e1e1e1;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: .25rem;
        }
        .order-header h4 {
            margin: 0;
            font-weight: 600;
        }
        .order-header small {
            color: #666;
        }
        .table img {
            width: 70px;
            height: auto;
            object-fit: contain;
        }
        .summary-list .d-flex {
            justify-content: space-between;
            margin-bottom: .5rem;
        }
        .summary-list .total {
            font-weight: 700;
            font-size: 1.1rem;
        }
        .info-box {
            background: #ffffff;
            border: 1px solid #e1e1e1;
            padding: 1rem;
            border-radius: .25rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<div class="container my-4">

    <div class="order-header">
        <div class="row">
            <div class="col-md-8">
                <h4>Đơn hàng #${order.orderId}</h4>
                 Ngày đặt:
                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                    <br>
                    <c:if test="${not empty order.shippingDate}">
                         Ngày giao hàng:
                            <fmt:formatDate value="${order.shippingDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                         
                        <br>
                    </c:if>
                    <c:if test="${not empty order.deliveryDate}">
                         Ngày nhận hàng:
                            <fmt:formatDate value="${order.deliveryDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                         
                        <br>
                    </c:if>
                 
                <br/>
                 Trạng thái đơn hàng: <strong>${order.orderStatus}</strong> 
            </div>
            <div class="col-md-4 text-md-end">
                <p class="mb-1">
                    <strong>Phương thức thanh toán:</strong>
                    <c:choose>
                        <c:when test="${order.paymentMethod eq 'cod'}">
                            Thanh toán khi nhận hàng
                        </c:when>
                        <c:when test="${order.paymentMethod eq 'bank'}">
                            Chuyển khoản ngân hàng
                        </c:when>
                        <c:otherwise>
                            ${order.paymentMethod}
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="mb-1">
                    <strong>Trạng thái thanh toán: </strong>
                    <c:choose>
                        <c:when test="${order.paymentStatus}">
                            <span class="text-success">Đã thanh toán</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger">Chưa thanh toán</span>
                        </c:otherwise>
                    </c:choose>
                </p>

                <c:if test="${order.voucherId != 0}">
                    <p class="mb-1">
                        <strong>Mã voucher:</strong> ${order.voucherId}
                    </p>
                </c:if>
                <c:if test="${order.couponId != 0}">
                    <p class="mb-0">
                        <strong>Mã coupon:</strong> ${order.couponId}
                    </p>
                </c:if>
            </div>
        </div>
    </div>

    <c:set var="totalOfItems" value="0" scope="page" />
    <c:forEach var="item" items="${order.cartItems}" varStatus="status">
        <c:set var="itemTotal" value="${item.priceAtTime * item.quantity}" />
        <c:set var="totalOfItems" value="${totalOfItems + itemTotal}" />
    </c:forEach>
    <c:set var="shippingFee" value="25000" scope="page"/>
    <c:set var="discount" value="0" scope="page"/>
    <c:set var="finalTotal" value="${totalOfItems + shippingFee - discount}" scope="page"/>

    <div class="row">
        <!-- Cột trái: Danh sách sản phẩm -->
        <div class="col-lg-8 mb-4">
            <div class="info-box">
                <h5 class="mb-3">Danh sách sản phẩm</h5>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>STT</th>
                            <th>Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${order.cartItems}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <c:forEach var="img" items="${item.food.list_food_images}">
                                        <c:if test="${img.is_primary}">
                                            <img src="${pageContext.request.contextPath}/images/product/${img.image_path}"
                                                 alt="${item.food.product_name}">
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${item.food.product_name}</td>
                                <td>
                                    <fmt:formatNumber value="${item.priceAtTime}" pattern="#,###" /> đ
                                </td>
                                <td>${item.quantity}</td>
                                <td>
                                    <fmt:formatNumber value="${item.priceAtTime * item.quantity}" pattern="#,###" /> đ
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Cột phải: Tóm tắt thanh toán -->
        <div class="col-lg-4 mb-4">
            <div class="info-box">
                <h5 class="mb-3">Tóm tắt thanh toán</h5>
                <div class="summary-list">
                    <!-- Tổng tạm tính -->
                    <div class="d-flex">
                        <span>Tổng tạm tính:</span>
                        <span>
                            <fmt:formatNumber value="${totalOfItems}" pattern="#,###" /> đ
                        </span>
                    </div>
                    <!-- Phí vận chuyển -->
                    <div class="d-flex">
                        <span>Phí vận chuyển:</span>
                        <span>
                            <fmt:formatNumber value="${shippingFee}" pattern="#,###" /> đ
                        </span>
                    </div>
                    <!-- Giảm giá -->
                    <c:if test="${discount > 0}">
                        <div class="d-flex">
                            <span>Giảm giá:</span>
                            <span>
                                - <fmt:formatNumber value="${discount}" pattern="#,###" /> đ
                            </span>
                        </div>
                    </c:if>
                    <hr/>
                    <!-- Tổng cộng -->
                    <div class="d-flex total">
                        <span>Tổng thanh toán:</span>
                        <span>
                            <fmt:formatNumber value="${finalTotal}" pattern="#,###" /> đ
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6 mb-4">
            <div class="info-box">
                <h5>Thông tin người nhận</h5>
                <p class="mb-0"><strong>Người đặt hàng:</strong> ${order.username}</p>
                <p class="mb-1"><strong>Số điện thoại:</strong> ${order.shippingInfo.phonenumber}</p>
                <p class="mb-1"><strong>Địa chỉ:</strong> ${order.shippingInfo.address}</p>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="info-box">
                <h5>Thông tin vận chuyển</h5>
                <p class="mb-1"><strong>Đối tác vận chuyển:</strong> ${order.shipper.carrier_name}</p>
                <p class="mb-1"><strong>Nhân viên vận chuyển:</strong> ${order.shipper.shipper_name}</p>
                <p class="mb-0"><strong>Số điện thoại:</strong> ${order.shipper.phonenumber}</p>
            </div>
        </div>
    </div>

</div>

<!-- Script Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
