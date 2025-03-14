<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý khiếu nại</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        table td, table th {
            text-align: center;
            vertical-align: middle;
        }
        .modal-dialog {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4 text-center">Quản lý khiếu nại</h2>

    <div class="d-flex mb-3 justify-content-end">
        <label for="statusFilter" class="form-label" style="padding-top: 9px; margin-right: 9px;">Lọc theo trạng thái:</label>
        <select id="statusFilter" class="form-select" style="width: 150px;">
            <option value="">Tất cả</option>
            <option value="Đã xử lý">Đã xử lý</option>
            <option value="Chờ xử lý">Chờ xử lý</option>
        </select>
    </div>

    <table id="complaintsTable" class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã khiếu nại</th>
            <th>Mã đơn hàng</th>
            <th>Nội dung</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="complaint" items="${complaintList}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>KN${complaint.complaint_id}</td>
                <td>DH${complaint.order_id}</td>
                <td>${complaint.complaint_content}</td>
                <td>
                    <span class="badge ${complaint.complaint_status ? 'bg-success' : 'bg-danger'}">
                            ${complaint.complaint_status ? 'Đã xử lý' : 'Chờ xử lý'}
                    </span>
                </td>
                <td>
                    <button class="btn btn-primary btn-sm handle-btn" data-id="${complaint.complaint_id}" ${complaint.complaint_status ? 'disabled' : ''}>
                        <i class="fas fa-check"></i>
                    </button>
                    <button class="btn btn-info btn-sm detail-btn" onclick="complaint('${complaint.order_id}')">
                        <i class="fas fa-info-circle"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="handleComplaintModal" tabindex="-1" aria-labelledby="handleComplaintModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="handleComplaintModalLabel">Xử lý khiếu nại</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="complaintForm">
                    <input type="hidden" id="complaintId" value="">
                    <div class="mb-3">
                        <label for="feedback" class="form-label">Phản hồi</label>
                        <textarea class="form-control" id="feedback" rows="3" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" id="submitFeedback">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        let table = $('#complaintsTable').DataTable({
            "language": {
                "lengthMenu": "Hiển thị _MENU_ mục",
                "zeroRecords": "Không tìm thấy dữ liệu",
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ mục",
                "infoEmpty": "Không có dữ liệu",
                "infoFiltered": "(lọc từ _MAX_ tổng số mục)",
                "search": "Tìm kiếm:",
                "paginate": {
                    "first": "Đầu",
                    "last": "Cuối",
                    "next": "Tiếp",
                    "previous": "Trước"
                }
            }
        });

        $('#statusFilter').on('change', function () {
            let selectedValue = $(this).val();
            table.column(4).search(selectedValue).draw();
        });

        $('.handle-btn').on('click', function () {
            let complaintId = $(this).data('id');
            $('#complaintId').val(complaintId);
            $('#feedback').val('');
            $('#handleComplaintModal').modal('show');
        });

        $('#submitFeedback').on('click', function () {
            let complaintId = $('#complaintId').val();
            let feedback = $('#feedback').val().trim();
            if (feedback === '') {
                Swal.fire("Lỗi", "Vui lòng nhập phản hồi!", "error");
                return;
            }

            $.post("manageComplaint", {action: "feedback", orderId: complaintId, feedback: feedback}, function (response) {
                Swal.fire("Thành công", "Phản hồi đã được gửi!", "success");
                let row = $('.handle-btn[data-id="' + complaintId + '"]').closest('tr');
                row.find('.badge').removeClass('bg-danger').addClass('bg-success').text('Đã xử lý');
                $('.handle-btn[data-id="' + complaintId + '"]').prop('disabled', true);
                $('#handleComplaintModal').modal('hide');
            });
        });
    });

    function complaint(orderId){
        window.location.href = "/manageComplaint?action=showComplaintDetail&orderId=" + orderId;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
