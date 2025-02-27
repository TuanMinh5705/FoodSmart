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
        .content {
            margin-left: 250px;
            padding: 10px;
            transition: margin-left 0.3s ease;
        }
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

<div class="content" style="margin-top: 20px">

    <c:choose>
        <c:when test="${param.page == 'home'}">
            <jsp:include page="system/content.jsp"/>
        </c:when>
      
        <%--        quản lý cua hang--%>
        <c:when test="${param.page == 'manageMerchants'}">
            <jsp:include page="manageMerchants/manageMerchants.jsp"/>
        </c:when>
        <c:when test="${param.page == 'addMerchants'}">
            <jsp:include page="manageMerchants/addMerchants.jsp"/>
        </c:when>
        <c:when test="${param.page == 'updateMerchants'}">
            <jsp:include page="manageMerchants/updateMerchants.jsp"/>
        </c:when>
        <c:when test="${param.page == 'merchantDetails'}">
            <jsp:include page="manageMerchants/merchantDetails.jsp"/>
        </c:when>

        <%--        quản lý danh muc san pham--%>
        <c:when test="${param.page == 'manageCategoriesFood'}">
            <jsp:include page="manageCategoriesFood/manageCategoriesFood.jsp"/>
        </c:when>
        <c:when test="${param.page == 'addCategoriesFood'}">
            <jsp:include page="manageCategoriesFood/addCategoriesFood.jsp"/>
        </c:when>
        <c:when test="${param.page == 'updateCategoriesFood'}">
            <jsp:include page="manageCategoriesFood/updateCategoriesFood.jsp"/>
        </c:when>
        <c:when test="${param.page == 'infoCategoriesFood'}">
            <jsp:include page="manageCategoriesFood/infoCategoriesFood.jsp"/>
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

        <%--        quản lý mã giảm giá của sàn --%>
        <c:when test="${param.page == 'manageVouchers'}">
            <jsp:include page="manageVouchers/manageVouchers.jsp"/>
        </c:when>
        <c:when test="${param.page == 'addVouchers'}">
            <jsp:include page="manageVouchers/addVoucher.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editVouchers'}">
            <jsp:include page="manageVouchers/editVoucher.jsp"/>
        </c:when>
        <c:when test="${param.page == 'infoVouchers'}">
            <jsp:include page="manageVouchers/infoVoucher.jsp"/>
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
            <jsp:include page="system/content.jsp"/>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
