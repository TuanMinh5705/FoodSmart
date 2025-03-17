<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin Merchant</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --primary-color: #6a11cb;
            --secondary-color: #2575fc;
            --primary-gradient: linear-gradient(90deg, #2196F3, #1E88E5);
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
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
        /* Sử dụng Flexbox để xếp avatar bên trái, thông tin bên phải */
        .profile-card .card-body {
            display: flex;
            align-items: center;
            padding: 2rem;
        }
        .avatar-container {
            flex-shrink: 0;
            margin-right: 2rem;
        }
        .avatar {
            width: 120px;
            height: 120px;
            border: 5px solid #fff;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        .merchant-info {
            flex-grow: 1;
        }
        .merchant-info h3 {
            margin-bottom: 0.5rem;
            font-weight: 700;
            color: #333;
        }
        .merchant-info p {
            margin: 0.2rem 0;
            font-size: 1.1rem;
            color: #555;
        }
        /* CSS cho input có icon bên trong */
        .input-with-icon {
            position: relative;
        }
        .input-with-icon input {
            padding-right: 2.5rem;
            background-color: transparent !important; /* Bỏ màu nền */
            border-radius: 10px !important; /* Bo góc */
            border: 1px solid #ced4da; /* Đặt border mặc định */
        }
        /* Loại bỏ hiệu ứng hover và focus cho input */
        .input-with-icon input:hover,
        .input-with-icon input:focus {
            background-color: transparent !important;
            box-shadow: none !important;
            border-color: #ced4da !important;
        }
        .input-with-icon .toggle-password {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
        }
        /* Cập nhật style cho button sử dụng gradient mới */
        .btn-primary {
            border-radius: 8px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            background: var(--primary-gradient);
            border: none;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #1E88E5, #2a9ffc);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
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
        <c:when test="${not empty merchant}">
            <div class="profile-card mx-auto">
                <!-- Không cần phần card-header vì bỏ ảnh nền -->
                <div class="card-body">
                    <div class="avatar-container">
                        <img src="${pageContext.request.contextPath}/images/avatars/${merchant.avtPath}"
                             alt="Ảnh đại diện của Merchant" class="avatar">
                    </div>
                    <div class="merchant-info">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Tên tài khoản:</label>
                                <h3>${merchant.username}</h3>
                            </div>
                        </div>
                        <p class="mt-3"><strong>Trạng thái: </strong>
                            <c:choose>
                                <c:when test="${merchant.active}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Không hoạt động</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div class="mt-4 mb-4">
                            <a href="/manageStore?action=editMerchantStoreForm" class="btn btn-primary">
                                <i class="fas fa-edit me-2"></i> Sửa thông tin
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center" role="alert">
                Không tìm thấy thông tin Merchant.
            </div>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).on('click', '.toggle-password', function () {
        var input = $('#password');
        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            $(this).removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            input.attr('type', 'password');
            $(this).removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });
</script>
</body>
</html>
