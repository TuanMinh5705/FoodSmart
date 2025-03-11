<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý mã giảm giá</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <style>
        .dataTables_filter {
            display: none;
        }
        .dataTables_paginate .paginate_button {
            background: #007bff;
            color: white !important;
            border-radius: 5px;
            padding: 5px 10px;
            margin: 2px;
        }

        .dataTables_paginate .paginate_button:hover {
            background: #0056b3;
        }
        :root {
            --bg-light: #f5f7fa;
            --bg-dark: #c3cfe2;
        }
        body {
            background: linear-gradient(135deg, var(--bg-light), var(--bg-dark));
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .custom-container {
            max-width: 800px;
            margin: auto;
            padding: 2rem 1rem;
        }
        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            background: #fff;
            animation: fadeInUp 1s ease;
            margin-bottom: 2rem;
        }
        .card-header {
            background: transparent;
            color: #000;
            text-align: center;
            padding: 1.8rem;
            font-size: 2rem;
            font-weight: 700;
            position: relative;
        }
        .card-header::after {
            display: none;
        }
        .card-body {
            padding: 2rem;
        }
        .btn-sm {
            padding: 0.35rem 0.75rem !important;
            font-size: 0.85rem !important;
            border-radius: 25px !important;
        }
        /* Các style chung cho button (đồng bộ giao diện) */
        .btn-custom {
            border: none !important;
            border-radius: 50px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s, background 0.3s;
            color: #fff;
        }
        /* Màu sắc cho các button */
        .btn-primary, .btn-secondary {
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
        }
        .btn-primary:hover, .btn-secondary:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #1E88E5, #2a9ffc);
            box-shadow: none;
        }
        .btn-upload {
            background: linear-gradient(90deg, #2ecc71, #2dc26c);
        }
        .btn-upload:hover {
            transform: translateY(-3px);
            background: linear-gradient(90deg, #2dc26c, #2ecc71);
            box-shadow: none;
        }
        .input-with-icon input {
            padding-right: 40px;
            border-radius: 50px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .input-with-icon input:focus {
            border-color: #1E88E5;
            box-shadow: 0 0 8px rgba(30, 136, 229, 0.5);
        }
        .input-with-icon .fa-search {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            transition: color 0.3s;
        }
        .input-with-icon .fa-search:hover {
            color: #495057;
        }
        /* Đồng bộ table header */
        .table thead {
            background: linear-gradient(90deg, #2a9ffc, #1E88E5);
            color: #fff;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        /* Hover effect: Khi trỏ chuột vào nút chi tiết, icon chuyển màu đen */
        .btn-secondary:hover i {
            color: #000;
        }
    </style>
</head>
<body>
<div class="container my-4 custom-container">
    <div class="card">
        <div class="card-header">
            Quản lý mã giảm giá
        </div>
        <div class="card-body">
            <div class="row mb-4">
                <div class="col-md-4 mb-3 mb-md-0">
                    <a href="/manageCoupons?action=addCouponForm" class="btn btn-custom btn-upload btn-sm">
                        <i class="fas fa-plus me-2"></i> Thêm mã giảm giá
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="col-md-6 text-end">
                        <input type="text" id="customSearchBox" class="form-control custom-search-box" placeholder="🔍 Tìm kiếm...">
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" id="voucherTable">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã giảm giá</th>
                        <th>Giá trị (%)</th>
                        <th>Số lượng</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="coupon" items="${couponList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${coupon.coupon_code}</td>
                            <td>${coupon.discount_value}%</td>
                            <td>${coupon.quantity}</td>
                            <td>
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="/manageCoupons?action=editCouponForm&coupon_id=${coupon.coupon_id}" class="btn btn-custom btn-upload btn-sm" title="Chỉnh sửa">
                                        <i class="fas fa-pencil-alt"></i>
                                    </a>
                                    <a href="/manageCoupons?action=infoCouponForm&coupon_id=${coupon.coupon_id}" class="btn btn-custom btn-secondary btn-sm" title="Chi tiết">
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
    </div>
</div>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let timer;
    function startTimer() {
        clearTimeout(timer);
        timer = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2500);
    }
    $(document).ready(function () {
        const table = $('#voucherTable').DataTable({
            "language": {
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ món ăn",
                "info": "Hiển thị _START_ đến _END_ của _TOTAL_ món ăn",
                "infoEmpty": "Không có dữ liệu",
                "infoFiltered": "(lọc từ _MAX_ món ăn)",
                "zeroRecords": "Không tìm thấy kết quả nào phù hợp",
                "emptyTable": "Không có dữ liệu trong bảng",
                "paginate": {
                    "first": "Đầu",
                    "last": "Cuối",
                    "next": "Tiếp",
                    "previous": "Trước"
                },
                "loadingRecords": "Đang tải...",
                "processing": "Đang xử lý...",
            }
        });

        $('#customSearchBox').on('keyup', function () {
            table.search(this.value).draw();
        });
    });
</script>
</body>
</html>
