<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="models.ProductDAO" %>
<%@page import="models.ProductDTO" %>

<%!
    public String formatCurrency(int amount) {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(amount) + "vnđ";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FGear</title>

        <!-- Bootstrap & Font Awesome (optional) -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

        <!-- CSS -->
        <style>
            /* --- CSS TÙY CHỈNH (Những cái Bootstrap không có sẵn) --- */

            /* Màu đỏ đặc trưng của GearVN */
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

            .header-search-input:focus {
                box-shadow: none; /* Bỏ viền xanh mặc định của Bootstrap khi click */
                border-color: white;
            }

            /* Menu Button trong suốt */
            .btn-glass {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
            }
            .btn-glass:hover {
                background: rgba(255, 255, 255, 0.3);
                color: white;
            }

            /* Banner quảng cáo 2 bên (Sticky) */
            .side-banner {
                width: 180px;
                position: sticky;
                top: 80px; /* Cách top header ra */
                height: 600px;
                background-color: #ddd;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 8px;
                color: #777;
                font-weight: bold;
            }

            /* Layout wrapper đặc biệt để chứa 3 cột */
            .main-wrapper {
                display: flex;
                justify-content: center;
                gap: 15px;
                padding-top: 20px;
                overflow-x: hidden;
            }

            /* Chỉ hiển thị banner khi màn hình đủ rộng (Custom breakpoint > 1400px) */
            @media (max-width: 1600px) {
                .side-banner {
                    display: none;
                }
            }

            /* Hiệu ứng hover cho card sản phẩm */
            .product-card {
                transition: transform 0.2s, box-shadow 0.2s;
                cursor: pointer;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
                border-color: var(--gearvn-red) !important;
            }

            /* Tag giảm giá */
            .tag-installment {
                background-color: #fceceb;
                color: var(--gearvn-red);
                font-size: 0.8rem;
                font-weight: bold;
            }

            /* Link "Xem tất cả" */
            .link-view-all {
                text-decoration: none;
                font-size: 0.9rem;
            }
            /* toàn màn hình làm nền mờ */
            .login-wrapper {
                width: 100%;
                height: calc(100vh - 80px);
                display: flex;
                justify-content: center;
                align-items: center;
                background: rgba(0,0,0,0.4);
            }

            /* box login */
            .login-box {
                width: 380px;
                background: #fff;
                padding: 32px 28px;
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            }

            /* header */
            .login-header {
                text-align: center;
                margin-bottom: 24px;
            }

            .login-logo {
                width: 80px;
                margin-bottom: 8px;
            }

            .login-header h2 {
                font-size: 20px;
                font-weight: 600;
                color: #333;
            }

            /* input group */
            .input-group {
                margin-bottom: 18px;
            }

            .input-group label {
                display: block;
                margin-bottom: 6px;
                font-size: 14px;
                color: #444;
            }

            .input-group input {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 15px;
                transition: 0.25s;
            }

            .input-group input:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 4px rgba(0,123,255,0.25);
            }

            /* nút login */
            .btn-login {
                width: 100%;
                background: #007bff;
                color: #fff;
                border: none;
                padding: 11px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.25s;
            }

            .btn-login:hover {
                background: #0056d2;
            }

            /* links */
            .login-links {
                margin-top: 14px;
                text-align: center;
                font-size: 14px;
            }

            .login-links a {
                color: #007bff;
                text-decoration: none;
                transition: 0.2s;
            }

            .login-links a:hover {
                text-decoration: underline;
            }
            .logo-img {
                filter: drop-shadow(0 1px 2px rgba(0,0,0,.3));
            }
            .login-logo {
                width: 140px;
                margin-bottom: 12px;
                display: inline-block;
            }
            .success-msg{
                color:#28a745;
                font-weight:500;
            }

            .error-msg{
                color:#dc3545;
                font-weight:500;
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
        <!-- -->
        <div class="login-wrapper">
            <div class="login-box">
                <div class="login-header">
                    <img src="${pageContext.request.contextPath}/assets/img/fgear-logo.png" class="login-logo">

                    <h2>Đăng nhập tài khoản</h2>


                <form action="UserController" method="post">
                    <input type="hidden" name="action" value="login">
                    <div class="input-group">
                        <label for="email">Email / Số điện thoại</label>
                        <input type="text" id="email" name="email" placeholder="Nhập email hoặc số điện thoại" required>
                    </div>

                    <div class="input-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
                    </div>
                    <!-- HIỂN THỊ LỖI -->
                    <div style="color:red; text-align:center; margin-bottom:10px;">
                        ${error}
                    </div>
                    <div class="login-actions">
                        <button type="submit" class="btn-login">Đăng nhập</button>
                    </div>

                    <div class="login-links">
                        <a href="forgotPassword.jsp">Quên mật khẩu?</a>

                        <a href="register.jsp">Tạo tài khoản mới</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>