
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/manageMerchants?action=updateMerchant" method="post" enctype="multipart/form-data">
    <table border="1">
        <tr>
            <td>Tên cửa hàng</td>
            <td><input type="text" value="${merchant.store_name}" name="store_name"></td>
        </tr>
        <tr>
            <td>Banner</td>
            <td>
                <img src="/images/avatars/${merchant.banner_path}" alt="banner">
                <input type="hidden" value="${merchant.banner_path}" name="current_banner_path">
                <input type="file" name="banner_path"></td>
        </tr>
        <tr>
            <td>Avatar</td>
            <td>
                <img src="/images/avatars/${merchant.avt_path}" alt="avatar">
                <input type="hidden" value="${merchant.avt_path}" name="current_avt_path">
                <input type="file" value="${merchant.avt_path}" name="avt_path"></td>
        </tr>
        <tr>
            <td>Địa chỉ </td>
            <td><input type="text" value="${merchant.store_address}" name="store_address"></td>
        </tr>
        <tr>
            <td>Số điện thoại</td>
            <td><input type="text"  value="${merchant.contact_number}" name="contact_number"></td>
        </tr>
        <tr>
            <td>Trạng thái</td>
            <td>
                <input type="radio" name="store_type" value="true" ${merchant.store_type ? 'checked' : ''}> Hoạt động
                <input type="radio" name="store_type" value="false" ${!merchant.store_type ? 'checked' : ''}> Khóa tài khoản
            </td>
        </tr>


    </table>
    <input type="hidden" name="store_id" value="${merchant.store_id}">
    <input type="submit" value="Cập nhật">
</form>

</body>
</html>
