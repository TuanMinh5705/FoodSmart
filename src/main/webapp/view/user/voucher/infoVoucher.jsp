<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Mã Giảm Giá</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
        }
        .container {
            width: 90%;
            margin: auto;
        }
        h2 {
            margin-top: 20px;
            font-size: 24px;
        }
        .voucher-section {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
            border-radius: 15px;
            margin: 20px auto;
            max-width: 800px;
        }
        .discount {
            background: linear-gradient(135deg, #A0D9FF, #E2A3FF);
        }
        .exclusive {
            background: linear-gradient(135deg, #FFAE67, #E25E3E);
        }
        .voucher-card {
            background: #ffffff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.2);
            margin: 10px;
            width: 180px;
            text-align: center;
        }
        .btn-claim {
            background-color: #90CAF9;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .exclusive-card {
            background: #FFE5C2;
        }
        .exclusive-btn {
            background-color: #FF6F61;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Mã giảm giá</h2>
    <div class="voucher-section discount">
        <c:forEach var="voucher" items="${voucherList}">
            <div class="voucher-card">
                <h3>Giảm ${voucher.discount_value}%</h3>
                <p>${voucher.description}</p>
            </div>
        </c:forEach>
    </div>

    <h2>Mã giảm giá của cửa hàng</h2>
    <div class="voucher-section exclusive">
        <c:forEach var="coupon" items="${couponList}">
            <div class="voucher-card exclusive-card">
                <h3> ${coupon.store_name}</h3>
                <h3>Giảm ${coupon.discount_value}%</h3>
                <p>${coupon.description}</p>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
