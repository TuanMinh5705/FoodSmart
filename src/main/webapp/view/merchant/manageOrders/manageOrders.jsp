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
        /* Cập nhật max-width thành 1200px để bảng rộng hơn */
        .custom-container {
            max-width: 1200px;
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
            position: relative;
        }
        .card-header::after {
            display: none;
        }
        .card-body {
            padding: 2rem;
        }
        .btn-sm {
            padding: 0.35rem 0.75rem !important;
            font-size: 0.85rem !important;
            border-radius: 25px !important;
        }
        /* Đồng bộ button */
        .btn-custom {
            border: none !important;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s, background 0.3s;
            color: #fff;
        }
        .btn-primary, .btn-secondary {
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
        }
        .btn-primary:hover, .btn-secondary:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #1E88E5, #2a9ffc);
            box-shadow: none;
        }
        .btn-upload {
            background: linear-gradient(90deg, #2ecc71, #2dc26c);
        }
        .btn-upload:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #2dc26c, #2ecc71);
            box-shadow: none;
        }
        /* Đồng bộ table header */
        .table thead {
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            color: #fff;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .custom-search-box {
            width: 400px !important;
            display: block;
            margin: 0 auto;
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
                        <th>Ngày đặt hàng</th>
                        <th>Phương thức thanh toán</th>
                        <th>Trạng thái đơn hàng</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orderList}">
                        <tr data-order-id="${order.orderId}">
                            <td>DH${order.orderId}</td>
                            <td>${order.username}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss" /></td>
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
                            <td class="status-text">${order.orderStatus}</td>
                            <td>
                                <div class="d-flex justify-content-center gap-2">
                                    <!-- Dùng btn-upload cho nút cập nhật -->
                                    <a href="javascript:void(0);" class="btn btn-custom btn-upload btn-sm" title="Cập nhật trạng thái"
                                       onclick="openUpdateModal('${order.orderId}', '${order.orderStatus}')">
                                        <i class="fas fa-pencil-alt"></i>
                                    </a>
                                    <a href="/manageOrder?action=showOrderDetail&id=${order.orderId}"
                                       class="btn btn-custom btn-secondary btn-sm" title="Chi tiết">
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

<!-- Popup Modal cập nhật trạng thái -->
<div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="statusModalLabel">
                    <i class="fas fa-pencil-alt me-2"></i>Cập nhật trạng thái đơn hàng
                </h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <form id="updateStatusForm" action="/manageOrder" method="POST">
                    <input type="hidden" id="orderIdInput" name="orderId">
                    <div class="mb-3">
                        <label for="orderStatusSelect" class="form-label">Chọn trạng thái</label>
                        <select id="orderStatusSelect" name="status" class="form-select">
                            <option value="Chờ xác nhận">Chờ xác nhận</option>
                            <option value="Đang giao">Đang giao</option>
                            <option value="Hoàn thành">Hoàn thành</option>
                            <option value="Đã hủy">Hủy đon</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-custom btn-success btn-sm" onclick="submitUpdate()">
                    <i class="fas fa-check me-2"></i>Cập nhật
                </button>
                <button type="button" class="btn btn-custom btn-danger btn-sm" data-bs-dismiss="modal">
                    <i class="fas fa-times me-2"></i>Huỷ
                </button>
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

    const statusOrder = {
        'Chờ xác nhận': 1,
        'Đang giao': 2,
        'Hoàn thành': 3,
        'Đã hủy': 4
    };

    function openUpdateModal(orderId, currentStatus) {
        if (currentStatus === "Đã hủy") {
            alert("Đơn hàng đã hủy, không thể cập nhật trạng thái!");
            return;
        }
        document.getElementById("orderIdInput").value = orderId;
        let statusSelect = document.getElementById("orderStatusSelect");
        for (let option of statusSelect.options) {
            option.disabled = false;
        }
        let currentStatusOrder = statusOrder[currentStatus];
        for (let option of statusSelect.options) {
            if (statusOrder[option.value] < currentStatusOrder) {
                option.disabled = true;
            }
        }
        statusSelect.value = currentStatus;
        var statusModal = new bootstrap.Modal(document.getElementById('statusModal'));
        statusModal.show();
    }

    function showNotification(message, type) {
        Swal.fire({
            toast: true,
            position: 'top',
            icon: type,
            title: message,
            showConfirmButton: false,
            timer: 2500,
            timerProgressBar: true
        });
    }

    function submitUpdate() {
        var formData = $("#updateStatusForm").serialize();
        $.ajax({
            url: "manageOrder",
            type: "POST",
            data: formData,
            dataType: "json",
            success: function(response) {
                if (response.status === "success") {
                    showNotification("Cập nhật trạng thái thành công!", "success");
                    $("#statusModal").modal("hide");
                    const orderId = $("#orderIdInput").val();
                    const newStatus = $("#orderStatusSelect").val();
                    var row = $("tr[data-order-id='" + orderId + "']");
                    row.find(".status-text").text(newStatus);
                } else {
                    showNotification("Cập nhật không thành công: " + response.message, "error");
                }
            },
            error: function(xhr, status, error) {
                showNotification("Có lỗi xảy ra: " + error, "error");
            }
        });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
