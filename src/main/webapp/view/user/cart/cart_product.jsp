<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Giỏ hàng - Store</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet"/>
</head>
<body class="bg-gray-100">
<div class="text-sm text-gray-600 ">
    <a href="/homeUser" class="hover:underline">Trang chủ</a> /
    <a href="/homeUser?action=showCartStore" class="hover:underline">Giỏ hàng</a> /<span>Đặt hàng</span>
</div>
<div class="max-w-6xl mx-auto p-4">
    <c:if test="${not empty storeData}">
        <form action="/homeUser?action=orderProduct&storeId=${storeData.storeId}" method="post">
        <div class="flex items-center justify-between mb-6 bg-white p-4 rounded shadow">
            <div class="flex items-center">
                <img alt="Restaurant logo"
                     class="mr-3 w-12 h-12 object-contain rounded-full border border-gray-300"
                     src="${pageContext.request.contextPath}/images/avatars/${storeData.storeLogo}"/>
                <span class="text-2xl font-semibold text-gray-800">
                    <c:out value="${storeData.storeName}"/>
                </span>
            </div>
            <a class="text-teal-600 hover:underline font-medium" href="/homeUser?action=showStore&store_id=${storeData.storeId}">
                Thêm món
            </a>
        </div>

        <div class="flex flex-col lg:flex-row gap-4">
            <div class="w-full lg:w-2/3 bg-white p-4 rounded shadow-md">
                <table class="w-full text-left">
                    <thead>
                    <tr class="border-b">
                        <th class="py-3 font-semibold text-gray-700">Sản phẩm</th>
                        <th class="py-3 font-semibold text-gray-700">Giá</th>
                        <th class="py-3 font-semibold text-gray-700">Số lượng</th>
                        <th class="py-3 font-semibold text-gray-700">Tổng</th>
                        <th class="py-3 font-semibold text-gray-700"></th>
                    </tr>
                    </thead>
                    <tbody class="divide-y">
                    <c:forEach var="item" items="${storeData.items}" varStatus="status">
                        <tr>
                            <td class="py-4 flex items-center">
                                <img src="${pageContext.request.contextPath}/images/product/${item.productImage}"
                                     class="mr-3 w-12 h-12 object-cover rounded border border-gray-300"
                                     alt="Ảnh sản phẩm"/>
                                <span class="text-gray-800"><c:out value="${item.productName}"/></span>
                            </td>
                            <td class="py-4 text-gray-600"><fmt:formatNumber pattern="#,###" value="${item.priceAtTime}"/> đ</td>
                            <td class="py-4">
                                <div class="flex items-center space-x-2">
                                    <button id="decrease_${item.productId}" type="button"
                                            class="btn btn-outline-secondary">-
                                    </button>
                                    <input id="quantity_${item.productId}" type="number" value="${item.quantity}"
                                           class="form-control text-center mx-2" style="width: 60px;" min="1" step="1">
                                    <button id="increase_${item.productId}" type="button"
                                            class="btn btn-outline-secondary">+
                                    </button>
                                </div>
                            </td>
                            <td class="py-4 text-gray-600" id="total-${item.productId}">
                                <fmt:formatNumber pattern="#,###" value="${item.priceAtTime * item.quantity}"/> đ
                            </td>
                            <td class="py-4 text-red-500 cursor-pointer hover:text-red-600 transition-colors">
                                <button type="button" class="btn btn-outline-danger btn-sm"
                                        onclick="showDeleteModal({ id: ${item.productId}, url: '/homeUser', action: 'deleteProduct' })">
                                    <i class="fas fa-trash-alt" alt="Xoá món ăn"></i>
                                </button>
                            </td>
                        </tr>
                        <script>
                            (function () {
                                const quantityInput = document.getElementById('quantity_${item.productId}');
                                const increaseBtn = document.getElementById('increase_${item.productId}');
                                const decreaseBtn = document.getElementById('decrease_${item.productId}');
                                const totalCell = document.getElementById('total-${item.productId}');
                                const priceAtTime = ${item.priceAtTime};

                                const updateTotal = () => {
                                    const quantity = parseInt(quantityInput.value) || 1;
                                    totalCell.textContent = (priceAtTime * quantity).toLocaleString('vi-VN') + ' đ';
                                    updateOrderTotal();
                                    updateProductQuantity(${item.productId}, quantity);
                                };

                                increaseBtn.addEventListener('click', (event) => {
                                    event.preventDefault();
                                    event.stopPropagation();
                                    quantityInput.value = parseInt(quantityInput.value) + 1;
                                    updateTotal();
                                });

                                decreaseBtn.addEventListener('click', (event) => {
                                    event.preventDefault();
                                    event.stopPropagation();
                                    if (parseInt(quantityInput.value) > 1) {
                                        quantityInput.value = parseInt(quantityInput.value) - 1;
                                        updateTotal();
                                    }
                                });


                                quantityInput.addEventListener('input', updateTotal);
                            })();

                            function updateProductQuantity(productId, quantity) {
                                const xhr = new XMLHttpRequest();
                                xhr.open('POST', '/homeUser?action=updateCart', true);
                                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                                xhr.onreadystatechange = function () {
                                    if (xhr.readyState == 4 && xhr.status == 200) {
                                        console.log('Product quantity updated successfully');
                                    }
                                };
                                xhr.send('productId=' + productId + '&quantity=' + quantity);}
                        </script>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="w-full lg:w-1/3 bg-white p-4 rounded shadow-md">
                <h2 class="text-lg font-semibold mb-4 text-gray-800">Tổng đơn hàng</h2>
                <div class="mb-2 flex justify-between text-gray-700">
                    <span>Tổng phụ :</span>
                    <span id="subtotal"><fmt:formatNumber pattern="#,###" value="${storeData.totalAmount}"/>đ</span>
                </div>
                <div class="mb-2 flex justify-between text-gray-700">
                    <span>Phí áp dụng :</span>
                    <span id="shipping">25.000 đ</span>
                </div>
                <div class="mb-4 text-sm text-gray-500">(Bao gồm phí giao hàng và phí xử lý đơn hàng)</div>
                <div class="mb-3">
                    <label class="block mb-1 text-sm text-gray-700 font-medium">Mã giảm giá:</label>
                    <div class="flex">
                        <input
                                type="text"
                                class="border border-gray-300 rounded-l px-2 py-1 text-sm w-40 focus:outline-none focus:ring-1 focus:ring-blue-400"
                                placeholder="Nhập mã..."
                        />
                        <button
                                class="px-3 py-1 bg-blue-500 hover:bg-blue-600 text-white text-sm font-medium rounded-r transition duration-200"
                        >
                            Áp dụng
                        </button>
                    </div>
                </div>

                <div class="mb-2 flex justify-between text-gray-700">
                    <span>Mã giảm giá 1 :</span>
                    <span id="discount1">-5.000 đ</span>
                </div>
                <div class="mb-4 flex justify-between text-gray-700">
                    <span>Mã giảm giá 2 :</span>
                    <span id="discount2">-5.000 đ</span>
                </div>
                <div class="mb-4 flex justify-between font-semibold text-gray-800">
                    <span>Tổng :</span>
                    <span id="total"><fmt:formatNumber pattern="#,###" value="${storeData.totalAmount + 25000 - 5000 - 5000}"/> đ</span>
                </div>

                <button type="submit"
                        class="w-full px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-md font-semibold transition-colors duration-200 shadow-md">
                    Tiến hành đặt hàng
                </button>
            </div>
            <script>
                function updateOrderTotal() {
                    let subtotal = 0;
                    document.querySelectorAll("[id^='total-']").forEach(cell => {
                        subtotal += parseInt(cell.textContent.replace(/[^0-9]/g, "")) || 0;
                    });

                    document.getElementById("subtotal").textContent = subtotal.toLocaleString('vi-VN') + " đ";

                    const shippingFee = 25000;
                    const discount1 = 5000;
                    const discount2 = 5000;
                    const total = subtotal + shippingFee - discount1 - discount2;

                    document.getElementById("total").textContent = total.toLocaleString('vi-VN') + " đ";
                }
            </script>
        </div>
        </form>
    </c:if>
    <jsp:include page="../../admin/system/modalConfirmDelete.jsp" />
</div>


</body>
</html>
