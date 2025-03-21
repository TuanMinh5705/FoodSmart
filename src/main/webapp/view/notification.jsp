<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thông báo</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }
        .notification-container { max-width: 600px; margin: auto; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .notification-item { padding: 10px; border-bottom: 1px solid #ddd; }
        .notification-item:last-child { border-bottom: none; }
        .notification-time { font-size: 12px; color: gray; }
        .unread { font-weight: bold; color: red; }
    </style>
</head>
<body>
<div class="notification-container">
    <h2>Thông báo</h2>
    <c:if test="${empty notifications}">
        <p>Không có thông báo nào.</p>
    </c:if>
    <c:forEach items="${notifications}" var="notification">
        <div class="notification-item ${notification.status ? '' : 'unread'}">
            <p>${notification.message}</p>
            <span class="notification-time">${notification.createAt}</span>
        </div>
    </c:forEach>
</div>
</body>
</html>
