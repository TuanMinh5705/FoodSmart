
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/manageMerchants?action=addMerchant" method="post">
    <table>
        <tr>
            <td>Tên cửa hàng</td>
            <td><input type="text" name="store_name"></td>
        </tr>
        <tr>
            <td>Địa chỉ</td>
            <td><input type="text" name="store_address"></td>
        </tr>
        <tr>
            <td>Số điện thoại </td>
            <td><input type="text" name="contact_number"></td>
        </tr>
        <tr>
            <td>Banner</td>
            <td><input type="file" name="banner_path"></td>
        </tr>
        <tr>
            <td>Avatar</td>
            <td><input type="file" name="avt_path"></td>
        </tr>
    </table>
    <button type="submit">Add</button>
</form>


</body>
</html>
