<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin Tài Khoản</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,500,600&display=swap" rel="stylesheet">
    <!-- CSS chung -->
    <style>
        body {
            background: #ecf0f1;
            font-family: 'Poppins', sans-serif;
            color: #2c3e50;
        }
        .card {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            background: #ffffff;
        }
        .card-header {
            background: linear-gradient(90deg, #2980b9, #3498db);
            color: #ffffff;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            text-align: center;
            padding: 20px;
        }
        .card-body {
            padding: 30px;
        }
        .avatar {
            width: 130px;
            height: 130px;
            border-radius: 50% !important;
            object-fit: contain;
        }
        .form-label {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .btn-primary {
            background-color: #2980b9;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #2471a3;
        }
        .inline-field {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }
        .inline-field label {
            min-width: 150px;
            margin-bottom: 0;
        }
        .inline-field span,
        .inline-field .input-group {
            flex-grow: 1;
        }
        .badge-success {
            background-color: #27ae60;
            color: #ffffff;
        }
        .badge-secondary {
            background-color: #95a5a6;
            color: #ffffff;
        }

        a {
            text-decoration: none !important;
        }

    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar (include file) -->
        <div class="col-md-3 d-none d-md-block">
            <jsp:include page="sidebarUser.jsp" />
        </div>
        <!-- Nội dung chính -->
        <div class="col-md-9">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="mb-0">Thông tin Tài Khoản</h3>
                            </div>
                            <div class="card-body">
                                <!-- Ảnh đại diện -->
                                <div class="form-group text-center mb-4">
                                    <label class="form-label d-block">Ảnh đại diện</label>
                                    <c:if test="${not empty account.avtPath}">
                                        <img src="${pageContext.request.contextPath}/images/avatars/${account.avtPath}"
                                             alt="Ảnh đại diện" class="avatar img-thumbnail mx-auto d-block object-fit-contain" id="avatarPreview">
                                    </c:if>
                                </div>
                                <!-- Tên đăng nhập -->
                                <div class="inline-field">
                                    <label class="form-label">Tên đăng nhập:</label>
                                    <span>${account.username}</span>
                                </div>

                                <div class="form-group mb-4 d-flex align-items-center">
                                    <label class="form-label mr-3">Trạng thái:</label>
                                    <c:choose>
                                        <c:when test="${account.active}">
                                            <span class="badge badge-success">Đang hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">Không hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="text-center">
                                    <a href="/userInformation?action=editUserForm" class="btn btn-primary">Chỉnh sửa</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Nội dung chính -->
    </div>
</div>
<!-- jQuery và Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
