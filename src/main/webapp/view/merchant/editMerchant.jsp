
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="editMerchant.jsp" method="get">
    <input type="hidden" name="username" value="${merchant.username}">
    <input type="hidden" name="avtPath" value="${merchant.avtPath}">
    <input type="hidden" name="active" value="${merchant.active}">
    <input type="submit" value="Sửa">
</form>

</body>
</html>
