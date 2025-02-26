


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title> sửa địa chỉ giao hàng</title>

</head>
<body>
<form action="/userInformation?action=editAddressUser" method="post">
    <input type="hidden" name="accountDetailID" value="${address.accountDetailID}">

    <label>Địa chỉ:</label>
    <input type="text" name="address" value="${address.address}" required><br>

    <label>Số điện thoại:</label>
    <input type="text" name="phonenumber" value="${address.phonenumber}" required><br>

<%--    <label>Địa chỉ mặc định:</label>--%>
<%--    <input type="checkbox" name="isDefault" ${address.isDefault ? 'checked' : ''}><br>--%>

    <button type="submit">Cập nhật</button>
</form>
</body>
</html>

