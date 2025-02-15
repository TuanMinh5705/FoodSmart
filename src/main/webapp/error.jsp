<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - Có vấn đề xảy ra</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            text-align: center;
            padding: 50px 20px;
        }
        .error-box {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            margin: auto;
            display: inline-block;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .error-title {
            font-size: 36px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        .error-message {
            font-size: 18px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="error-box">
        <div class="error-title">500 - Lỗi nội bộ máy chủ</div>
        <div class="error-message">
            Rất tiếc, đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn.
        </div>
    </div>
</div>
</body>
</html>
