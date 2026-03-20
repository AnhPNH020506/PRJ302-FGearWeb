<%-- 
    Document   : headers
    Created on : Mar 20, 2026, 2:56:43 PM
    Author     : AD
--%>

<%@page import="models.OrdersDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.OrdersDAO"%>
<%@page import="models.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <link rel="stylesheet" href="assets/css/style.css"/>
        <style>
            /* --- CSS TÙY CHỈNH CHO HEADER --- */
            :root {
                --gearvn-red: #ff6600;
            }

            body {
                background-color: #f4f6f8;
                font-family: 'Roboto', Arial, sans-serif;
            }

            /* Tùy chỉnh Header */
            .bg-gearvn {
                background-color: var(--gearvn-red);
            }

            .header-search-input:focus {
                box-shadow: none;
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
            
            /* User tools & Hiệu ứng hover */
            .hover-opacity-100 { opacity: 1 !important; }
            .header-user { transition: opacity 0.2s; color: white; }
            .header-user:hover { opacity: 0.8; }
            
            /* Có thể thêm các CSS riêng của trang Giỏ hàng ở dưới đây */
            
        </style>
    </head>
    <body>
        <!-- headers -->
        <!-- HEADER CHUẨN ĐÃ ĐƯỢC TÍCH HỢP -->
        <header class="bg-gearvn sticky-top shadow-sm py-2 mb-3">
            <div class="container" style="max-width: 1200px;">
                <div class="d-flex align-items-center justify-content-between">
                    
                    <!-- Logo & Menu Danh mục -->
                    <div class="d-flex align-items-center gap-3">
                        <a href="http://localhost:8080/FGearWeb" class="text-white text-decoration-none fw-bold fs-3">FGear</a>
                        <div class="site-overlay"></div>
                        <div class="menu-wrapper">
                            <button class="btn btn-glass d-flex align-items-center gap-2 menutab-btn">
                                <i class="fa-solid fa-bars"></i> Danh mục
                            </button>
                            <div class="main-menu sidebar-menu">
                                <nav class="megamenu-nav">
                                    <ul class="megamenu-nav-main">
                                        <li class="megamenu-item"><a class="megamenu-link" href="MainController?action=ShowProduct&keyword=LPT"><span class="megamenu-name">Laptop</span><span class="megamenu-ic-right">❯</span></a></li>
                                        <li class="megamenu-item"><a class="megamenu-link" href="MainController?action=ShowProduct&keyword=CPU"><span class="megamenu-name">CPU</span><span class="megamenu-ic-right">❯</span></a></li>
                                        <li class="megamenu-item"><a class="megamenu-link" href="MainController?action=ShowProduct&keyword=VGA"><span class="megamenu-name">VGA</span><span class="megamenu-ic-right">❯</span></a></li>
                                        <li class="megamenu-item"><a class="megamenu-link" href="MainController?action=ShowProduct&keyword=KEY"><span class="megamenu-name">Bàn Phím</span><span class="megamenu-ic-right">❯</span></a></li>
                                        <li class="megamenu-item"><a class="megamenu-link" href="MainController?action=ShowProduct&keyword=MSE"><span class="megamenu-name">Chuột</span><span class="megamenu-ic-right">❯</span></a></li>
                                        <li class="megamenu-item"><a class="megamenu-link" href="MainController?action=ShowProduct&keyword=RAM"><span class="megamenu-name">RAM</span><span class="megamenu-ic-right">❯</span></a></li>
                                        <li class="megamenu-item"><a class="megamenu-link" href="MainController?action=ShowProduct&keyword=MON"><span class="megamenu-name">Màn hình</span><span class="megamenu-ic-right">❯</span></a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>

                    <!-- Thanh tìm kiếm -->
                    <div class="flex-grow-1 mx-4">
                        <div class="input-group">
                            <input type="text" class="form-control header-search-input border-0" placeholder="Bạn cần tìm gì?">
                            <button class="btn btn-light text-danger" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </div>
                    </div>

                    <!-- User Tools -->
                    <div class="d-flex gap-3 text-white">
                        <%
                            UserDTO curUser = null;
                            ArrayList<OrdersDTO> orders = null;
                            OrdersDAO odao = new OrdersDAO();
                            try {
                                curUser = (UserDTO)session.getAttribute("user");
                                orders = odao.searchAllOrdersByUserId(curUser.getUserId());
                            } catch (Exception e) {
                                System.out.println("LỖI KHI MUỐN LẤY USER Ở HEADER.JSP");
                            }
                        %>
                        <div class="d-flex align-items-center gap-2" role="button">
                            <i class="fa-solid fa-headset fs-4"></i>
                            <div class="d-none d-lg-block lh-1 small"><div>Hotline</div><div class="fw-bold">1900.5301</div></div>
                        </div>
                        <div class="d-flex align-items-center gap-2" role="button">
                            <i class="fa-solid fa-location-dot fs-4"></i>
                            <div class="d-none d-lg-block lh-1 small">Hệ thống<br>Showroom</div>
                        </div>
                        <div class="d-flex align-items-center gap-2 position-relative" role="button">
                            <a href="cart.jsp" class="header-user d-flex align-items-center gap-2 text-decoration-none text-white">
                                <i class="fa-solid fa-cart-shopping fs-4"></i>
                                <%if (orders != null && orders.size() > 0) {%>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark border border-light">
                                    <%= orders.size()%>
                                </span>
                                <% } %>
                                <div class="d-none d-lg-block lh-1 small">Giỏ<br>hàng</div>
                            </a>
                        </div>

                        <!-- Khối Đăng nhập / Đăng xuất -->
                        <div class="d-flex align-items-center gap-2" role="button">
                            <%
                                if (curUser != null) {
                            %>
                            <a href="#" class="header-user d-flex align-items-center gap-2 text-decoration-none">
                                <i class="fa-solid fa-user fs-5"></i>
                                <span class="d-none d-lg-block"><%= curUser.getUsername() %></span>
                            </a>
                            <a href="UserController?action=logout" class="d-flex align-items-center gap-1 text-white text-decoration-none ms-3 opacity-75 hover-opacity-100">
                                <i class="fa-solid fa-right-from-bracket"></i> <span>Logout</span>
                            </a>
                            <% } else { %>
                            <a href="login.jsp" class="header-user d-flex align-items-center gap-2 text-decoration-none">
                                <i class="fa-solid fa-user fs-5"></i>
                                <span class="d-none d-lg-block">Đăng nhập</span>
                            </a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </header>
                        
        <!-- Script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bỏ comment nếu bạn cần link tới file JS riêng của bạn -->
        <!-- <script src="assets/js/script.js"></script> -->
    </body>
</html>
