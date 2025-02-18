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
    <style>
        /* Định nghĩa style cho phần nội dung chính */
        .content {
            margin-top: 10px;
            margin-left: 250px;
            padding: 10px;
            transition: margin-left 0.3s ease;
        }
        /* Trên màn hình nhỏ (<902px) bỏ margin-left */
        @media (max-width: 901px) {
            .content {
                margin-left: 5px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="system/menubar.jsp" />
<jsp:include page="system/sidebar.jsp" />


<div class="content">
    <c:choose>
        <c:when test="${param.page == 'home'}">
            <jsp:include page="content.jsp"/>
        </c:when>

        <%--        quản lý người dùng--%>
        <c:when test="${param.page == 'manageMerchants'}">
            <jsp:include page="manageMerchants/manageMerchants.jsp"/>
        </c:when>

        <c:when test="${param.page == 'addMerchants'}">
            <jsp:include page="manageMerchants/addMerchants.jsp"/>
        </c:when>

        <%--        quản lý người dùng--%>
        <c:when test="${param.page == 'manageUsers'}">
            <jsp:include page="manageUsers/manageUsers.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageUsers_updateInfo'}">
            <jsp:include page="manageUsers/editAccount.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageUsers_showInfo'}">
            <jsp:include page="manageUsers/infoAccount.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageUsers_addAccount'}">
            <jsp:include page="manageUsers/addAccount.jsp"/>
        </c:when>


        <c:when test="${param.page == 'manageVouchers'}">
            <jsp:include page="manageVouchers.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageOrders'}">
            <jsp:include page="manageOrders.jsp"/>
        </c:when>

        <%--        quản lý người dùng--%>
        <c:when test="${param.page == 'manageCarriers'}">
            <jsp:include page="manageCarriers/manageCarriers.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editCarriers'}">
            <jsp:include page="manageCarriers/editCarrier.jsp"/>
        </c:when>
        <c:when test="${param.page == 'infoCarriers'}">
            <jsp:include page="manageCarriers/infoCarrier.jsp"/>
        </c:when>
        <c:when test="${param.page == 'addCarriers'}">
            <jsp:include page="manageCarriers/addCarrier.jsp"/>
        </c:when>

        <c:when test="${param.page == 'editShippers'}">
            <jsp:include page="manageCarriers/editShipper.jsp"/>
        </c:when>
        <c:when test="${param.page == 'infoShippers'}">
            <jsp:include page="manageCarriers/infoShipper.jsp"/>
        </c:when>
        <c:when test="${param.page == 'addShippers'}">
            <jsp:include page="manageCarriers/addShipper.jsp"/>
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

        <c:otherwise>
            <jsp:include page="content.jsp"/>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
