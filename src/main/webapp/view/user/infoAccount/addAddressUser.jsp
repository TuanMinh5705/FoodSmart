<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>Thêm địa chỉ giao hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body>

<div class="container mt-4" style="margin: 0">
    <div class="row">
        <div class="col-md-3 d-none d-md-block">
            <jsp:include page="sidebarUser.jsp" />
        </div>

        <div class="col-md-9"  style="padding-left: 230px ; margin-top: 110px "  >
            <div class="card shadow-sm p-4">
                <h3 class="text-center mb-4">Thêm Địa Chỉ Giao Hàng</h3>
                <form action="/userInformation?action=addAddress" method="post">
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ:</label>
                        <input type="text" name="address" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại:</label>
                        <input type="number" name="phonenumber" class="form-control" required>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" name="isDefault" id="isDefault">
                        <label class="form-check-label" for="isDefault">Đặt làm địa chỉ mặc định</label>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Thêm Địa Chỉ</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>