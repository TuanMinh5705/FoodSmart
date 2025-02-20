<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
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
            width: 80px;
            height: 80px;
            object-fit: cover;
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
    <h2 class="text-center mb-4">Quản lý người dùng</h2>
    <div class="row mb-3 align-items-center">
        <div class="col-md-3">
            <a href="/manageUsers?action=showAddAccountForm" class="btn btn-success w-100">
                <i class="fas fa-user-plus"></i> Thêm người dùng mới
            </a>
        </div>

        <div class="col-md-6">
            <form action="/manageUsers?action=searchWithName" id="searchForm" method="post">
                <div class="input-group" style="display: flex; align-items: center;">
                    <input type="text" class="form-control" placeholder="Nhập từ khóa tìm kiếm" id="searchInput"
                           name="keyword" oninput="startTimer()"
                           style="height: 40px; border-top-right-radius: 0; border-bottom-right-radius: 0;">
                    <button class="btn btn-primary" type="submit" id="searchBtn"
                            style="height: 40px; border-top-left-radius: 0; border-bottom-left-radius: 0;">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
        </div>

        <div class="col-md-3">
            <div class="d-flex align-items-center">
                <label for="roleFilter" class="mb-0 mr-2" style="width: 80px">Vai trò:</label>
                <select class="form-control" id="roleFilter">
                    <option value="all">Tất cả</option>
                    <option value="Admin">Quản trị viên</option>
                    <option value="Merchant">Chủ cửa hàng</option>
                    <option value="User">Người dùng</option>
                </select>
            </div>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover">
            <thead>
            <tr>
                <th>#</th>
                <th>Ảnh đại diện</th>
                <th>Tên đăng nhập</th>
                <th>Mật khẩu</th>
                <th>Vai trò</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="account" items="${accountList}" varStatus="status">
                <tr data-role="${account.role}">
                    <td>${status.index + 1}</td>
                    <td>
                        <img src="/images/avatars/${account.avtPath}"
                             alt="Avatar"
                             class="rounded-circle">
                    </td>
                    <td>
                            ${account.username}
                        <c:choose>
                            <c:when test="${account.active}">
                                <i class="fas fa-check-circle" style="color: green;" title="Đang hoạt động"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-times-circle" style="color: red;" title="Đã bị khóa"></i>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>*******</td>
                    <td>
                        <c:choose>
                            <c:when test="${account.role eq 'Admin'}">Quản trị viên</c:when>
                            <c:when test="${account.role eq 'Merchant'}">Chủ cửa hàng</c:when>
                            <c:when test="${account.role eq 'User'}">Người dùng</c:when>
                            <c:otherwise>Chưa xác định</c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <div class="action-buttons d-inline-flex">
                            <a href="/manageUsers?action=editForm&accountID=${account.accountID}"
                               class="btn btn-primary btn-sm" title="Chỉnh sửa">
                                <i class="fas fa-pencil-alt"></i>
                            </a>

                            <a href="/manageUsers?action=showInfoForm&accountID=${account.accountID}"
                               class="btn btn-secondary btn-sm" title="Chi tiết">
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

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById("roleFilter").addEventListener("change", function () {
        let selectedRole = this.value;
        let rows = document.querySelectorAll("tbody tr");

        rows.forEach(row => {
            let role = row.getAttribute("data-role");
            if (selectedRole === "all" || role === selectedRole) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    });

    let timer;

    function startTimer() {
        clearTimeout(timer);

        timer = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 4500);
    }
</script>
</body>
</html>