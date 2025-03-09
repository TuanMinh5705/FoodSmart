<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: T14
  Date: 27/02/2025
  Time: 7:40 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="bg-white flex flex-wrap justify-around items-center">
    <c:forEach var="category" items="${categoryFoodList}">
        <a href="/homeUser?action=getFoodsByCategory&category_id=${category.category_id}">
            <div class="text-center space-y-2 mx-4">
                <img src="${pageContext.request.contextPath}/images/product/${category.avt_path}"
                     alt="${category.category_name}"
                     class="mx-auto w-[80px] h-[80px] object-fit object-contain">
                <p class="text-xl font-semibold">${category.category_name}</p>
            </div>
        </a>
    </c:forEach>
</div>
</body>
</html>
