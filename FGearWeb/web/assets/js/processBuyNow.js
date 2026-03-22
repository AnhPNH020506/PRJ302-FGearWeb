document.addEventListener('DOMContentLoaded', function () {
    // 1. Tìm các phần tử HTML của Modal Mua Ngay
    var buyNowModal = document.getElementById('buyNowModal');
    var paymentSelect = document.getElementById('paymentMethodSelect');
    var qrSection = document.getElementById('qrSection');
    var receiptImage = document.getElementById('receiptImage');
    var fileNameDisplay = document.getElementById('fileNameDisplay');

    // 2. Logic khi mở Modal lên
    if (buyNowModal) {
        buyNowModal.addEventListener('show.bs.modal', function (event) {
            // Lấy thông tin từ nút MUA NGAY vừa bấm
            var button = event.relatedTarget;
            var productId = button.getAttribute('data-product-id');
            var productName = button.getAttribute('data-product-name');
            var price = button.getAttribute('data-price');

            // Bắn dữ liệu vào các thẻ ẩn và text hiển thị
            buyNowModal.querySelector('#modalProductId').value = productId;
            buyNowModal.querySelector('#modalBuyNowProductName').textContent = productName;
            buyNowModal.querySelector('#modalBuyNowPrice').textContent = price;

            // RESET GIAO DIỆN: Đưa về mặc định là COD mỗi lần mở lại Modal
            if (paymentSelect) paymentSelect.value = 'COD';
            if (qrSection) qrSection.classList.add('d-none');
            
            if (receiptImage) {
                receiptImage.removeAttribute('required');
                receiptImage.value = ''; // Xóa trắng file cũ (nếu có)
            }
            
            if (fileNameDisplay) {
                fileNameDisplay.textContent = 'Chưa có file nào được chọn';
                fileNameDisplay.classList.remove('text-success', 'fw-bold');
                fileNameDisplay.classList.add('text-muted');
            }
        });
    }

    // 3. Logic bắt sự kiện khi khách đổi phương thức thanh toán
    if (paymentSelect) {
        paymentSelect.addEventListener('change', function () {
            if (this.value === 'BANK') {
                // Chọn Ngân hàng -> Hiện QR và Bắt buộc up ảnh
                if (qrSection) qrSection.classList.remove('d-none'); 
                if (receiptImage) receiptImage.setAttribute('required', 'required');
            } else {
                // Chọn COD -> Ẩn QR và Bỏ bắt buộc up ảnh
                if (qrSection) qrSection.classList.add('d-none'); 
                if (receiptImage) receiptImage.removeAttribute('required');
            }
        });
    }

    // 4. Logic hiển thị tên file khi khách chọn ảnh xong
    if (receiptImage && fileNameDisplay) {
        receiptImage.addEventListener('change', function() {
            if (this.files && this.files.length > 0) {
                // Đổi chữ thành tên file màu xanh
                fileNameDisplay.textContent = 'Đã chọn: ' + this.files[0].name; 
                fileNameDisplay.classList.remove('text-muted');
                fileNameDisplay.classList.add('text-success', 'fw-bold');
            } else {
                // Nếu khách bấm nút Cancel
                fileNameDisplay.textContent = 'Chưa có file nào được chọn';
                fileNameDisplay.classList.remove('text-success', 'fw-bold');
                fileNameDisplay.classList.add('text-muted');
            }
        });
    }
});