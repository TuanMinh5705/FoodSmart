<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Admin</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
<jsp:include page="menubar.jsp" />
<jsp:include page="sidebar.jsp" />


<div style="margin-top:56px; margin-left:250px; padding:20px;">
    <c:choose>
        <c:when test="${param.page == 'home'}">
            <jsp:include page="content.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageMerchant'}">
            <jsp:include page="manageMerchants.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageUsers'}">
            <jsp:include page="manageUsers.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageVouchers'}">
            <jsp:include page="manageVouchers.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageOrders'}">
            <jsp:include page="manageOrders.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageCarriers'}">
            <jsp:include page="manageCarriers.jsp"/>
        </c:when>
        <c:when test="${param.page == 'revenueStatistics'}">
            <jsp:include page="revenueStatistics.jsp"/>
        </c:when>
        <c:when test="${param.page == 'complaints'}">
            <jsp:include page="complaints.jsp"/>
        </c:when>
        <c:when test="${param.page == 'account'}">
            <jsp:include page="account.jsp"/>
        </c:when>
        <c:when test="${param.page == 'notification'}">
            <jsp:include page="notification.jsp"/>
        </c:when>
    </c:choose>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
