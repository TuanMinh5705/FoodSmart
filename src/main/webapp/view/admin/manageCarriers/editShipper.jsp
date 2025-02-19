<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.foodSmart.model.admin.Shipper" %>
<%
    Shipper shipper = (Shipper) request.getAttribute("shipper");
    if (shipper == null) {
        response.sendRedirect("manageShippers"); // Chuyển hướng nếu không có dữ liệu
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Nhân Viên Vận Chuyển</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h4 class="mb-0">Sửa Nhân Viên Vận Chuyển</h4>
        </div>
        <div class="card-body">
            <form action="manageCarriers?action=editShipper" method="post">
                <input type="hidden" name="shipperId" value="${shipper.shipper_id}">

                <div class="mb-3">
                    <label for="shipperName" class="form-label">Tên nhân viên</label>
                    <input type="text" class="form-control" id="shipperName" name="shipperName" value="${shipper.shipper_name}" required>
                </div>

                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${shipper.phonenumber}" pattern="0[0-9]{9}" required>
                    <small class="text-muted">Số điện thoại gồm 10 chữ số, bắt đầu bằng 0</small>
                </div>

                <div class="mb-3">
                    <label for="carrier" class="form-label">Nhà vận chuyển</label>
                    <select class="form-select" id="carrier" name="carrierId" required>
                        <c:forEach var="carrier" items="${carriersList}">
                            <option value="${carrier.carrier_id}" ${shipper.carrier_name == carrier.carrier_name ? 'selected' : ''}>
                                    ${carrier.carrier_name}
                            </option>
                        </c:forEach>
                    </select>

                </div>

                <div class="d-flex justify-content-between">
                    <a href="manageCarriers" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
