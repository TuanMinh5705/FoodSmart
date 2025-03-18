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
    <style>
        body {
            background-color: #f7f7f7;
        }
        .card {
            margin-top: 50px;
            border: none;
            border-radius: 10px;
        }
        .card-title {
            font-weight: bold;
        }
        .btn-custom {
            background-color: #007bff;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<jsp:include page="sidebarUser.jsp"/>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">Sửa Địa Chỉ Giao Hàng</h3>
                    <form action="/userInformation?action=editAddressUser" method="post">
                        <input type="hidden" name="accountDetailID" value="${address.accountDetailID}">
                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ:</label>
                            <input type="text" class="form-control" id="address" name="address" value="${address.address}" required>
                        </div>
                        <div class="mb-3">
                            <label for="phonenumber" class="form-label">Số điện thoại:</label>
                            <input type="text" class="form-control" id="phonenumber" name="phonenumber" value="${address.phonenumber}" required>
                        </div>
                        <!--
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="isDefault" name="isDefault" ${address.isDefault ? 'checked' : ''}>
                                <label class="form-check-label" for="isDefault">Địa chỉ mặc định</label>
                            </div>
                            -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-custom">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>