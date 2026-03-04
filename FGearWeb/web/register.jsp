<%-- 
    Document   : register
    Created on : Mar 1, 2026, 8:34:40 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap & Font Awesome (optional) -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <!-- CSS -->
        <style>
            /* Nền xám toàn trang */
            body {
                background-color: #f5f5f5;
            }

            /* Wrapper căn giữa */
            .register-wrapper {
                min-height: 80vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Card form */
            .register-wrapper form {
                background: white;
                width: 400px;
                padding: 40px 35px;
                border-radius: 12px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            }

            /* Label */
            .register-wrapper label {
                font-weight: 500;
                margin-bottom: 6px;
            }

            /* Input */
            .register-wrapper input {
                width: 100%;
                padding: 12px;
                border-radius: 6px;
                border: 1px solid #ddd;
                margin-bottom: 20px;
                outline: none;
                transition: 0.3s;
            }

            .register-wrapper input:focus {
                border-color: #ff6700;
                box-shadow: 0 0 0 2px rgba(255,103,0,0.2);
            }

            /* Button */
            .btn-register {
                width: 100%;
                padding: 12px;
                background-color: #1677ff;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                transition: 0.3s;
            }

            .btn-register:hover {
                background-color: #0f5ed7;
            }
            /* Tùy chỉnh Header */
            .bg-gearvn {
                background-color: #ff6700 !important;
            }

            .btn-glass {
                background-color: rgba(255,255,255,0.2);
                color: white;
                border: 1px solid rgba(255,255,255,0.3);
            }

            .btn-glass:hover {
                background-color: rgba(255,255,255,0.3);
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
        <div class="register-wrapper"> 
            <form action="UserController" method="post">
                <input type="hidden" name="action" value="register">

                <h3 class="text-center mb-4">Tạo tài khoản</h3>

                <div class="register-input">
                    <label>Email / Số điện thoại</label>
                    <input type="text" name="email"
                           placeholder="Nhập email hoặc số điện thoại" required>
                </div> 

                <div class="register-name">
                    <label>Tên</label>
                    <input type="text" name="nameRegister"
                           placeholder="Nhập tên tài khoản" required>
                </div>

                <div class="register-group">
                    <label>Mật khẩu</label>
                    <input type="password" name="password"
                           placeholder="Nhập mật khẩu" required>
                </div>

                <div class="register-action">
                    <button type="submit" class="btn-register">
                        Đăng ký
                    </button> 
                </div>
            </form>
        </div>
    </body>
</html>
