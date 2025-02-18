<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <button>danh sach dang ki</button>
    <form method="get" action="/manageMerchants" id="filterForm">
        <label for="status">Trạng thái:</label>
        <select name="status" id="status" onchange="submitForm()">
            <option value="">Tất cả</option>
            <option value="active" ${status == 'active' ? 'selected' : ''}>Hoạt động</option>
            <option value="locked" ${status == 'locked' ? 'selected' : ''}>Khóa tài khoản</option>
        </select>
    </form>







    <form method="post" action="/manageMerchants?action=searchWithNameMerchant" id="searchForm">
        <input name="keyword" type="text" placeholder="Search" value="${searchKeyword}" oninput="startTimer()">
        <button type="submit">Search</button>
    </form>


</div>
<div>
    <table border="1">
        <tr>
            <td>#</td>
            <td>Tên cửa hàng</td>
            <td>Địa chỉ</td>
            <td>Số điện thoại</td>
            <td>Hành động</td>
        </tr>
        <c:forEach var="merchant" items="${merchantsList}" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${merchant.store_name}</td>
                <td>${merchant.store_address}</td>
                <td>${merchant.contact_number}</td>
                <td>
                    <a href="/manageMerchants?action=addMerchantForm" class="btn btn-danger btn-sm">Add</a>
                    <a href="/manageMerchants?action=updateMerchantForm&store_id=${merchant.store_id}"
                       class="btn btn-danger btn-sm">Sửa</a>
                    <a href="/manageMerchants?action=detail&store_id=${merchant.store_id}"
                       class="btn btn-danger btn-sm">Chi tiết</a>
                </td>

            </tr>
        </c:forEach>

    </table>
</div>

<script>
    let searchTimeout

    function startTimer() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function () {
            document.getElementById("searchForm").submit();
        }, 2000);
    }
    function submitForm() {
        document.getElementById("filterForm").submit();
    }
</script>


</body>
</html>
