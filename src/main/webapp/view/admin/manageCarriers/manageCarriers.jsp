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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Thêm FontAwesome để sử dụng icon nếu cần -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        .table thead th {
            background-color: #343a40;
            color: #fff;
            text-align: center;
            vertical-align: middle;
        }
        .table td,
        .table th {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body class="bg-light">
<c:if test="${not empty success}">
    <script>
        Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: '${success}',
            showConfirmButton: false,
            timer: 2000,
            width: '400px'
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
            width: '400px'
        });
    </script>
    <% session.removeAttribute("error"); %>
</c:if>

<div class="container mt-4">
    <h2 class="text-center mb-4 font-weight-bold">Quản lý Vận Chuyển</h2>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <a href="/manageCarriers?action=addShipperForm" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Thêm nhân viên vận chuyển
            </a>
        </div>
        <div class="d-flex align-items-center">
            <label for="filterSelect" class="me-2">Bộ lọc:</label>
            <select id="filterSelect" class="form-select" style="width: 200px;">
                <option value="all">Tất cả</option>
                <c:forEach var="carrier" items="${carriersList}">
                    <option value="${carrier.carrier_name}">${carrier.carrier_name}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <h4 class="text-primary">Danh sách Nhà Vận Chuyển</h4>
    <div class="card shadow rounded mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <table id="carrierTable" class="table table-bordered table-striped table-hover">
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
                            <td>${carrier.carrier_name}</td>
                            <td>${carrier.contact_phone}</td>
                            <td><fmt:formatNumber value="${carrier.shipping_cost}" pattern="#,###"/>đ</td>
                            <td class="text-center">
                                <a href="/manageCarriers?action=editCarrierForm&id=${carrier.carrier_id}"
                                   class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <a href="/manageCarriers?action=infoCarrierForm&id=${carrier.carrier_id}"
                                   class="btn btn-info btn-sm" title="Chi tiết">
                                    <i class="bi bi-info-circle"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <h4 class="text-primary">Danh sách nhân viên vận chuyển</h4>
    <div class="card shadow rounded">
        <div class="card-body">
            <div class="table-responsive">
                <table id="shipperTable" class="table table-bordered table-striped table-hover">
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
                            <td>${shipper.carrier_name}</td>
                            <td class="text-center">
                                <a href="/manageCarriers?action=editShipperForm&id=${shipper.shipper_id}"
                                   class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <a href="/manageCarriers?action=infoShipperForm&id=${shipper.shipper_id}"
                                   class="btn btn-info btn-sm" title="Chi tiết">
                                    <i class="bi bi-info-circle"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Xử lý lọc chung cho cả 2 bảng
    document.getElementById("filterSelect").addEventListener("change", function () {
        let selectedCarrier = this.value;
        document.querySelectorAll("#carrierTable tbody tr, #shipperTable tbody tr").forEach(row => {
            row.style.display = (selectedCarrier === "all" || row.getAttribute("data-carrier") === selectedCarrier) ? "" : "none";
        });
    });
</script>
</body>
</html>
