<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Mã Giảm Giá</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h2>Mã giảm giá của sàn</h2>
<div class="voucher-container">
    <c:forEach var="voucher" items="${voucherList}">
        <div class="voucher-item">
            <h3>Giảm ${voucher.discount_value}%</h3>
            <p>${voucher.description}</p>

        </div>
    </c:forEach>
</div>

<h2>Voucher của cửa hàng</h2>
<div class="coupon-container">
    <c:forEach var="coupon" items="${couponList}">
        <div class="coupon-item">
            <h3>Giảm ${coupon.discount_value}%</h3>
            <p>${coupon.description}</p>

        </div>
    </c:forEach>
</div>
</body>
</html>
