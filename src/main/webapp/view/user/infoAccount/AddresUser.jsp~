<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách địa chỉ giao hàng</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .address-container {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .default-address {
            font-weight: bold;
        }
        input[type="radio"] { cursor: pointer; margin-right: 10px; }
        button { padding: 8px 15px; cursor: pointer; margin-top: 10px; }
    </style>

</head>
<body>
<h2>Danh sách địa chỉ giao hàng</h2>

<c:forEach var="accountDetail" items="${accountDetailsList}">
    <div class="address-container">
        <label>
            <input type="radio" name="defaultAddress" value="${accountDetail.accountDetailID}"
                ${accountDetail.isDefault ? 'checked' : ''}
                   onchange="setDefaultAddress(${accountDetail.accountDetailID})">
            <strong>Địa chỉ:</strong> ${accountDetail.address}
            <c:if test="${accountDetail.isDefault}">
                <span class="default-address">(Địa chỉ mặc định)</span>
            </c:if><br>
            <strong>Số điện thoại:</strong> ${accountDetail.phonenumber} <br>
        </label>
        <a href="/userInformation?action=editAddressForm&accountDetailID=${accountDetail.accountDetailID}" class="edit-btn">Chỉnh sửa</a>
        <button type="button" class="btn btn-danger btn-sm"
                onclick="showDeleteModal({ id: ${accountDetail.accountDetailID}, url: '/userInformation', action: 'deleteAddress' })">
            <i class="fa fa-trash"></i> Xóa
        </button>
    </div>

</c:forEach>
<script>
    function setDefaultAddress(accountDetailID) {
        fetch('/userInformation?action=setDefaultAddress', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'accountDetailID=' + accountDetailID
        }).then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert('Cập nhật địa chỉ mặc định thất bại!');
                }
            })
            .catch(error => console.error('Lỗi:', error));
    }
</script>


<jsp:include page="../../admin/system/modalConfirmDelete.jsp" />
</body>
</html>
