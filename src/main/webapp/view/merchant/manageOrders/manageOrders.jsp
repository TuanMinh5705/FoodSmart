
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
<h1>Quản lý đơn hàng</h1>
<table>
    <thead>
    <tr>
        <th>Mã đơn hàng</th>
        <th>Mã người dùng</th>
        <th>Mã cửa hàng</th>
        <th>Trạng thái đơn hàng</th>
        <th>Ngày đặt hàng</th>
        <th>Phương thức thanh toán</th>
        <th>Trạng thái thanh toán</th>
        <th>Ngày giao hàng</th>
        <th>Ngày nhận hàng</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
        <c:when test="${not empty orderList}">
            <c:forEach var="order" items="${orderList}">
                <tr>
                    <td>${order.orderId}</td>
                    <td>${order.userId}</td>
                    <td>${order.storeId}</td>
                    <td>${order.orderStatus}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.paymentMethod}</td>
                    <td>${order.paymentStatus}</td>
                    <td>${order.shippingDate}</td>
                    <td>${order.deliveryDate}</td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="9">Không có đơn hàng nào</td>
            </tr>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>
</body>
</html>
