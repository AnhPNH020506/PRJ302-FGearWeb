<%-- 
    Document   : forgot
    Created on : Mar 1, 2026, 10:29:24 AM
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
    </head>
    <style>
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
        <div class="forgot-wrapper">
        <form action="UserController" method="post">
            <input type="hidden" name="action" value="forgot">
            <div class="input-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>
            <button type="submit" class="btn-login"> Gửi mã xác nhận </button>
        </form>
        </div>
    </body>
</html>
