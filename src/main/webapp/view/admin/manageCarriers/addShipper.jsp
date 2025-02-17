<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Nhân Viên Vận Chuyển</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Thêm Nhân Viên Vận Chuyển</h4>
        </div>
        <div class="card-body">
            <form action="manageCarriers?action=addShipper" method="post">

                <div class="mb-3">
                    <label for="shipperName" class="form-label">Tên nhân viên</label>
                    <input type="text" class="form-control" id="shipperName" name="shipperName" placeholder="Nhập tên nhân viên" required>
                </div>

                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Nhập số điện thoại" pattern="0[0-9]{9}" required>
                    <small class="text-muted">Số điện thoại gồm 10 chữ số, bắt đầu bằng 0</small>
                </div>

                <div class="mb-3">
                    <label for="carrier" class="form-label">Nhà vận chuyển</label>
                    <select class="form-select" id="carrier" name="carrierId" required>
                        <c:forEach var="carrier" items="${carriersList}">
                            <option value="${carrier.carrier_id}">${carrier.carrier_name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="manageCarriers" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-success">Thêm nhân viên</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
