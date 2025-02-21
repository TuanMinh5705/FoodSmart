<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/manageStore?action=editMerchantStore" method="post">
    <input type="hidden" name="action" value="editMerchantStore">
    <label>Username:</label>
    <input type="text" name="username" value="${loggedInAccount.username}"/><br>
    <label>Password:</label>
    <input type="password" name="password" value="${loggedInAccount.password}"/><br>
    <label>Avt Path:</label>
    <input type="text" name="avtPath" value="${loggedInAccount.avtPath}"/><br>
    <label>Active:</label>
    <input type="checkbox" name="active" value="true"
           <c:if test="${loggedInAccount.active}">checked</c:if> /><br>
    <input type="submit" value="Cập nhật">
</form>


</body>
</html>
