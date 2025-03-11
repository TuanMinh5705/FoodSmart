<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng với Sidebar</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
</head>
<style>
    .dataTables_filter {
        display: none;
    }
    .dataTables_paginate .paginate_button {
        background: #007bff;
        color: white !important;
        border-radius: 5px;
        padding: 5px 10px;
        margin: 2px;
    }

    .dataTables_paginate .paginate_button:hover {
        background: #0056b3;
    }
</style>
<body>

<div>
    <h1>Quản lý đơn hàng</h1>
    <div class="row mb-4">
        <div class="col-md-4 mb-3 mb-md-0">
            <a href="/manageFoods?action=addFoodForm" class="btn btn-custom btn-upload btn-sm">
                <i class="fas fa-plus me-2"></i> <strong>Thêm món ăn</strong>
            </a>
        </div>
        <div class="col-md-6 text-end">
            <input type="text" id="customSearchBox" class="form-control custom-search-box" placeholder="🔍 Tìm kiếm...">
        </div>
    </div>
    <table id="orderTable" class="display">
        <thead>
        <tr>
            <th>Mã đơn hàng</th>
            <th>Mã người dùng</th>
            <th>Mã cửa hàng</th>
            <th>Trạng thái đơn hàng</th>
            <th>Ngày đặt hàng</th>
            <th>Phương thức thanh toán</th>
            <th>Trạng thái thanh toán</th>
            <th>Ngày giao hàng</th>
            <th>Ngày nhận hàng</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orderList}">
        <tr>
            <td>${order.orderId}</td>
            <td>${order.userId}</td>
            <td>${order.storeId}</td>
            <td>${order.orderStatus}</td>
            <td>${order.orderDate}</td>
            <td>${order.paymentMethod}</td>
            <td>${order.paymentStatus}</td>
            <td>${order.shippingDate}</td>
            <td>${order.deliveryDate}</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("active");
    }


    $(document).ready(function () {
        const table = $('#orderTable').DataTable({
            "language": {
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ món ăn",
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ món ăn",
                "infoEmpty": "Không có dữ liệu",
                "infoFiltered": "(lọc từ _MAX_ món ăn)",
                "zeroRecords": "Không tìm thấy kết quả nào phù hợp",
                "emptyTable": "Không có dữ liệu trong bảng",
                "paginate": {
                    "first": "Đầu",
                    "last": "Cuối",
                    "next": "Tiếp",
                    "previous": "Trước"
                },
                "loadingRecords": "Đang tải...",
                "processing": "Đang xử lý...",
            }
        });

        $('#customSearchBox').on('keyup', function () {
            table.search(this.value).draw();
        });
    });
</script>

