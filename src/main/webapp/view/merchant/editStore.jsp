<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/manageStore?action=editMerchantStore" method="post">
    <input type="hidden" name="merchantId" value=>
    <label>Username:</label>
    <input type="text" name="store_name" value="${loggedInAccount.store_name}"/><br>
    <label>Địa chỉ</label>
    <input type="text" name="store_address" value="${loggedInAccount.store_address}"/><br>
    <label>SDT</label>
    <input type="text" name="contact_number" value="${loggedInAccount.contact_number}"/><br>
    <label>Banner</label>
    <input type="text" name="banner_path" value="${loggedInAccount.banner_path}"/><br>
    <label>Avt</label>
    <input type="text" name="avt_path" value="${loggedInAccount.avt_path}"/><br>
    <label>Trạng thái</label>
    <input type="checkbox" name="store_type" value="true"
           <c:if test="${loggedInAccount.store_type}">checked</c:if> /><br>
    <input type="submit" name="action" value="Cập nhật">
</form>

</body>
</html>
