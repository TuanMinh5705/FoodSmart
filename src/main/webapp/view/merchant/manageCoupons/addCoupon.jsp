<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm Voucher</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h2 class="mb-4 text-center">Thêm Voucher</h2>
            <div class="card shadow">
                <div class="card-body">
                    <form action="/manageCoupons?action=addCoupon" method="post" >
                        <!-- Trường store_id (ẩn) -->
                        <input type="hidden" name="store_id" value="${store_id}">

                        <!-- Mã Voucher -->
                        <div class="mb-3">
                            <label for="coupon_code" class="form-label"><i class="fas fa-barcode"></i> Mã Voucher</label>
                            <input type="text" class="form-control" id="coupon_code" name="coupon_code"
                                   placeholder="Nhập mã voucher" pattern="^[A-Za-z][0-9]{4,10}$"
                                   title="Mã voucher phải bắt đầu bằng một chữ cái và theo sau là từ 4 đến 10 chữ số. Ví dụ: A0001"
                                   required>
                            <span id="voucher_error" class="text-danger mt-2"></span>
                        </div>

                        <!-- Kiểm tra mã trùng lặp -->
                        <c:if test="${not empty couponList}">
                            <script>
                                const existingCoupons = [
                                    <c:forEach var="coupon" items="${couponList}">
                                    "${coupon.coupon_code}",
                                    </c:forEach>
                                ];

                                document.getElementById('coupon_code').addEventListener('input', function() {
                                    const couponCode = this.value.trim();
                                    const voucherError = document.getElementById('voucher_error');

                                    if (existingCoupons.includes(couponCode)) {
                                        voucherError.textContent = 'Mã voucher đã tồn tại.';
                                    } else {
                                        voucherError.textContent = '';
                                    }
                                });
                            </script>
                        </c:if>

                        <!-- Giá trị giảm giá -->
                        <div class="mb-3">
                            <label for="discount_value" class="form-label"><i class="fas fa-percent"></i> Giá trị giảm giá</label>
                            <input type="number" class="form-control" id="discount_value" name="discount_value"
                                   placeholder="Nhập giá trị giảm giá" min="1" max="99" required>
                        </div>

                        <!-- Ngày bắt đầu -->
                        <div class="mb-3">
                            <label for="start_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày bắt đầu</label>
                            <input type="date" class="form-control" id="start_date" name="start_date" required>
                        </div>

                        <!-- Ngày kết thúc -->
                        <div class="mb-3">
                            <label for="end_date" class="form-label"><i class="fas fa-calendar-alt"></i> Ngày kết thúc</label>
                            <input type="date" class="form-control" id="end_date" name="end_date" required>
                        </div>

                        <!-- Thời gian bắt đầu -->
                        <div class="mb-3">
                            <label for="start_time" class="form-label"><i class="fas fa-clock"></i> Thời gian bắt đầu</label>
                            <input type="time" class="form-control" id="start_time" name="start_time" required>
                        </div>

                        <!-- Thời gian kết thúc -->
                        <div class="mb-3">
                            <label for="end_time" class="form-label"><i class="fas fa-clock"></i> Thời gian kết thúc</label>
                            <input type="time" class="form-control" id="end_time" name="end_time" required>
                        </div>

                        <!-- Số lượng -->
                        <div class="mb-3">
                            <label for="quantity" class="form-label"><i class="fas fa-cogs"></i> Số lượng</label>
                            <input type="number" class="form-control" id="quantity" name="quantity"
                                   placeholder="Nhập số lượng voucher" min="1" required>
                        </div>

                        <!-- Mô tả -->
                        <div class="mb-3">
                            <label for="description" class="form-label"><i class="fas fa-info-circle"></i> Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3"
                                      placeholder="Nhập mô tả voucher"></textarea>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Thêm Voucher
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
