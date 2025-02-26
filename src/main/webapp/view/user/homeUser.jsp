<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1 align="center">Home User</h1>


<div>
    <a href="/userInformation?action=showUserInformation">Thong tin ca nhan</a>
    <a href="/userInformation?action=showAddressUser">Địa chỉ</a>
    <c:choose>
        <c:when test="${param.page == 'infoUser'}">
            <jsp:include page="UserStore/infoUser.jsp"/>
        </c:when>

<%--        --%>
        <c:when test="${param.page == 'editUser'}">
            <jsp:include page="UserStore/editInfo.jsp"/>
        </c:when>

<%--        địa chỉ giao hàng--%>
        <c:when test="${param.page == 'addressUser'}">
            <jsp:include page="UserStore/AddresUser.jsp"/>
        </c:when>

        <c:when test="${param.page == 'editAddressUser'}">
            <jsp:include page="UserStore/editAddresUser.jsp"/>
        </c:when>

    </c:choose>
</div>


</body>
</html>
