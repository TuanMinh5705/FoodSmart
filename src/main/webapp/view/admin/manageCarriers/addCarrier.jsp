<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm đối tác vận chuyển</title>
    <!-- Thêm Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Thêm đối tác vận chuyển</h4>
        </div>
        <div class="card-body">
            <form action="manageCarriers?action=addCarrier" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên đối tác</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên đối tác" required>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại"
                           pattern="0[0-9]{9}" title="Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0" required>
                </div>

                <div class="mb-3">
                    <label for="cost" class="form-label">Chi phí vận chuyển (VNĐ)</label>
                    <input type="number" class="form-control" id="cost" name="cost" placeholder="Nhập chi phí"
                           min="1000" step="1000" required>
                </div>

                <div class="d-flex justify-content-center gap-2">
                    <a href="manageCarriers" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-success">Thêm mới</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
