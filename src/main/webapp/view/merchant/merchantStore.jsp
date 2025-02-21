<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="1">
    <tr>
        <td>Tên cửa hàng</td>
        <td>Địa chỉ</td>
        <td>Số điện thoại</td>
        <td>banner</td>
        <td>avt</td>
        <td>Trạng thái</td>
    </tr>

        <tr>
            <td>${store.store_name}</td>
            <td>${store.store_address}</td>
            <td>${store.contact_number}</td>
            <td>${store.banner_path}</td>
            <td>${store.avt_path}</td>
            <td>${store.store_type}</td>
        </tr>

</table>
<a href="/manageStore?action=editInfoStoreForm">sửa</a>

</body>
</html>
