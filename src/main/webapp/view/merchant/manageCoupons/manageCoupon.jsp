<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container my-4">
    <h2 class="text-center mb-4">Quản lý mã giảm giá</h2>
    <div class="row mb-3">
        <div class="col-md-3">
            <a href="/manageCoupons?action=addCouponForm" class="btn btn-success w-100">
                <i class="fas fa-plus"></i> Thêm mã giảm giá
            </a>
        </div>
        <div class="col-md-6">
            <form action="/manageVouchers?action=searchVouchers" method="post" id="searchForm">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Tìm kiếm mã giảm giá" name="keyword"
                           onkeyup="startTimer()">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover" id="voucherTable">
            <thead>
            <tr>
                <th>#1</th>
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
                        <div class="action-buttons d-inline-flex">
                            <a href="#" class="btn btn-primary btn-sm" title="Chỉnh sửa">
                                <i class="fas fa-pencil-alt"></i>
                            </a>
                            <a href="/manageCoupons?action=addCouponForm" class="btn btn-secondary btn-sm"
                               title="Chi tiết">
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
</body>
</html>
