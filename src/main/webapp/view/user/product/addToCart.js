function addToCart(productId, price, quantity) {
    // Nếu quantity không hợp lệ (undefined, NaN, 0, ...) thì mặc định là 1
    quantity = quantity && !isNaN(quantity) && quantity > 0 ? quantity : 1;

    fetch('/homeUser?action=addProductToCart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `id=${productId}&price=${price}&quantity=${quantity}`
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showToast('Đã thêm vào giỏ hàng!', 'success');
                updateCartCount(data.cartCount);
            } else {
                showToast('Thêm vào giỏ hàng thất bại!', 'error');
            }
        })
        .catch(error => console.error('Lỗi khi thêm vào giỏ hàng:', error));
}

function updateCartCount(count) {
    const cartBadge = document.querySelector('#cartCount');
    if (cartBadge) {
        cartBadge.textContent = count;
    }
}

function showToast(message, icon) {
    Swal.fire({
        toast: true,
        position: 'top',
        icon: icon,
        title: message,
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true
    });
}

// Hàm lấy số lượng từ input nếu tồn tại, nếu không có thì trả về 1
function getQuantity(productId) {
    const input = document.querySelector(`#quantity_${productId}`);
    return input ? (parseInt(input.value, 10) || 1) : 1;
}
