<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết cửa hàng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        .profile-card {
            max-width: 500px;
            margin: 20px auto;
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .profile-banner {
            position: relative;
            height: 200px;
        }
        .banner-img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ảnh banner sử dụng object-fit: contain */
        }
        .profile-avatar {
            position: absolute;
            left: 50%;
            bottom: -50px;
            transform: translateX(-50%);
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 5px solid #fff;
            object-fit: cover;
            box-shadow: 0 0 8px rgba(0,0,0,0.15);
        }
        .profile-body {
            margin-top: 60px;
            padding: 20px;
        }
        .profile-info h3 {
            font-size: 1.8rem;
            font-weight: 600;
            color: #333;
        }
        .profile-info p {
            margin: 0.2rem 0;
            color: #555;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="fas fa-info-circle"></i> Chi tiết cửa hàng
    </h2>

    <div class="card shadow p-4">
        <table class="table table-bordered">
            <tbody>
            <tr>
                <td class="bg-light" style="width: 200px;">
                    <i class="bi bi-shop-window"></i> Tên cửa hàng
                </td>
                <td>${merchant.store_name}</td>
            </tr>
            <tr>
                <td class="bg-light">
                    <i class="bi bi-geo-alt"></i> Địa chỉ
                </td>
                <td>${merchant.store_address}</td>
            </tr>
            <tr>
                <td class="bg-light">
                    <i class="bi bi-telephone-fill"></i> Số điện thoại
                </td>
                <td>${merchant.contact_number}</td>
            </tr>
            <tr>
                <td class="bg-light">
                    <i class="bi bi-person-circle"></i> Avatar
                </td>
                <td class="text-center">
                    <img src="${pageContext.request.contextPath}/images/avatars/${merchant.avt_path}"
                         alt="avatar"
                         class="img-fluid rounded-circle object-fit-contain" style="max-width: 130px; height: 130px;">
                </td>
            </tr>
            <tr>
                <td class="bg-light">
                    <i class="bi bi-image"></i> Banner
                </td>
                <td class="text-center">
                    <img src="${pageContext.request.contextPath}/images/avatars/${merchant.banner_path}"
                         alt="banner"
                         class="img-fluid rounded object-fit-contain" style="max-width: 300px;">
                </td>
            </tr>
            <tr>
                <td class="bg-light">
                    <i class="bi bi-gear"></i> Trạng thái
                </td>
                <td>
                    <c:choose>
                        <c:when test="${merchant.store_type}">
                                <span class="badge bg-success">
                                    <i class="bi bi-check-circle"></i> Đang hoạt động
                                </span>
                        </c:when>
                        <c:otherwise>
                                <span class="badge bg-danger">
                                    <i class="bi bi-x-circle"></i> Khóa tài khoản
                                </span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </tbody>
        </table>

        <div class="d-flex justify-content-center gap-3 mt-4">
            <a href="/manageMerchants" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Quay lại
            </a>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
