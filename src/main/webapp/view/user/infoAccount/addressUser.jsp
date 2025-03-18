<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách địa chỉ giao hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome CSS (nếu cần icon) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            color: #333;
        }
        /* Tùy chỉnh card hiển thị địa chỉ */
        .address-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }
        .address-card .card-body {
            padding: 20px;
        }
        .default-badge {
            font-size: 0.85rem;
        }
        /* Nút hành động */
        .address-actions a,
        .address-actions button {
            margin-right: 10px;
        }
        /* Định dạng radio button */
        .form-check-input {
            cursor: pointer;
        }
        /* Tạo khoảng cách giữa Sidebar và nội dung chính */
        .content-wrapper {
            padding: 30px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar bên trái -->
        <div class="col-md-3 p-0">
            <jsp:include page="sidebarUser.jsp"/>
        </div>
        <!-- Nội dung chính bên phải -->
        <div class="col-md-9 content-wrapper">
            <h2 class="mb-4">Danh sách địa chỉ giao hàng</h2>
            <c:forEach var="accountDetail" items="${accountDetailsList}">
                <div class="card address-card">
                    <div class="card-body">
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="radio" name="defaultAddress"
                                   id="defaultAddress${accountDetail.accountDetailID}"
                                   value="${accountDetail.accountDetailID}"
                                   onchange="setDefaultAddress(${accountDetail.accountDetailID})"
                                ${accountDetail.isDefault ? 'checked' : ''}>
                            <label class="form-check-label" for="defaultAddress${accountDetail.accountDetailID}">
                                <strong>Địa chỉ:</strong> ${accountDetail.address}
                                <c:if test="${accountDetail.isDefault}">
                                    <span class="badge bg-primary default-badge ms-2">Địa chỉ mặc định</span>
                                </c:if>
                            </label>
                        </div>
                        <p class="mb-2"><strong>Số điện thoại:</strong> ${accountDetail.phonenumber}</p>
                        <div class="address-actions">
                            <a href="/userInformation?action=editAddressForm&amp;accountDetailID=${accountDetail.accountDetailID}"
                               class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-edit"></i> Chỉnh sửa
                            </a>
                            <button type="button" class="btn btn-danger btn-sm"
                                    onclick="showDeleteModal({ id: ${accountDetail.accountDetailID}, url: '/userInformation', action: 'deleteAddress' })">
                                <i class="fas fa-trash"></i> Xóa
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Modal xác nhận xóa (nếu có) -->
<jsp:include page="../../admin/system/modalConfirmDelete.jsp"/>

<!-- Bootstrap 5 JS Bundle (bao gồm Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hàm thiết lập địa chỉ mặc định
    function setDefaultAddress(accountDetailID) {
        fetch('/userInformation?action=setDefaultAddress', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'accountDetailID=' + accountDetailID
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert('Cập nhật địa chỉ mặc định thất bại!');
                }
            })
            .catch(error => console.error('Lỗi:', error));
    }
</script>
</body>
</html>
