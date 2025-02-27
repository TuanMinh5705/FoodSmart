<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .remove-btn {
            color: white;
            background-color: #e74c3c;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
        button {
            cursor: pointer;
        }
        .cart-summary {
            margin-top: 20px;
            text-align: right;
        }
        .cart-summary p {
            margin: 5px 0;
        }
        .checkout-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            text-align: center;
            font-size: 16px;
        }
    </style>
</head>
<body>
<h1>🛒 Giỏ hàng của bạn</h1>
<table>
    <thead>
    <tr>
        <th>Tên sản phẩm</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Thành tiền</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${storeData.items}" varStatus="status">
        <tr>
            <td>${item.productName}</td>
            <td>${item.priceAtTime} đ</td>
            <td>
                <button id="decrease_${item.productId}">-</button>
                <input id="quantity_${item.productId}" type="number" value="${item.quantity}" min="1" style="width: 50px; text-align: center;">
                <button id="increase_${item.productId}">+</button>
            </td>
            <td id="total-${status.index}">${item.priceAtTime * item.quantity} đ</td>
            <td>
                <button class="remove-btn" onclick="removeItem('${item.productId}')">Xóa</button>
            </td>
        </tr>
        <script>
            (function () {
                const quantityInput = document.getElementById('quantity_${item.productId}');
                const increaseBtn = document.getElementById('increase_${item.productId}');
                const decreaseBtn = document.getElementById('decrease_${item.productId}');
                const totalCell = document.getElementById('total-${status.index}');
                const priceAtTime = ${item.priceAtTime};

                const updateTotal = () => {
                    const quantity = parseInt(quantityInput.value) || 1;
                    totalCell.textContent = (priceAtTime * quantity).toLocaleString('vi-VN') + ' đ';
                    updateOrderTotal();
                };

                increaseBtn.addEventListener('click', () => {
                    quantityInput.value = parseInt(quantityInput.value) + 1;
                    updateTotal();
                });

                decreaseBtn.addEventListener('click', () => {
                    if (parseInt(quantityInput.value) > 1) {
                        quantityInput.value = parseInt(quantityInput.value) - 1;
                        updateTotal();
                    }
                });

                quantityInput.addEventListener('input', updateTotal);
            })();
        </script>
    </c:forEach>
    </tbody>
</table>

<div class="cart-summary">
    <h2>Tổng đơn hàng</h2>
    <p>Tổng phụ: <span id="subtotal">0 đ</span></p>
    <p>Phí vận chuyển: <span id="shipping">25.000 đ</span></p>
    <p>Giảm giá: <span id="discount">10.000 đ</span></p>
    <p><strong>Tổng cộng: <span id="total">0 đ</span></strong></p>
</div>

<button class="checkout-btn" onclick="checkout()">Thanh toán</button>

<script>
    function updateOrderTotal() {
        let subtotal = 0;
        document.querySelectorAll("[id^='total-']").forEach(cell => {
            subtotal += parseInt(cell.textContent.replace(/[^0-9]/g, "")) || 0;
        });

        document.getElementById("subtotal").textContent = subtotal.toLocaleString('vi-VN') + " đ";

        const shippingFee = 25000;
        const discount = 10000;
        const total = subtotal + shippingFee - discount;

        document.getElementById("total").textContent = total.toLocaleString('vi-VN') + " đ";
    }

    function removeItem(productId) {
        alert("Xóa sản phẩm: " + productId);
        // Thêm logic gửi yêu cầu xóa item từ giỏ hàng về server
    }

    function checkout() {
        alert("Tiến hành thanh toán!");
        // Thêm logic xử lý thanh toán ở đây
    }

    window.onload = updateOrderTotal;
</script>

</body>
</html>