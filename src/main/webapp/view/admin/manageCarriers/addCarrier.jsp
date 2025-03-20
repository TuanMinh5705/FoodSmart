<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm đối tác vận chuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="bi bi-plus-circle-fill"></i> Thêm đối tác vận chuyển
    </h2>

    <div class="card shadow p-4">
        <form action="manageCarriers?action=addCarrier" method="post">
            <div class="mb-3">
                <label class="form-label">Tên đối tác</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-truck"></i></span>
                    <input type="text" class="form-control" name="name" placeholder="Nhập tên đối tác" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                    <input type="text" class="form-control" name="phone" placeholder="Nhập số điện thoại"
                           pattern="0[0-9]{9}" title="Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Chi phí vận chuyển (VNĐ)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-currency-exchange"></i></span>
                    <input type="number" class="form-control" name="cost" placeholder="Nhập chi phí"
                           min="1000" step="1000" required>
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-check-circle"></i> Thêm đối tác
                </button>
                <a href="manageCarriers" class="btn btn-danger">
                    <i class="bi bi-x-circle"></i> Hủy
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
