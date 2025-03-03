function addToCart(productId, price, quantity) {
    quantity = quantity && !isNaN(quantity) && quantity > 0 ? quantity : 1;

    fetch('/homeUser?action=addProductToCart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `id=${encodeURIComponent(productId)}&price=${encodeURIComponent(price)}&quantity=${encodeURIComponent(quantity)}`
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Đã thêm vào giỏ hàng!', 'success');
                updateCartCount(data.cartCount);
            } else {
                showNotification('Thêm vào giỏ hàng thất bại!', 'error');
            }
        })
        .catch(() => showNotification('Lỗi kết nối khi thêm vào giỏ hàng!', 'error'));
}
function addToCollection(productId) {
    fetch('/homeUser?action=addCollection', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `product_id=${encodeURIComponent(productId)}`
    })
        .then(response => response.text())
        .then(data => {
            data = data.trim();
            if (data.startsWith("success")) {
                const count = parseInt(data.split(":")[1], 10);
                showNotification('Sản phẩm đã được thêm vào bộ sưu tập.', 'success');
                updateCollectionCount(count);
                updateCollectionButton(productId, true);
            } else if (data === "exists") {
                showNotification('Sản phẩm đã có trong bộ sưu tập.', 'info');
            } else {
                showNotification('Không thể thêm vào bộ sưu tập, thử lại sau.', 'error');
            }
        })
        .catch(() => showNotification('Lỗi kết nối khi thêm vào bộ sưu tập!', 'error'));
}
function updateCartCount(count) {
    const cartBadge = document.querySelector('#cartCount');
    if (cartBadge) cartBadge.textContent = count;
}
function updateCollectionCount(count) {
    const collectionBadge = document.querySelector('#collectionCount');
    if (collectionBadge) {
        if (count > 0) {
            collectionBadge.textContent = count;
            collectionBadge.style.display = 'inline-block';
        } else {
            collectionBadge.style.display = 'none';
        }
    }
}
function updateCollectionButton(productId, added) {
    const button = document.querySelector(`[onclick="addToCollection(${productId})"]`);
    if (button) {
        const icon = button.querySelector("i");
        if (icon) {
            if (added) {
                icon.classList.replace('bi-heart', 'bi-heart-fill');
            } else {
                icon.classList.replace('bi-heart-fill', 'bi-heart');
            }
        }
    }
}
function showNotification(message, type) {
    Swal.fire({
        toast: true,
        position: 'top',
        icon: type,
        title: message,
        showConfirmButton: false,
        timer: 2500,
        timerProgressBar: true
    });
}

