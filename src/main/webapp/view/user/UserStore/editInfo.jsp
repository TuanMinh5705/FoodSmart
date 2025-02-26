<%--
  Created by IntelliJ IDEA.
  User: Khanh Nguyen
  Date: 2/25/2025
  Time: 10:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sua thong tin</title>
</head>
<body>
<form action="/userInformation?action=editInfoStore" method="post" >
    <p> Ten dang nhap :</p>
    <input type="hidden" name="accountID" value="${loggedInAccount.accountID}">
    <input type="text" name="username" value="${loggedInAccount.username}">
    <p>Mật khẩu:</p>
    <div class="input-group">
        <input id="password" type="password" name="password" value="${loggedInAccount.password}">
        <span class="toggle-password" style="cursor: pointer; margin-left: 5px;">
        <i class="fas fa-eye"></i>
    </span>
    </div>

    <input type="file" name="avt_path" value="${loggedInAccount.avtPath}">
    <select name="status">
        <option value="true">active</option>
        <option value="false">inactive</option>
    </select>
    <button type="submit">Cap nhat</button>
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function() {
        $(".toggle-password").click(function() {
            var input = $("#password");
            var icon = $(this).find("i");

            if (input.attr("type") === "password") {
                input.attr("type", "text");
                icon.removeClass("fa-eye").addClass("fa-eye-slash");
            } else {
                input.attr("type", "password");
                icon.removeClass("fa-eye-slash").addClass("fa-eye");
            }
        });
    });
</script>

</body>
</html>
