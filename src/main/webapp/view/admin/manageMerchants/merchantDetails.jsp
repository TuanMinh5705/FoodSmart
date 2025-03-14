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
    <div class="card profile-card">
        <!-- Banner sử dụng thẻ img với object-fit: contain -->
        <div class="profile-banner">
            <img src="${pageContext.request.contextPath}/images/avatars/${merchant.banner_path}" alt="Banner" class="banner-img">
            <!-- Avatar được đặt nổi dưới banner -->
            <img src="${pageContext.request.contextPath}/images/avatars/${merchant.avt_path}" alt="Avatar" class="profile-avatar">
        </div>
        <!-- Thông tin cửa hàng -->
        <div class="card-body profile-body text-center">
            <div class="profile-info">
                <h3>${merchant.store_name}</h3>
                <p><i class="bi bi-geo-alt"></i> ${merchant.store_address}</p>
                <p><i class="bi bi-telephone-fill"></i> ${merchant.contact_number}</p>
            </div>
            <div class="mt-3">
                <c:choose>
                    <c:when test="${merchant.store_type}">
              <span class="badge bg-success fs-5">
                <i class="bi bi-check-circle"></i> Đang hoạt động
              </span>
                    </c:when>
                    <c:otherwise>
              <span class="badge bg-danger fs-5">
                <i class="bi bi-x-circle"></i> Khóa tài khoản
              </span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mt-4">
                <a href="/manageMerchants" class="btn btn-secondary">
                    Quay lại
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
