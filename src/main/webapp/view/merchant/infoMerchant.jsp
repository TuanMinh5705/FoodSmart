<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông tin Merchant</title>
</head>
<body>
<p>Tên đăng nhập : ${merchant.username}</p>
<input id="password" type="password" name="password" class="form-control" value="${merchant.password}" readonly>
<div class="input-group-append">
                                        <span class="input-group-text toggle-password">
                                            <i class="fas fa-eye"></i>
                                        </span>
</div>
<p>Ảnh đại diện : <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${merchant.avtPath}" alt=""></p>
<p>Trạng thái : ${merchant.active}</p>
<a href="/manageStore?action=editMerchantStoreForm">sửa</a>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).on('click', '.toggle-password', function () {
        var input = $('#password');
        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            $(this).find('i').removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            input.attr('type', 'password');
            $(this).find('i').removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });
</script>
</html>
