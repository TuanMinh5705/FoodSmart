<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý mã giảm giá</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .table thead th {
            background-color: #343a40;
            color: #fff;
            text-align: center;
            vertical-align: middle;
        }
        .table td, .table th {
            text-align: center;
            vertical-align: middle;
        }
        .action-buttons .btn {
            margin-right: 0.5rem;
        }
        .action-buttons .btn:last-child {
            margin-right: 0;
        }
    </style>
</head>
<body>
<div class="container my-4">
    <h2 class="text-center mb-4">Quản lý mã giảm giá</h2>

    <div class="row mb-3">
        <div class="col-md-3">
            <a href="/manageVouchers?action=addVoucherForm" class="btn btn-success w-100">
                <i class="fas fa-plus"></i> Thêm mã giảm giá
            </a>
        </div>
        <div class="col-md-6">
            <form action="/manageVouchers?action=searchVouchers" method="post" id="searchForm">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Tìm kiếm mã giảm giá" name="keyword" onkeyup="startTimer()">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover" id="voucherTable">
            <thead>
            <tr>
                <th>#</th>
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
                            <a href="/manageVouchers?action=editVoucherForm&voucherID=${voucher.voucher_id}" class="btn btn-primary btn-sm" title="Chỉnh sửa">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="/manageVouchers?action=infoVoucherForm&voucherID=${voucher.voucher_id}" class="btn btn-secondary btn-sm" title="Chi tiết">
                                <i class="fas fa-info-circle"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
    let timer;

    function startTimer() {
        clearTimeout(timer);

        timer = setTimeout(function() {
            document.getElementById("searchForm").submit();
        }, 4500);
    }
</script>
</body>
</html>
