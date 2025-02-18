<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <h2>Chi tiết cửa hàng</h2>
    <table border="1">
        <tr>
            <td>Tên cửa hàng</td>
            <td>${merchant.store_name}</td>
        </tr>
        <tr>
            <td>Địa chỉ</td>
            <td>${merchant.store_address}</td>
        </tr>
        <tr>
            <td>Số điện thoại</td>
            <td>${merchant.contact_number}</td>
        </tr>
        <tr>
            <td>Banner</td>
            <td><img src="/images/avatars/${merchant.banner_path}" alt="banner"></td>
            <input type="hidden" value="${merchant.banner_path}" name="current_banner_path">
        </tr>
        <tr>
            <td>Avatar</td>
            <td><img src="/images/avatars/${merchant.avt_path}" alt="avatar"></td>
            <input type="hidden" value="${merchant.avt_path}" name="current_avt_path">
        </tr>
        <tr>
            <td>
                <b>Trạng thái</b>
            </td>
            <td>
                <c:choose>
                    <c:when test="${merchant.store_type == true}">
                        <i class="fas fa-check-circle" style="color: green;"></i>
                        <span style="color: black; font-weight: bold;">Đang hoạt động</span>
                    </c:when>
                    <c:when test="${merchant.store_type == false}">
                        <i class="fas fa-times-circle" style="color: red;"></i>
                        <span style="color: black; font-weight: bold;">Khóa tài khoản</span>
                    </c:when>
                </c:choose>
            </td>

        </tr>






    </table>
</div>


</body>
</html>
