function addToCart(productId, price, quantity) {

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
function addToCollection(productId) {

    quantity = quantity && !isNaN(quantity) && quantity > 0 ? quantity : 1;

    fetch('/homeUser?action=addProductToCollection', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `id=${productId}`
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showToast('Đã thêm vào bộ sưu tập!', 'success');
            } else {
                showToast('Thêm vào bộ sưu tập thất bại!', 'error');
            }
        })
        .catch(error => console.error('Lỗi khi thêm vào bộ sưu tập:', error));
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

function getQuantity(productId) {
    const input = document.querySelector(`#quantity_${productId}`);
    return input ? (parseInt(input.value, 10) || 1) : 1;
}
