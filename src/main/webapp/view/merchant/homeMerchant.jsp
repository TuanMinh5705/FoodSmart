<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ cửa hàng</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<style>
    .content {
        margin-top: 10px;
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
<body>
<jsp:include page="system/menubar.jsp"/>
<jsp:include page="system/sidebar.jsp"/>
<div class="content">
    <c:choose>
    <c:when test="${param.page == 'manageFoods'}">
        <jsp:include page="manageFoods/manageFood.jsp"/>
    </c:when>

    <c:when test="${param.page == 'addFood'}">
        <jsp:include page="manageFoods/addFood.jsp"/>
    </c:when>
        <c:when test="${page == 'infoFood'}">
            <jsp:include page="manageFoods/infoFood.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editFood'}">
        <jsp:include page="manageFoods/editFood.jsp"/>
    </c:when>

        <%--    quan ly ma giam gia--%>
        <c:when test="${param.page == 'manageCoupons'}">
            <jsp:include page="manageCoupons/manageCoupon.jsp"/>
        </c:when>

        <c:when test="${param.page == 'addCoupons'}">
            <jsp:include page="manageCoupons/addCoupon.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editCoupons'}">
            <jsp:include page="manageCoupons/editCoupon.jsp"/>
        </c:when>

        <c:when test="${param.page == 'infoCoupons'}">
            <jsp:include page="manageCoupons/infoCoupon.jsp"/>
        </c:when>
        <c:when test="${param.page == 'manageCoupons'}">
            <jsp:include page="manageCoupons/manageCoupon.jsp"/>
        </c:when>

<%--        Thông tin khách hàng--%>
        <c:when test="${param.page == 'infoStore'}">
            <jsp:include page="merchantStore.jsp"/>
        </c:when>
        <c:when test="${param.page == 'infoMerchantStore'}">
            <jsp:include page="infoMerchant.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editMerchantStore'}">
            <jsp:include page="editMerchant.jsp"/>
        </c:when>
        <c:when test="${param.page == 'editInfoStore'}">
            <jsp:include page="editStore.jsp"/>
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
