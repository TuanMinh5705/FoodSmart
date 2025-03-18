<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Voucher</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h2 class="mb-4 text-center"><i class="bi bi-plus-circle-fill"></i> Thêm mã giảm giá</h2>

            <div class="card shadow">
                <div class="card-body">
                    <form action="/manageVouchers?action=addVoucher" method="post" id="voucherForm">
                        <div class="mb-3">
                            <label for="voucher_code" class="form-label"><i class="fas fa-barcode"></i> Mã Voucher</label>
                            <input type="text" class="form-control" id="voucher_code" name="voucher_code"
                                   placeholder="Nhập mã voucher" pattern="^[A-Za-z][0-9]{4,10}$"
                                   title="Mã voucher phải bắt đầu bằng một chữ cái và theo sau là từ 4 đến 10 chữ số. Ví dụ: A0001"
                                   required>
                            <span id="voucher_error" class="text-danger mt-2"></span>
                        </div>

                        <c:if test="${not empty voucherList}">
                            <script>
                                const existingVouchers = [
                                    <c:forEach var="voucher" items="${voucherList}">
                                    "${voucher.voucher_code}",
                                    </c:forEach>
                                ];

                                document.getElementById('voucher_code').addEventListener('input', function() {
                                    const voucherCode = this.value.trim();
                                    const voucherError = document.getElementById('voucher_error');

                                    if (existingVouchers.includes(voucherCode)) {
                                        voucherError.textContent = 'Mã voucher đã tồn tại.';
                                    } else {
                                        voucherError.textContent = '';
                                    }
                                });
                            </script>
                        </c:if>

                        <div class="mb-3">
                            <label for="discount_value" class="form-label"><i class="fas fa-percent"></i> Giá trị giảm giá</label>
                            <input type="number" class="form-control" id="discount_value" name="discount_value"
                                   placeholder="Nhập giá trị giảm giá" min="1" max="99" required>
                        </div>

                        <div class="mb-3">
                            <label for="start_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu</label>
                            <input type="date" class="form-control" id="start_date" name="start_date" required>
                        </div>

                        <div class="mb-3">
                            <label for="end_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày kết thúc</label>
                            <input type="date" class="form-control" id="end_date" name="end_date" required>
                        </div>

                        <div class="mb-3">
                            <label for="start_time" class="form-label"><i class="fas fa-clock"></i> Thời gian bắt đầu</label>
                            <input type="time" class="form-control" id="start_time" name="start_time" required>
                        </div>

                        <div class="mb-3">
                            <label for="end_time" class="form-label"><i class="fas fa-clock"></i> Thời gian kết thúc</label>
                            <input type="time" class="form-control" id="end_time" name="end_time" required>
                        </div>

                        <div class="mb-3">
                            <label for="quantity" class="form-label"><i class="fas fa-cogs"></i> Số lượng</label>
                            <input type="number" class="form-control" id="quantity" name="quantity"
                                   placeholder="Nhập số lượng voucher" min="1" required>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label"><i class="fas fa-info-circle"></i> Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3"
                                      placeholder="Nhập mô tả voucher"></textarea>
                        </div>

                        <div class="d-flex justify-content-center gap-3 mt-3">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-circle"></i> Thêm Voucher
                            </button>
                            <a href="/manageVouchers" class="btn btn-danger">
                                <i class="bi bi-x-circle"></i> Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    document.getElementById('voucherForm').addEventListener('submit', function(event) {
        const start_date = new Date(document.getElementById('start_date').value);
        const end_date = new Date(document.getElementById('end_date').value);
        const start_time = document.getElementById('start_time').value.split(':');
        const end_time = document.getElementById('end_time').value.split(':');

        if (end_date < start_date) {
            alert("Ngày kết thúc phải sau ngày bắt đầu.");
            event.preventDefault();
            return;
        }

        if (start_date.toDateString() === end_date.toDateString()) {
            if (parseInt(end_time[0]) < parseInt(start_time[0]) ||
                (parseInt(end_time[0]) === parseInt(start_time[0]) && parseInt(end_time[1]) <= parseInt(start_time[1]))) {
                alert("Thời gian kết thúc phải sau thời gian bắt đầu.");
                event.preventDefault();
                return;
            }
        }
    });
</script>
</body>
</html>
