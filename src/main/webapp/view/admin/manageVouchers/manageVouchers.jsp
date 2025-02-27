<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý mã giảm giá</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .action-buttons .btn {
            margin-right: 0.5rem;
        }
        .action-buttons .btn:last-child {
            margin-right: 0;
        }
        .swal2-popup {
            font-size: 10px;
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
    <h2 class="text-center mb-4 font-weight-bold">Quản lý mã giảm giá</h2>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <a href="/manageVouchers?action=addVoucherForm" class="btn btn-success">
            <i class="bi bi-plus-circle"></i> Thêm mã giảm giá
        </a>
        <form action="/manageVouchers?action=searchVouchers" method="post" id="searchForm" class="d-flex">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm..." name="keyword" onkeyup="startTimer()">
                <button class="btn btn-primary" type="submit" title="Tìm kiếm">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>
    </div>

    <div class="card shadow rounded">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-bordered table-striped">
                    <thead class="table-dark">
                    <tr>
                        <th>STT</th>
                        <th>Mã giảm giá</th>
                        <th>Giá trị (%)</th>
                        <th>Số lượng</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="voucher" items="${voucherList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${voucher.voucher_code}</td>
                            <td>${voucher.discount_value}%</td>
                            <td>${voucher.quantity}</td>
                            <td>
                                <div class="action-buttons d-inline-flex">
                                    <a href="/manageVouchers?action=editVoucherForm&voucherID=${voucher.voucher_id}" class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="/manageVouchers?action=infoVoucherForm&voucherID=${voucher.voucher_id}" class="btn btn-info btn-sm" title="Chi tiết">
                                        <i class="bi bi-info-circle"></i>
                                    </a>
                                </div>
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
    let timer;
    function startTimer() {
        clearTimeout(timer);
        timer = setTimeout(function() {
            document.getElementById("searchForm").submit();
        }, 2000);
    }
</script>
</body>
</html>
