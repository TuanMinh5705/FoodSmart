
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/userInformation?action=addAddress" method="post">
    <input type="hidden" name="action" value="addAddressUser">
    <label>Địa chỉ:</label>
    <input type="text" name="address" required> <br>
    <label>Số điện thoại:</label>
    <input type="text" name="phonenumber" required> <br>
    <label>Đặt làm địa chỉ mặc định:</label>
    <input type="checkbox" name="isDefault"><br>
    <button type="submit">Thêm địa chỉ</button>
</form>

</body>
</html>
