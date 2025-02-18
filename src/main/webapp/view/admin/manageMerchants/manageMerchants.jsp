<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <button>danh sach dang ki</button>
    <button>danh sach dang ki</button>
    <button>danh sach dang ki</button>
</div>
<div>
    <table border="1">
        <tr>
            <td>#</td>
            <td>Tên cửa hàng</td>
            <td>Địa chỉ</td>
            <td>Số điện thoại</td>
            <td>Hành động</td>
        </tr>
        <c:forEach var="merchant" items="${merchantsList}" varStatus="status">
            <tr>
            <td>${status.index+1}</td>
            <td>
                ${merchant.store_name}
                    <c:choose>
                        <c:when test="${merchant.merchant_type}">
                            <i class="fas fa-check-circle" style="color: green;" title="Đang hoạt động"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-times-circle" style="color: red;" title="Đã bị khóa"></i>
                        </c:otherwise>
                    </c:choose>
            </td>
            <td>${merchant.store_address}</td>
            <td>${merchant.contact_number}</td>
            <td>
            <a href="/manageMerchants?action=addMerchantForm" class="btn btn-danger btn-sm">Add</a>
            <a href="/manageMerchants?action=editMerchantForm" class="btn btn-danger btn-sm">Sửa</a>
            <a href="#" class="btn btn-danger btn-sm">Chi tiết</a>
            </td>

            </tr>
        </c:forEach>

    </table>
</div>

</body>
</html>
