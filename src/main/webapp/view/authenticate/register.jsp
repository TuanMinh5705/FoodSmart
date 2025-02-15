<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng kí</title>
</head>
<style>
    #suggestions {
        display: none;
        width: 800px;
        max-height: 200px;
        overflow-y: auto;
        border: 1px solid #ccc;
        background-color: #fff;
        position: absolute;
        z-index: 999;
    }

    #suggestions div {
        padding: 5px;
        cursor: pointer;
        border-bottom: 1px solid #ccc;
    }

    #suggestions div:hover {
        background-color: #eee;
    }

    .address-container {
        position: relative;
        display: inline-block;
    }
</style>
<body>
<h1>Đăng kí</h1>
<form action="/authenticate?action=register" method="POST" enctype="multipart/form-data">
    <div>
        <label for="avt_path">Ảnh đại diện:</label>
        <input type="file" id="avt_path" name="avt_path" accept="image/*">
    </div>
    <div>
        <label for="username">Tên đăng nhập:</label>
        <input id="username" name="username" type="text"
               pattern="[A-Za-z0-9]{3,}"
               placeholder="Nhập tên đăng nhập..."
               title="Tên đăng nhập phải có ít nhất 3 ký tự, chỉ chứa chữ cái và số"
               autofocus required>
    </div>
    <div>
        <label for="password">Mật khẩu:</label>
        <input id="password" type="password" name="password"
               pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$"
               placeholder="Nhập mật khẩu..."
               title="Mật khẩu phải có 6-12 ký tự, chứa ít nhất một chữ cái và một số"
               required>
    </div>
    <div>
        <label for="re_password">Nhập lại mật khẩu:</label>
        <input id="re_password" type="password"
               name="re_password"
               placeholder="Nhập lại mật khẩu..."
               required>
    </div>
    <div>
        <label for="phone">Số điện thoại:</label>
        <input id="phone" type="tel" name="phonenumber" placeholder="Nhập số điện thoại..."
               pattern="[0-9]{10,11}"
               title="Số điện thoại phải có 10 hoặc 11 chữ số" required>
    </div>
    <div>
        <label for="address">Địa chỉ:</label>
        <div class="address-container">
            <textarea id="address" name="address" placeholder="Nhập địa chỉ..." required></textarea>
            <div id="suggestions"></div>
        </div>
    </div>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
    <div>
        <button type="submit">Đăng kí</button>
    </div>
</form>
<p>Bạn đã có tài khoản ? <a href="/authenticate?action=loginForm">Đăng nhập</a></p>
</body>
<script>
    const password = document.getElementById('password');
    const rePassword = document.getElementById('re_password');

    function validatePassword() {
        if (password.value !== rePassword.value) {
            rePassword.setCustomValidity("Mật khẩu nhập lại không khớp");
        } else {
            rePassword.setCustomValidity("");
        }
    }

    rePassword.addEventListener('input', validatePassword);
    password.addEventListener('input', validatePassword);

    const addressInput = document.getElementById('address');
    const suggestionsContainer = document.getElementById('suggestions');
    let debounceTimeout = null;
    addressInput.addEventListener('input', function () {
        const query = this.value.trim();
        if (query.length < 3) {
            suggestionsContainer.innerHTML = "";
            suggestionsContainer.style.display = "none";
            return;
        }
        if (debounceTimeout) clearTimeout(debounceTimeout);
        debounceTimeout = setTimeout(() => {
            fetch(`https://nominatim.openstreetmap.org/search?q=\${encodeURIComponent(query)}&format=json&addressdetails=1`)
                .then(response => response.json())
                .then(data => {
                    suggestionsContainer.innerHTML = "";
                    if (data.length > 0) {
                        suggestionsContainer.style.display = "block";
                        data.forEach(item => {
                            const div = document.createElement("div");
                            div.textContent = item.display_name;
                            div.addEventListener("click", () => {
                                addressInput.value = item.display_name;
                                suggestionsContainer.innerHTML = "";
                                suggestionsContainer.style.display = "none";
                            });
                            suggestionsContainer.appendChild(div);
                        });
                    } else {
                        suggestionsContainer.style.display = "none";
                    }
                })
                .catch(error => console.error("Lỗi khi gọi Nominatim API:", error));
        }, 300);
    });

    document.addEventListener('click', function (e) {
        if (e.target !== addressInput && e.target.parentNode !== suggestionsContainer) {
            suggestionsContainer.innerHTML = "";
            suggestionsContainer.style.display = "none";
        }
    });
</script>
</body>
</html>
