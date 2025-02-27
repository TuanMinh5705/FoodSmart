<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Thêm FontAwesome để sử dụng icon -->
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
        .table img.rounded-circle {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
        .action-buttons .btn {
            margin-right: 0.5rem;
        }
        .action-buttons .btn:last-child {
            margin-right: 0;
        }
        /* Giữ lại style cho Swal */
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
    <h2 class="text-center mb-4 font-weight-bold">Quản lý người dùng</h2>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <a href="/manageUsers?action=showAddAccountForm" class="btn btn-success">
            <i class="bi bi-plus-circle"></i> Thêm người dùng mới
        </a>
        <form action="/manageUsers?action=searchWithName" id="searchForm" method="post" class="w-50">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm..." name="keyword" onkeyup="startTimer()">
                <button class="btn btn-primary" type="submit" title="Tìm kiếm">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>
        <div class="d-flex align-items-center">
            <label for="roleFilter" class="mb-0 me-2" style="width: 80px">Vai trò:</label>
            <select class="form-control" id="roleFilter">
                <option value="all">Tất cả</option>
                <option value="Admin">Quản trị viên</option>
                <option value="Merchant">Chủ cửa hàng</option>
                <option value="User">Người dùng</option>
            </select>
        </div>
    </div>

    <div class="card shadow rounded">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Ảnh đại diện</th>
                        <th>Tên đăng nhập</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="account" items="${accountList}" varStatus="status">
                        <tr data-role="${account.role}">
                            <td>${status.index + 1}</td>
                            <td>
                                <img src="${pageContext.request.contextPath}/foodSmartImages/avatars/${account.avtPath}"
                                     alt="Avatar" class="rounded-circle">
                            </td>
                            <td>${account.username}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${account.role eq 'Admin'}">Quản trị viên</c:when>
                                    <c:when test="${account.role eq 'Merchant'}">Chủ cửa hàng</c:when>
                                    <c:when test="${account.role eq 'User'}">Người dùng</c:when>
                                    <c:otherwise>Chưa xác định</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${account.active}">
                                        <i class="fas fa-check-circle" style="color: green;" title="Đang hoạt động"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-times-circle" style="color: red;" title="Đã bị khóa"></i>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="action-buttons d-inline-flex">
                                    <a href="/manageUsers?action=editForm&accountID=${account.accountID}"
                                       class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="/manageUsers?action=showInfoForm&accountID=${account.accountID}"
                                       class="btn btn-info btn-sm" title="Chi tiết">
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
    // Bộ lọc theo vai trò
    document.getElementById("roleFilter").addEventListener("change", function () {
        let selectedRole = this.value;
        let rows = document.querySelectorAll("tbody tr");
        rows.forEach(row => {
            let role = row.getAttribute("data-role");
            row.style.display = (selectedRole === "all" || role === selectedRole) ? "" : "none";
        });
    });

    // Tự động submit form tìm kiếm sau 2000ms
    let timer;
    function startTimer() {
        clearTimeout(timer);
        timer = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2000);
    }
</script>
</body>
</html>
