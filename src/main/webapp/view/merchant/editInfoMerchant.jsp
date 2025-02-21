<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Khanh Nguyen
  Date: 2/21/2025
  Time: 8:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h2>Sửa Thống Tin Merchant</h2>

<form action="/manageStore?action=editInfoStore" method="post">
    <input type="hidden" name="merchantId" value="${loggedInMerchant.store_id}">
    <label>Tên cửa hàng:</label>
    <input type="text" name="storeName" value="${loggedInMerchant.store_name}"/><br>
    <label>Địa chỉ cửa hàng:</label>
    <input type="text" name="storeAddress" value="${loggedInMerchant.store_address}"/><br>
    <label>Số điện thoại:</label>
    <input type="text" name="contact_number" value="${loggedInMerchant.contact_number}"/><br>
    <label>Banner Path:</label>
    <input type="text" name="banner_path" value="${loggedInMerchant.banner_path}"/><br>
    <label>Avatar Path:</label>
    <input type="text" name="avt_path" value="${loggedInMerchant.avt_path}"/><br>
    <label>Trạng thái:</label>
    <input type="checkbox" name="store_type" value="true" <c:if test="${loggedInMerchant.store_type}">checked</c:if> /><br>
    <input type="submit" value="Cập nhật">
</form>
</body>
</html>
