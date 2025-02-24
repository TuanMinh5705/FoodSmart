<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý cửa hàng</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .table th, .table td {
            vertical-align: middle;
        }
        .swal2-popup {
            font-size: 10px;
        }
    </style>
</head>

<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center mb-4 text-primary">Quản lý cửa hàng</h2>

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

    <!-- Thanh công cụ: Lọc, Tìm kiếm, Thêm cửa hàng -->
    <div class="d-flex justify-content-between align-items-center mb-3">

        <!-- Bộ lọc trạng thái -->
        <form method="get" action="/manageMerchants" id="filterForm" class="d-flex align-items-center me-2">
            <input type="hidden" name="status" id="status">
            <button type="button" class="btn btn-outline-secondary dropdown-toggle" id="filterDropdown"
                    data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-filter"></i> Lọc trạng thái
            </button>
            <ul class="dropdown-menu" aria-labelledby="filterDropdown">
                <li><a class="dropdown-item" href="#" onclick="setStatusFilter('')">Tất cả</a></li>
                <li><a class="dropdown-item" href="#" onclick="setStatusFilter('active')">Hoạt động</a></li>
                <li><a class="dropdown-item" href="#" onclick="setStatusFilter('locked')">Khóa tài khoản</a></li>
            </ul>
        </form>

        <!-- Form tìm kiếm -->
        <form method="post" action="/manageMerchants?action=searchWithNameMerchant" id="searchForm"
              class="d-flex me-2">
            <input name="keyword" type="text" class="form-control me-2" placeholder="Tìm kiếm..."
                   value="${searchKeyword}" oninput="startTimer()">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-search"></i>
            </button>
        </form>

        <!-- Nút thêm cửa hàng -->
        <a href="/manageMerchants?action=addMerchantForm" class="btn btn-success">
            <i class="bi bi-plus-circle"></i> Thêm cửa hàng
        </a>
    </div>

    <!-- Bảng danh sách cửa hàng -->
    <div class="card shadow rounded">
        <div class="card-body">
            <table class="table table-hover table-bordered table-striped text-center align-middle">
                <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Ảnh đại diện</th>
                    <th>Tên cửa hàng</th>
                    <th>Địa chỉ</th>
                    <th>Số điện thoại</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty merchantsList}">
                        <tr>
                            <td colspan="6" class="text-danger fw-bold">Không có kết quả nào được tìm thấy!</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="merchant" items="${merchantsList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${merchant.avt_path}"
                                         alt="avatar" class="rounded-circle"
                                         style="width: 50px; height: 50px; object-fit: cover;">
                                </td>
                                <td>${merchant.store_name}</td>
                                <td>${merchant.store_address}</td>
                                <td>${merchant.contact_number}</td>
                                <td>
                                    <a href="/manageMerchants?action=updateMerchantForm&store_id=${merchant.store_id}"
                                       class="btn btn-warning btn-sm">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a>
                                    <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}"
                                       class="btn btn-info btn-sm">
                                        <i class="bi bi-info-circle"></i> Chi tiết
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
    // Tự động gửi form tìm kiếm sau 2 giây
    let searchTimeout;
    function startTimer() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2000);
    }

    // Gửi form lọc theo trạng thái
    function submitForm() {
        document.getElementById("filterForm").submit();
    }

    function setStatusFilter(statusValue) {
        document.getElementById("status").value = statusValue;
        submitForm();
    }
</script>

</body>

</html>
