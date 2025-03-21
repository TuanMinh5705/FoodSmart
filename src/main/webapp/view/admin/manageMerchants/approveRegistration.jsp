<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Duyệt Đăng Ký Cửa Hàng</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .table th, .table td { vertical-align: middle; }
        .swal2-popup { font-size: 10px; }
    </style>
</head>

<body class="bg-light">
<div class="container mt-4">
    <h2 class="text-center mb-4 fw-bold">Duyệt Đăng Ký Cửa Hàng</h2>

    <script>
        <c:if test="${not empty success}">
        Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: '${success}',
            showConfirmButton: false,
            timer: 2000,
            width: '400px'
        });
        <% session.removeAttribute("success"); %>
        </c:if>

        <c:if test="${not empty error}">
        Swal.fire({
            position: 'top-end',
            icon: 'error',
            title: '${error}',
            showConfirmButton: false,
            timer: 2000,
            width: '400px'
        });
        <% session.removeAttribute("error"); %>
        </c:if>
    </script>

    <div class="card shadow rounded">
        <div class="card-body">
            <table class="table table-hover table-bordered text-center align-middle">
                <thead class="table-dark">
                <tr>
                    <th>STT</th>
                    <th>Ảnh đại diện</th>
                    <th>Tên cửa hàng</th>
                    <th>Địa chỉ</th>
                    <th>Số điện thoại</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty merchants}">
                        <tr>
                            <td colspan="7" class="text-danger fw-bold">Không có cửa hàng nào chờ duyệt!</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="merchant" items="${merchants}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/images/avatars/${merchant.avt_path}"
                                         alt="avatar" class="rounded-circle" style="width: 50px; height: 50px; object-fit: cover;">
                                </td>
                                <td>${merchant.store_name}</td>
                                <td>${merchant.store_address}</td>
                                <td>${merchant.contact_number}</td>
                                <td>
                                    <form id="approveForm${merchant.store_id}" method="post" action="/manageMerchants">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="store_id" value="${merchant.store_id}">
                                    </form>
                                    <form id="rejectForm${merchant.store_id}" method="post" action="/manageMerchants">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="store_id" value="${merchant.store_id}">
                                    </form>
                                    <button class="btn btn-success btn-sm" title="Duyệt" onclick="confirmAction('approve', ${merchant.store_id})">
                                        Duyệt
                                    </button>
                                    <button class="btn btn-danger btn-sm" title="Từ chối" onclick="confirmAction('reject', ${merchant.store_id})">
                                        Từ chối
                                    </button>
                                </td>
                                <td>
                                    <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}" class="btn btn-info btn-sm" title="Xem chi tiết">
                                        <i class="bi bi-info-circle"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function confirmAction(action, storeId) {
        Swal.fire({
            title: action === 'approve' ? 'Xác nhận duyệt cửa hàng?' : 'Xác nhận từ chối cửa hàng?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: action === 'approve' ? '#28a745' : '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Xác nhận',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(action + 'Form' + storeId).submit();
            }
        });
    }
</script>

</body>
</html>
