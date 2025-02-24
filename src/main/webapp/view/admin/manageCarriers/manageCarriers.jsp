<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đối tác vận chuyển</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body>
<c:if test="${not empty success}">
    <script>
        Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: '${success}',
            showConfirmButton: false,
            timer: 2000,
            width: '300px'
        });
    </script>
    <% session.removeAttribute("success"); %>
</c:if>
<c:if test="${not empty error}">
    <script>
        Swal.fire({
            position: 'top-end',
            icon: 'error',
            title: '${error}',
            showConfirmButton: false,
            timer: 2000,
            width: '300px'
        });
    </script>
    <% session.removeAttribute("error"); %>
</c:if>
<div class="container mt-4">
    <h2 class="text-center text-primary">Quản lý Vận Chuyển</h2>

    <div class="d-flex justify-content-between mb-3">
        <div>
            <a href="/manageCarriers?action=addCarrierForm" class="btn btn-success me-2">
                <i class="fa fa-plus"></i> Thêm nhà vận chuyển
            </a>
            <a href="/manageCarriers?action=addShipperForm" class="btn btn-success">
                <i class="fa fa-plus"></i> Thêm nhân viên vận chuyển
            </a>
        </div>
        <div class="d-flex align-items-center">
            <label for="filterSelect" class="me-2">Bộ lọc :  </label>
            <select id="filterSelect" class="form-select" style="width: 200px;">
                <option value="all">Tất cả</option>

                <c:forEach var="carrier" items="${carriersList}">
                    <option value="${carrier.carrier_name}">${carrier.carrier_name}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <h4 class="text-primary">Danh sách Nhà Vận Chuyển</h4>
    <table id="carrierTable" class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>#</th>
            <th>Tên Nhà Vận Chuyển</th>
            <th>Số Điện Thoại</th>
            <th>Phí Vận Chuyển</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="carrier" items="${carriersList}" varStatus="status">
            <!-- Gán thuộc tính data-carrier cho mỗi hàng -->
            <tr data-carrier="${carrier.carrier_name}">
                <td>${status.index+1}</td>
                <td id="carrierName">${carrier.carrier_name}</td>
                <td>${carrier.contact_phone}</td>
                <td><fmt:formatNumber value="${carrier.shipping_cost}" pattern="#,###" />đ</td>
                <td>
                    <div class="btn-group">
                        <a href="/manageCarriers?action=editCarrierForm&id=${carrier.carrier_id}" class="btn btn-warning btn-sm">
                            <i class="fa fa-edit"></i> Sửa
                        </a>
                        <a href="/manageCarriers?action=infoCarrierForm&id=${carrier.carrier_id}" class="btn btn-info btn-sm">
                            <i class="fas fa-info-circle"></i> Chi tiết
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <hr>
    <h4 class="text-primary">Danh sách nhân viên vận chuyển</h4>
    <table id="shipperTable" class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>#</th>
            <th>Tên Nhân Viên</th>
            <th>Số Điện Thoại</th>
            <th>Nhà Vận Chuyển</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="shipper" items="${shippersList}" varStatus="status">
            <tr data-carrier="${shipper.carrier_name}">
                <td>${status.index+1}</td>
                <td>${shipper.shipper_name}</td>
                <td>${shipper.phonenumber}</td>
                <td id="carrierForShipper">${shipper.carrier_name}</td>
                <td>
                    <div class="btn-group">
                        <a href="/manageCarriers?action=editShipperForm&id=${shipper.shipper_id}" class="btn btn-warning btn-sm">
                            <i class="fa fa-edit"></i> Sửa
                        </a>
                        <a href="/manageCarriers?action=infoShipperForm&id=${shipper.shipper_id}" class="btn btn-info btn-sm">
                            <i class="fa fa-eye"></i> Chi tiết
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("filterSelect").addEventListener("change", function () {
        let selectedCarrier = this.value;

        let carrierRows = document.querySelectorAll("#carrierTable tbody tr");
        carrierRows.forEach(row => {
            let carrier = row.getAttribute("data-carrier");
            row.style.display = (selectedCarrier === "all" || carrier === selectedCarrier) ? "" : "none";
        });

        let shipperRows = document.querySelectorAll("#shipperTable tbody tr");
        shipperRows.forEach(row => {
            let carrier = row.getAttribute("data-carrier");
            row.style.display = (selectedCarrier === "all" || carrier === selectedCarrier) ? "" : "none";
        });
    });
</script>
</body>
</html>
