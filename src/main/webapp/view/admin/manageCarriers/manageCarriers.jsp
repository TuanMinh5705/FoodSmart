<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đối tác vận chuyển</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                <i class="bi bi-plus-circle"></i> Thêm nhà vận chuyển
            </a>
            <a href="/manageCarriers?action=addShipperForm" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Thêm nhân viên vận chuyển
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
            <th>STT</th>
            <th>Tên Nhà Vận Chuyển</th>
            <th>Số Điện Thoại</th>
            <th>Phí Vận Chuyển</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="carrier" items="${carriersList}" varStatus="status">
            <tr data-carrier="${carrier.carrier_name}">
                <td>${status.index+1}</td>
                <td id="carrierName">${carrier.carrier_name}</td>
                <td>${carrier.contact_phone}</td>
                <td><fmt:formatNumber value="${carrier.shipping_cost}" pattern="#,###" />đ</td>
                <td>
                    <div class="btn-group">
                        <a href="/manageCarriers?action=editCarrierForm&id=${carrier.carrier_id}" class="btn btn-warning btn-sm" title="Chỉnh sửa">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="/manageCarriers?action=infoCarrierForm&id=${carrier.carrier_id}" class="btn btn-info btn-sm" title="Chi tiết">
                            <i class="fas fa-info-circle"></i>
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
            <th>STT</th>
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
                        <a href="/manageCarriers?action=editShipperForm&id=${shipper.shipper_id}" class="btn btn-warning btn-sm" title="Chỉnh sửa">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="/manageCarriers?action=infoShipperForm&id=${shipper.shipper_id}" class="btn btn-info btn-sm" title="Chi tiết">
                            <i class="fas fa-info-circle"></i>
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

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
