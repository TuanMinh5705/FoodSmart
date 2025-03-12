<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý đơn hàng</title>
    <!-- Font và Bootstrap -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

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
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .custom-container {
            margin: auto;
            padding: 2rem 1rem;
        }
        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            background: #fff;
            animation: fadeInUp 1s ease;
            margin-bottom: 2rem;
        }
        .card-header {
            background: transparent;
            color: #000;
            text-align: center;
            padding: 1.8rem;
            font-size: 2rem;
            font-weight: 700;
        }
        .card-body {
            padding: 2rem;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="container my-4 custom-container">
    <div class="card">
        <div class="card-header">
            Quản lý đơn hàng
        </div>
        <div class="card-body">
            <!-- Tìm kiếm -->
            <div class="row mb-4">
                <input type="text" id="customSearchBox" class="form-control custom-search-box" placeholder="🔍 Tìm kiếm...">
            </div>
            <!-- Bảng đơn hàng -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover display" id="orderTable">
                    <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Tên người đặt</th>
                        <th>Tên cửa hàng</th>
                        <th>Ngày đặt hàng</th>
                        <th>Phương thức thanh toán</th>
                        <th>Trạng thái đơn hàng</th>
<%--                        <th>Tổng tiền</th>--%>
                        <th>Hành động</th>

                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.username}</td>
                            <td>${order.storeName}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.paymentMethod eq 'cod'}">
                                        Thanh toán khi nhận hàng
                                    </c:when>
                                    <c:when test="${order.paymentMethod eq 'bank'}">
                                        Chuyển khoản ngân hàng
                                    </c:when>
                                    <c:otherwise>
                                        ${order.paymentMethod}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${order.orderStatus}</td>
<%--                            <td>${order.totalAmount}</td>--%>
                            <td>
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="#" title="Chỉnh sửa">
                                        <i class="fas fa-pencil-alt"></i>
                                    </a>
                                    <a href="/manageOrder?action=showOrderDetail&id=${order.orderId}" class="btn btn-custom btn-secondary btn-sm" title="Chi tiết">
                                        <i class="fas fa-eye"></i>
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
    $(document).ready(function () {
        const table = $('#orderTable').DataTable({
            "language": {
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ đơn hàng",
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ đơn hàng",
                "infoEmpty": "Không có dữ liệu",
                "infoFiltered": "(lọc từ _MAX_ đơn hàng)",
                "zeroRecords": "Không tìm thấy kết quả nào phù hợp",
                "emptyTable": "Không có dữ liệu trong bảng",
                "paginate": {
                    "first": "Đầu",
                    "last": "Cuối",
                    "next": "Tiếp",
                    "previous": "Trước"
                },
                "loadingRecords": "Đang tải...",
                "processing": "Đang xử lý..."
            }
        });
        $('#customSearchBox').on('keyup', function () {
            table.search(this.value).draw();
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
