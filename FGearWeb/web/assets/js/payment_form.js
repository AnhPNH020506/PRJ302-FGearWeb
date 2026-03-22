/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Đợi cho HTML load xong hết mới chạy script
document.addEventListener('DOMContentLoaded', function () {
    
    // 1. Tìm các phần tử HTML trong Modal của trang Giỏ hàng
    var paymentModal = document.getElementById('paymentModal');
    var paymentSelect = document.getElementById('paymentMethodSelect');
    var qrSection = document.getElementById('qrSection');
    var receiptImage = document.getElementById('receiptImage');

    // 2. Logic khi mở Modal lên
    if (paymentModal) {
        paymentModal.addEventListener('show.bs.modal', function (event) {
            
            var button = event.relatedTarget;

            // Rút trích dữ liệu của ĐƠN HÀNG (order-id)
            var orderId = button.getAttribute('data-order-id');
            var productName = button.getAttribute('data-product-name');
            var price = button.getAttribute('data-price');

            // Tìm các ô trống trong Modal
            var modalOrderIdInput = paymentModal.querySelector('#modalOrderId');
            var modalProductName = paymentModal.querySelector('#modalProductName');
            var modalPrice = paymentModal.querySelector('#modalPrice');

            // Đổ dữ liệu vào đúng vị trí
            if (modalOrderIdInput) modalOrderIdInput.value = orderId;          
            if (modalProductName) modalProductName.textContent = productName;  
            if (modalPrice) modalPrice.textContent = price;                    

            // RESET GIAO DIỆN: Đưa về mặc định là COD mỗi lần mở Modal lên để tránh lỗi hiển thị
            if (paymentSelect) paymentSelect.value = 'COD';
            if (qrSection) qrSection.classList.add('d-none');
            if (receiptImage) receiptImage.removeAttribute('required');
        });
    }

    // 3. Logic bắt sự kiện khi khách đổi phương thức thanh toán
    if (paymentSelect) {
        paymentSelect.addEventListener('change', function () {
            if (this.value === 'BANK') {
                // Khách chọn Ngân hàng -> Hiện khu vực QR và Bắt buộc up ảnh
                if (qrSection) qrSection.classList.remove('d-none'); 
                if (receiptImage) receiptImage.setAttribute('required', 'required');
            } else {
                // Khách chọn COD -> Ẩn khu vực QR và Bỏ bắt buộc up ảnh
                if (qrSection) qrSection.classList.add('d-none'); 
                if (receiptImage) receiptImage.removeAttribute('required');
            }
        });
    }
    // Bắt sự kiện khi khách chọn file xong
    var receiptImage = document.getElementById('receiptImage');
    var fileNameDisplay = document.getElementById('fileNameDisplay');

    if (receiptImage && fileNameDisplay) {
        receiptImage.addEventListener('change', function() {
            // Nếu có file được chọn
            if (this.files && this.files.length > 0) {
                // Lấy tên file và in ra màn hình
                fileNameDisplay.textContent = 'Đã chọn: ' + this.files[0].name; 
                fileNameDisplay.classList.remove('text-muted');
                fileNameDisplay.classList.add('text-success', 'fw-bold'); // Đổi sang màu xanh báo thành công
            } else {
                // Nếu khách bấm hủy, không chọn nữa
                fileNameDisplay.textContent = 'Chưa có file nào được chọn';
                fileNameDisplay.classList.remove('text-success', 'fw-bold');
                fileNameDisplay.classList.add('text-muted');
            }
        });
    }
});


