<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">

<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header text-center bg-primary text-white">
            <h3>Chi tiết cửa hàng</h3>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <td class="bg-light" style="width: 200px;">
                        <i class="fas fa-store-alt"></i> Tên cửa hàng
                    </td>
                    <td>${merchant.store_name}</td>
                </tr>
                <tr>
                    <td class="bg-light">
                        <i class="fas fa-map-marker-alt"></i> Địa chỉ
                    </td>
                    <td>${merchant.store_address}</td>
                </tr>
                <tr>
                    <td class="bg-light">
                        <i class="fas fa-phone-alt"></i> Số điện thoại
                    </td>
                    <td>${merchant.contact_number}</td>
                </tr>
                <tr>
                    <td class="bg-light">
                        <i class="fas fa-image"></i> Banner
                    </td>
                    <td class="text-center">
                        <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${merchant.banner_path}" alt="banner"
                             class="img-fluid rounded" style="max-width: 300px;"></td>
                </tr>
                <tr>
                    <td class="bg-light">
                        <i class="fas fa-user-circle"></i> Avatar
                    </td>
                    <td class="text-center">
                        <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${merchant.avt_path}" alt="avatar"
                             class="img-fluid rounded-circle" style="max-width: 120px;">
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">
                        <label class="form-label"><i class="fas fa-cogs"></i> Trạng thái</label>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${merchant.store_type == true}">
                                <span class="badge bg-success"><i class="fas fa-check-circle"></i> Đang hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger"><i class="fas fa-times-circle"></i> Khóa tài khoản</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
        </div>
        <div class="card-footer text-center">
            <a href="/manageMerchants" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
