<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin cửa hàng - VIP Pro</title>
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --primary-color: #6a11cb;
            --secondary-color: #2575fc;
            --primary-gradient: linear-gradient(90deg, #8E2DE2, #4A00E0);
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        /* Custom container: thu hẹp chiều rộng và tăng chiều cao */
        .custom-container {
            max-width: 800px;
            min-height: 100vh;
            margin: auto;
        }
        .profile-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            background: #fff;
            animation: fadeInUp 1s ease;
            margin-bottom: 2rem;
        }
        .profile-card .card-header {
            position: relative;
            height: 180px;
            background-image: url('${pageContext.request.contextPath}/foodSmartImages/avatars/${store.banner_path}');
            background-size: cover;
            background-position: center;
        }
        .profile-card .card-header::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.4);
        }
        .avatar-container {
            position: relative;
            text-align: center;
            margin-top: -60px;
        }
        .avatar {
            width: 120px;
            height: 120px;
            border: 5px solid #fff;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .store-info {
            text-align: center;
            padding-top: 1rem;
        }
        .store-info h3 {
            margin-bottom: 0.5rem;
            font-weight: 700;
            color: #333;
        }
        .store-info p {
            margin: 0.2rem 0;
            font-size: 1.1rem;
            color: #555;
        }
        .btn-primary {
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: var(--primary-gradient);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(142, 45, 226, 0.4);
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="container py-5 custom-container">
    <c:choose>
        <c:when test="${not empty store}">
            <div class="profile-card mx-auto">
                <!-- Banner làm nền header -->
                <div class="card-header"></div>
                <!-- Nội dung chính -->
                <div class="card-body">
                    <!-- Avatar nổi giữa header và nội dung -->
                    <div class="avatar-container">
                        <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.avt_path}"
                             alt="Ảnh đại diện của cửa hàng" class="avatar">
                    </div>
                    <div class="store-info mt-3">
                        <h3>${store.store_name}</h3>
                        <p><i class="fas fa-map-marker-alt me-2"></i>${store.store_address}</p>
                        <p><i class="fas fa-phone me-2"></i>${store.contact_number}</p>
                        <p>
                            <c:choose>
                                <c:when test="${store.store_type}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Không hoạt động</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <!-- Thêm khoảng cách bên dưới nút -->
                        <div class="mt-4 mb-4">
                            <a href="/manageStore?action=editInfoStoreForm" class="btn btn-primary">
                                <i class="fas fa-edit me-2"></i> Sửa thông tin
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center" role="alert">
                Không tìm thấy thông tin cửa hàng.
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
