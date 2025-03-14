<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Khiếu Nại</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .container {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background: #fff;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-4 p-4">
    <h2 class="text-center mb-4 text-primary">
        <i class="bi bi-exclamation-circle-fill"></i> Chi Tiết Khiếu Nại
    </h2>

    <div class="row">
        <div class="col-md-6">
            <div class="card mb-3">
                <div class="card-header bg-danger text-white">
                    <i class="bi bi-receipt"></i> Thông Tin Đơn Hàng
                </div>
                <div class="card-body">
                    <p><strong>Mã đơn hàng:</strong> ${order.orderId}</p>
                    <p><strong>Ngày đặt hàng:</strong> ${order.orderDate}</p>
                    <p><strong>Trạng thái:</strong> ${order.orderStatus}</p>
                    <p><strong>Phương thức thanh toán:</strong>
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'bank'}">Chuyển khoản ngân hàng</c:when>
                            <c:otherwise>Thanh toán khi nhận hàng</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${total}" pattern="#,###"/> VND</p>
                    <p><strong>Trạng thái khiếu nại:</strong>
                        <c:choose>
                            <c:when test="${complaint.complaint_status == false}">Chờ xử lý</c:when>
                            <c:otherwise>Đã xử lý</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-header bg-info text-white">
                    <i class="bi bi-person-circle"></i> Thông Tin Khách Hàng
                </div>
                <div class="card-body">
                    <p><strong>Tên khách hàng:</strong> ${customer.username}</p>
                    <p><strong>Số điện thoại:</strong> ${order.shippingInfo.phonenumber}</p>
                    <p><strong>Địa chỉ:</strong> ${order.shippingInfo.address}</p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card mb-3">
                <div class="card-header bg-primary text-white">
                    <i class="bi bi-list-ul"></i> Danh Sách Sản Phẩm
                </div>
                <div class="card-body">
                    <ul class="list-group">
                        <c:forEach var="item" items="${order.cartItems}">
                            <li class="list-group-item">
                                <div><strong>${item.food.product_name}</strong> (x${item.quantity})</div>
                                <div>Thành tiền: <fmt:formatNumber value="${item.priceAtTime * item.quantity}" pattern="#,###"/> VND</div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="card mb-3">
                <div class="card-header bg-warning text-white">
                    <i class="bi bi-pencil-square"></i> Nội Dung Khiếu Nại
                </div>
                <div class="card-body">
                    <p>${complaint.complaint_content}</p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card mb-3">
                <div class="card-header bg-success text-white">
                    <i class="bi bi-chat-left-quote-fill"></i> Phản Hồi Từ Merchant
                </div>
                <div class="card-body">
                    <p>${complaint.feedback}</p>
                </div>
            </div>
        </div>
    </div>

    <div class="text-center">
        <a href="/manageComplaint" class="btn btn-dark">
            <i class="bi bi-arrow-left"></i> Quay Lại
        </a>
    </div>
</div>
</body>
</html>