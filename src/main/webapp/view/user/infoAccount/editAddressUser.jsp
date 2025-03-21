<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Địa Chỉ Giao Hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<style>
    body {
        background: #ecf0f1;
    }
</style>

<div class="container mt-4" style="margin: 0;">
    <div class="row">
        <!-- Sidebar bên trái -->
        <div class="col-md-3 d-none d-md-block">
            <jsp:include page="sidebarUser.jsp" />
        </div>
        <!-- Nội dung chính bên phải -->
        <div class="col-md-9" style="padding-left: 230px; margin-top: 110px;">
            <div class="card shadow-sm p-4">
                <h3 class="text-center mb-4">Sửa Địa Chỉ Giao Hàng</h3>
                <form action="/userInformation?action=editAddressUser" method="post">
                    <input type="hidden" name="accountDetailID" value="${address.accountDetailID}">
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ:</label>
                        <input type="text" name="address" class="form-control" value="${address.address}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại:</label>
                        <input type="text" name="phonenumber" class="form-control" value="${address.phonenumber}" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
