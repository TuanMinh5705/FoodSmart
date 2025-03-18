<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Khiếu Nại</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background: #fff;
        }
        .list-group-item strong {
            color: #090909;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-4 p-4">
    <h2 class="text-center mb-4 text-danger"><i class="bi bi-exclamation-triangle-fill"></i> Gửi Khiếu Nại</h2>
    <form action="/order?action=complaint" method="post">
        <input type="hidden" name="orderId" value="${order.orderId}">
    <div class="row">
        <div class="col-md-6">
            <h5><i class="bi bi-receipt"></i> Thông Tin Đơn Hàng</h5>
            <ul class="list-group">
                <li class="list-group-item">Mã đơn hàng: <strong>${order.orderId}</strong></li>
                <li class="list-group-item">Ngày đặt hàng: <strong>${order.orderDate}</strong></li>
                <li class="list-group-item">Trạng thái: <strong>${order.orderStatus}</strong></li>
                <li class="list-group-item">Phương thức thanh toán:
                    <strong>
                        <c:choose>
                            <c:when test="${order.paymentMethod == 'bank'}">Chuyển khoản ngân hàng</c:when>
                            <c:otherwise>Thanh toán khi nhận hàng</c:otherwise>
                        </c:choose>
                    </strong>
                </li>
                <li class="list-group-item">Phí vận chuyển: <strong><fmt:formatNumber value="25000" pattern="#,###"/> VND</strong></li>
                <li class="list-group-item">Tổng tiền: <strong><fmt:formatNumber value="${total}" pattern="#,###"/> VND</strong></li>
            </ul>
        </div>
        <div class="col-md-6">
            <h5><i class="bi bi-list-ul"></i> Danh Sách Sản Phẩm</h5>
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
    <div class="mb-3">
        <c:choose>
            <c:when test="${not empty complaint.feedback}">
                <div class="mb-3 mt-3">
                    <label for="complaint" class="form-label">
                        <i class="bi bi-pencil-square"></i> Nội dung khiếu nại:
                    </label>
                    <textarea name="complaint" class="form-control" rows="4" readonly>${complaint.complaint_content}</textarea>
                </div>

                <div class="mb-3">
                    <label for="feedback" class="form-label">
                        <i class="bi bi-chat-left-quote-fill"></i> Nội dung phản hồi:
                    </label>
                    <textarea id="feedback" class="form-control" rows="4" readonly>${complaint.feedback}</textarea>
                </div>

                <a href="/order" class="btn btn-secondary w-100">
                    <i class="bi bi-arrow-left"></i> Quay Lại
                </a>
            </c:when>
            <c:otherwise>
                <div class="mb-3 mt-3">
                    <label for="complaint" class="form-label"><i class="bi bi-pencil-square"></i> Nội dung khiếu nại : </label>
                    <textarea id="complaint" name="complaint" class="form-control" rows="4"  placeholder="Nhập nội dung khiếu nại..."></textarea>
                </div>
                <button type="submit" class="btn btn-danger w-100"><i class="bi bi-send"></i> Gửi Khiếu Nại</button>
            </c:otherwise>
        </c:choose>
    </div>
    </form>
</div>
</body>
</html>
