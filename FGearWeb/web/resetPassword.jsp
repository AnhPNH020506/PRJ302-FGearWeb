<%-- 
    Document   : resetPassword
    Created on : Mar 14, 2026, 4:17:26 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <style>
            :root {
                --gearvn-red: #ff6600;
            }

            body {
                background-color: #f0f0f0;
                font-family: 'Roboto', Arial, sans-serif;
            }

            /* Tùy chỉnh Header */
            .bg-gearvn {
                background-color: var(--gearvn-red);
            }
            .btn-gearvn {
                background-color: var(--gearvn-red);
                color: #fff;
                font-weight: 500;
            }
            .btn-gearvn:hover {
                background-color: #e65c00;
            }

        </style>
    </head>
    <body>
        <!-- 1. HEADER (Sử dụng Flexbox Utilities của Bootstrap) -->
        <header class="bg-gearvn sticky-top shadow-sm py-2">
            <div class="container" style="max-width: 1200px;">
                <div class="d-flex align-items-center justify-content-between">

                    <!-- Logo & Menu Danh mục -->
                    <div class="d-flex align-items-center gap-3">
                        <a href="http://localhost:8080/FGearWeb" class="text-white text-decoration-none fw-bold fs-3">FGear</a>
                        <button class="btn btn-glass d-flex align-items-center gap-2">
                            <i class="fa-solid fa-bars"></i> Danh mục
                        </button>
                    </div>

                    <!-- Thanh tìm kiếm (Input Group Bootstrap) -->
                    <div class="flex-grow-1 mx-4">
                        <div class="input-group">
                            <input type="text" class="form-control header-search-input border-0" placeholder="Bạn cần tìm gì?">
                            <button class="btn btn-light text-danger" type="button">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>

                    <!-- User Tools -->
                    <div class="d-flex gap-3 text-white">
                        <div class="d-flex align-items-center gap-2" role="button">
                            <i class="fa-solid fa-headset fs-4"></i>
                            <div class="d-none d-lg-block lh-1 small">
                                <div>Hotline</div>
                                <div class="fw-bold">1900.5301</div>
                            </div>
                        </div>
                        <div class="d-flex align-items-center gap-2" role="button">
                            <i class="fa-solid fa-location-dot fs-4"></i>
                            <div class="d-none d-lg-block lh-1 small">Hệ thống<br>Showroom</div>
                        </div>
                        <div class="d-flex align-items-center gap-2 position-relative" role="button">
                            <i class="fa-solid fa-cart-shopping fs-4"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark border border-light">
                                0
                            </span>
                            <div class="d-none d-lg-block lh-1 small">Giỏ<br>hàng</div>
                        </div>

                        <div class="d-flex align-items-center gap-2" role="button">

                            <a href="login.jsp" class="header-user d-flex align-items-center gap-2">
                                <i class="fa-solid fa-user fs-5"></i>
                                <span class="d-none d-lg-block">Đăng nhập</span>
                            </a>

                        </div>



                    </div>



                </div>
            </div>
        </header>
        <h2 class="text-center my-4">Đặt lại mật khẩu</h2>

        <div class="container d-flex justify-content-center">
            <div class="card shadow-lg" style="max-width: 450px; width: 100%;">
                <div class="card-body">
                    <form action="MainController" method="post" class="d-flex flex-column gap-3">
                        <input type="hidden" name="action" value="resetPassword">

                        <!-- New Password -->
                        <div class="mb-3">
                            <label for="password" class="form-label fw-bold">Mật khẩu mới</label>
                            <input type="password" id="password" name="password" 
                                   class="form-control" minlength="6" maxlength="20" 
                                   placeholder="Nhập mật khẩu mới" required>
                            <small class="text-muted">Mật khẩu phải từ 6–20 ký tự</small>
                        </div>

                        <!-- Confirm Password -->
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label fw-bold">Xác nhận mật khẩu</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" 
                                   class="form-control" minlength="6" maxlength="20" 
                                   placeholder="Nhập lại mật khẩu" required>
                        </div>

                        <!-- Submit button -->
                        <button type="submit" class="btn btn-gearvn w-100">
                            <i class="fa-solid fa-lock me-2"></i> Đổi mật khẩu
                        </button>
                    </form>

                    <!-- Hiển thị thông báo -->
                    <div class="mt-3 text-center text-danger">
                        ${msg}
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
