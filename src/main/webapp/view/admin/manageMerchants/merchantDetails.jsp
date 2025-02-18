
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
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
       </tr>
       <tr>
           <td>Avatar</td>
           <td><img src="/images/avatars/${merchant.avt_path}" alt="avatar"></td>
       </tr>


   </table>
</div>


</body>
</html>
