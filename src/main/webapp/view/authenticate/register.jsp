<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng kí</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Gợi ý địa chỉ sử dụng dropdown của Bootstrap */
        #suggestions {
            max-height: 200px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <!-- Card đăng kí -->
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">Đăng kí</h3>
                </div>
                <div class="card-body">
                    <form action="/authenticate?action=register" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="avt_path">Ảnh đại diện:</label>
                            <input type="file" class="form-control-file" id="avt_path" name="avt_path" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label for="username">Tên đăng nhập:</label>
                            <input id="username" name="username" type="text" class="form-control"
                                   pattern="[A-Za-z0-9]{3,}" placeholder="Nhập tên đăng nhập..."
                                   title="Tên đăng nhập phải có ít nhất 3 ký tự, chỉ chứa chữ cái và số"
                                   required autofocus>
                        </div>
                        <div class="form-group">
                            <label for="password">Mật khẩu:</label>
                            <input id="password" type="password" name="password" class="form-control"
                                   pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$" placeholder="Nhập mật khẩu..."
                                   title="Mật khẩu phải có 6-12 ký tự, chứa ít nhất một chữ cái và một số"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="re_password">Nhập lại mật khẩu:</label>
                            <input id="re_password" type="password" name="re_password" class="form-control"
                                   placeholder="Nhập lại mật khẩu..." required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Số điện thoại:</label>
                            <input id="phone" type="tel" name="phonenumber" class="form-control" placeholder="Nhập số điện thoại..."
                                   pattern="[0-9]{10,11}" title="Số điện thoại phải có 10 hoặc 11 chữ số" required>
                        </div>
                        <div class="form-group">
                            <label for="address">Địa chỉ:</label>
                            <!-- Sử dụng dropdown của Bootstrap cho gợi ý địa chỉ -->
                            <div class="dropdown">
                                <textarea id="address" name="address" class="form-control" placeholder="Nhập địa chỉ..." required></textarea>
                                <div id="suggestions" class="dropdown-menu w-100"></div>
                            </div>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">${error}</div>
                        </c:if>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Đăng kí</button>
                        </div>
                    </form>
                    <div class="text-center">
                        <p>Bạn đã có tài khoản? <a href="/authenticate?action=loginForm">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
            <!-- Kết thúc Card đăng kí -->
        </div>
    </div>
</div>

<!-- jQuery và Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Kiểm tra mật khẩu trùng khớp
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

    // Xử lý gợi ý địa chỉ với Nominatim API sử dụng dropdown của Bootstrap
    const addressInput = document.getElementById('address');
    const suggestionsContainer = document.getElementById('suggestions');
    let debounceTimeout = null;

    addressInput.addEventListener('input', function () {
        const query = this.value.trim();
        if (query.length < 3) {
            suggestionsContainer.innerHTML = "";
            suggestionsContainer.classList.remove('show');
            return;
        }
        if (debounceTimeout) clearTimeout(debounceTimeout);
        debounceTimeout = setTimeout(() => {
            fetch(`https://nominatim.openstreetmap.org/search?q=\${encodeURIComponent(query)}&format=json&addressdetails=1`)
                .then(response => response.json())
                .then(data => {
                    suggestionsContainer.innerHTML = "";
                    if (data.length > 0) {
                        data.forEach(item => {
                            const a = document.createElement("a");
                            a.classList.add("dropdown-item");
                            a.href = "#";
                            a.textContent = item.display_name;
                            a.addEventListener("click", (e) => {
                                e.preventDefault();
                                addressInput.value = item.display_name;
                                suggestionsContainer.innerHTML = "";
                                suggestionsContainer.classList.remove('show');
                            });
                            suggestionsContainer.appendChild(a);
                        });
                        suggestionsContainer.classList.add('show');
                    } else {
                        suggestionsContainer.classList.remove('show');
                    }
                })
                .catch(error => console.error("Lỗi khi gọi Nominatim API:", error));
        }, 300);
    });

    document.addEventListener('click', function (e) {
        if (e.target !== addressInput && !suggestionsContainer.contains(e.target)) {
            suggestionsContainer.innerHTML = "";
            suggestionsContainer.classList.remove('show');
        }
    });
</script>
</body>
</html>
