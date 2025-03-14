<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý cửa hàng</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            vertical-align: middle;
        }
        /* Cải tiến giao diện cho input tìm kiếm có icon */
        .input-with-icon {
            position: relative;
        }
        .input-with-icon input {
            padding-right: 40px;
        }
        .input-with-icon i {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #007bff;
            transition: color 0.3s;
        }
        .input-with-icon i:hover {
            color: #0056b3;
        }
        /* Tăng kích thước font cho SweetAlert2 */
        .swal2-popup {
            font-size: 1rem;
        }
    </style>
</head>

<body>
<div class="container mt-4">
    <h2 class="text-center mb-4 fw-bold">Quản lý cửa hàng</h2>

    <!-- Alert thông báo thành công hoặc lỗi -->
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

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-3">
        <!-- Search Form -->
        <form method="post" action="/manageMerchants?action=searchWithNameMerchant" id="searchForm" class="mb-2 mb-md-0">
            <div class="input-with-icon">
                <input name="keyword" type="text" class="form-control" placeholder="Tìm kiếm..."
                       value="${searchKeyword}" onkeyup="startTimer()">
                <i class="fas fa-search" title="Tìm kiếm" onclick="document.getElementById('searchForm').submit();"></i>
            </div>
        </form>

        <!-- Filter Form -->
        <form method="get" action="/manageMerchants" id="filterForm" class="d-flex align-items-center">
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
    </div>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-bordered table-striped text-center align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>STT</th>
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
                                        <img src="${pageContext.request.contextPath}/images/avatars/${merchant.avt_path}"
                                             alt="avatar" class="rounded-circle"
                                             style="width: 50px; height: 50px; object-fit: cover;">
                                    </td>
                                    <td>${merchant.store_name}</td>
                                    <td>${merchant.store_address}</td>
                                    <td>${merchant.contact_number}</td>
                                    <td>
                                        <a href="/manageMerchants?action=updateMerchantForm&store_id=${merchant.store_id}" class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}" class="btn btn-info btn-sm" title="Chi tiết">
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
</div>

<script>
    let searchTimeout;
    function startTimer() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2000);
    }

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
