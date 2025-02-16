<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <title>Xác minh xóa</title>
</head>
<body>
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="confirmDeleteLabel">
                    <i class="fas fa-exclamation-triangle me-2"></i> Xác nhận xóa
                </h5>
                <button type="button" class="btn-close btn-close-white" id="closeModalBtn" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa mục này không?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id="cancelDeleteBtn">Hủy</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Xóa</button>
            </div>
        </div>
    </div>
</div>

<script>
    let currentDeleteId = null;
    let currentDeleteUrl = null;
    let currentDeleteAction = null;
    let modalInstance = null;

    function showDeleteModal(options) {
        currentDeleteId = options.id;
        currentDeleteUrl = options.url;
        currentDeleteAction = options.action;
        modalInstance = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
        modalInstance.show();
    }

    document.getElementById('cancelDeleteBtn').addEventListener('click', function () {
        if (modalInstance) {
            modalInstance.hide();
        }
    });
    document.getElementById('closeModalBtn').addEventListener('click', function () {
        if (modalInstance) {
            modalInstance.hide();
        }
    });

    document.getElementById('confirmDeleteModal').addEventListener('hidden.bs.modal', function () {
        currentDeleteId = null;
        currentDeleteUrl = null;
        currentDeleteAction = null;
    });

    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        if (!currentDeleteId || !currentDeleteUrl || !currentDeleteAction) return;
        let formData = new URLSearchParams();
        formData.append("action", currentDeleteAction);
        formData.append("id", currentDeleteId);

        fetch(currentDeleteUrl, {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: formData.toString()
        })
            .then(response => response.text())
            .then(data => {
                console.log("Server Response:", data);
                if (data.trim() === "success") {
                    modalInstance.hide();
                    location.reload();
                } else {
                    alert("Xóa thất bại: " + data);
                }
            })
            .catch(error => console.error('Lỗi:', error));
    });
</script>
</body>
</html>
