<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar">
    <h4 class="text-center text-primary mb-4">Tài khoản</h4>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a href="/userInformation?action=showUserInformation" class="nav-link">
                <i class="fas fa-user-circle"></i> Thông tin tài khoản
            </a>
        </li>
        <li class="nav-item">
            <a href="/userInformation?action=showAddressUser" class="nav-link">
                <i class="fas fa-map-marker-alt"></i> Địa chỉ giao hàng
            </a>
        </li>
        <li class="nav-item">
            <a href="/userInformation" class="nav-link">
                <i class="fas fa-wallet"></i> Ví điện tử
            </a>
        </li>
        <li class="nav-item">
            <a href="/authenticate?action=logout" class="nav-link text-danger">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>
