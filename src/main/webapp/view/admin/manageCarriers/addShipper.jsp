<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm Nhân Viên Vận Chuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="bi bi-plus-circle-fill"></i> Thêm nhân viên vận chuyển
    </h2>
    <div class="card shadow p-4">
        <form action="manageCarriers?action=addShipper" method="post">
            <div class="mb-3">
                <label class="form-label">Tên nhân viên</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                    <input type="text" class="form-control" name="shipperName" placeholder="Nhập tên nhân viên" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                    <input type="text" class="form-control" name="phoneNumber" placeholder="Nhập số điện thoại" pattern="0[0-9]{9}" required>
                </div>
                <small class="text-muted">Số điện thoại gồm 10 chữ số, bắt đầu bằng 0</small>
            </div>

            <div class="mb-3">
                <label class="form-label">Nhà vận chuyển</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-truck"></i></span>
                    <select class="form-select" name="carrierId" required>
                        <c:forEach var="carrier" items="${carriersList}">
                            <option value="${carrier.carrier_id}">${carrier.carrier_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-check-circle"></i> Thêm nhân viên
                </button>
                <a href="manageCarriers" class="btn btn-danger">
                    <i class="bi bi-x-circle"></i> Hủy
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
