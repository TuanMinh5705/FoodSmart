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
            --primary-gradient: linear-gradient(90deg, #2196F3, #1E88E5);
            --primary-gradient-hover: linear-gradient(90deg, #1E88E5, #2a9ffc);
        }
        body {
            margin: 0;
            padding: 0;
        }
        .custom-container {
            max-width: 800px;
            margin: 50px auto;
        }
        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }
        .card-header {
            background: transparent;
            border-bottom: none;
            text-align: center;
            padding: 20px;
        }
        .avatar {
            width: 150px;
            height: 150px;
            border: 5px solid #fff;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        .info-label {
            font-weight: 600;
            color: #555;
        }
        .info-value {
            font-size: 1.2rem;
            color: #333;
        }
        /* Cập nhật CSS cho button giống trang Thông tin cửa hàng */
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
            background: var(--primary-gradient-hover);
            box-shadow: 0 8px 20px rgba(21, 149, 255, 0.4);
        }
    </style>
</head>
<body>
<main class="container custom-container">
    <c:choose>
        <c:when test="${not empty merchant}">
            <div class="card">
                <div class="card-header">
                    <h2>Thông tin Merchant</h2>
                </div>
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-4 text-center mb-4 mb-md-0">
                            <img src="${pageContext.request.contextPath}/images/avatars/${merchant.avtPath}" alt="Ảnh đại diện của Merchant" class="avatar">
                        </div>
                        <div class="col-md-8">
                            <div class="row mb-3">
                                <div class="col-4 text-start info-label">Tên tài khoản:</div>
                                <div class="col-8 info-value"><strong>${merchant.username}</strong></div>

                            </div>
                            <div class="row mb-3">
                                <div class="col-4 text-start info-label">Trạng thái:</div>
                                <div class="col-8 info-value">
                                    <c:choose>
                                        <c:when test="${merchant.active}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Không hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="text-start">
                                <a href="/manageStore?action=editMerchantStoreForm" class="btn btn-primary">
                                    <i class="fas fa-edit me-2"></i> Sửa thông tin
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning text-center">Không tìm thấy thông tin Merchant.</div>
        </c:otherwise>
    </c:choose>
</main>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
