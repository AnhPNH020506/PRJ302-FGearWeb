/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// 1. Hàm bật/tắt hiển thị form đánh giá
function toggleReviewForm() {
    const formContainer = document.getElementById('reviewFormContainer');
    if (formContainer.style.display === 'none') {
        formContainer.style.display = 'block';
        // Focus luôn vào ô nhập nội dung cho tiện
        formContainer.querySelector('textarea[name="reviewContent"]').focus();
    } else {
        formContainer.style.display = 'none';
    }
}

// 2. Logic xử lý Click đổi sao đánh giá
document.addEventListener("DOMContentLoaded", function() {
    const stars = document.querySelectorAll('#starRatingSelector i');
    const ratingInput = document.getElementById('ratingValueInput');

    stars.forEach(star => {
        star.addEventListener('click', function() {
            // Lấy giá trị sao được click
            const selectedValue = this.getAttribute('data-value');
            // Gán vào thẻ input hidden để form gửi đi
            ratingInput.value = selectedValue;

            // Cập nhật lại giao diện (sao rỗng / sao đặc)
            stars.forEach(s => {
                if (parseInt(s.getAttribute('data-value')) <= parseInt(selectedValue)) {
                    s.classList.remove('fa-regular');
                    s.classList.add('fa-solid');
                } else {
                    s.classList.remove('fa-solid');
                    s.classList.add('fa-regular');
                }
            });
        });
    });
});

