<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/manageStore?action=editMerchantStore" method="post" enctype="multipart/form-data">
    <input type="hidden" value="${store.store_id}" name="store_id">
    <label>Tên cửa hàng :</label>
    <input type="text" name="store_name" value="${store.store_name}"/><br>
    <label>Địa chỉ</label>
    <input type="text" name="store_address" value="${store.store_address}"/><br>
    <label>SDT</label>
    <input type="text" name="contact_number" value="${store.contact_number}"/><br>
    <!-- Banner -->
    <label class="form-label"><i class="fas fa-image"></i> Banner</label>
    <div class="mb-3 text-center">
        <div class="mb-2">
            <!-- Thêm id="bannerPreview" để update ảnh -->
            <img id="bannerPreview" src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.banner_path}" alt="banner" class="img-fluid rounded shadow"
                 style="max-width: 250px;">
        </div>
        <input type="hidden" value="${store.banner_path}" name="current_banner_path">
        <div class="custom-file">
            <input type="file" class="custom-file-input" id="banner_path" name="banner_path"
                   style="max-width: 400px;">
            <label class="custom-file-label" for="banner_path">${store.banner_path}</label>
        </div>
    </div>

    <!-- Avatar -->
    <label class="form-label"><i class="fas fa-user-circle"></i> Avatar</label>
    <div class="mb-3 text-center">
        <div class="mb-2">
            <!-- Thêm id="avtPreview" để update ảnh -->
            <img id="avtPreview" src="${pageContext.request.contextPath}/foodSmartImages/avatars/${store.avt_path}" alt="avatar"
                 class="img-fluid rounded-circle shadow" style="max-width: 120px;">
        </div>
        <input type="hidden" value="${store.avt_path}" name="current_avt_path">
        <div class="custom-file">
            <input type="file" class="custom-file-input" id="avt_path" name="avt_path"
                   style="max-width: 400px;">
            <label class="custom-file-label" for="avt_path">${store.avt_path}</label>
        </div>
    </div>
    <label>Trạng thái</label>
    <input type="checkbox" name="store_type" value="true"
           <c:if test="${store.store_type}">checked</c:if> /><br>
    <input type="submit" name="action" value="Cập nhật">
</form>

</body>
</html>
