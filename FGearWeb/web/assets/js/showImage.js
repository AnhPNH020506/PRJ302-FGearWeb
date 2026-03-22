/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Hàm mở ảnh
function openImageModal(imageSrc) {
    const overlay = document.getElementById('imageLightboxOverlay');
    const enlargedImg = document.getElementById('enlargedImage');

    // Gán đường dẫn ảnh được click vào thẻ img to
    enlargedImg.src = imageSrc;

    // Đổi display thành flex để nó tự động căn giữa bức ảnh (nhờ align-items và justify-content đã set ở CSS)
    overlay.style.display = 'flex';

    // Khóa cuộn trang web (tùy chọn, giúp trải nghiệm tốt hơn)
    document.body.style.overflow = 'hidden';
}

// Hàm đóng ảnh
function closeImageModal() {
    const overlay = document.getElementById('imageLightboxOverlay');

    // Ẩn overlay đi
    overlay.style.display = 'none';

    // Xóa src để giải phóng bộ nhớ
    document.getElementById('enlargedImage').src = "";

    // Mở lại cuộn trang web
    document.body.style.overflow = 'auto';
}
