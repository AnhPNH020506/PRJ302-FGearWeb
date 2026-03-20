<%-- 
    Document   : index
    Created on : Jan 25, 2026, 1:13:09 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="models.ProductDAO" %>
<%@page import="models.ProductDTO" %>
<%@page import="models.UserDTO" %>
<%@page import="models.UserDAO" %>

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
        <link rel="stylesheet" href="assets/css/style.css"/>

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
        </style>
    </head>
    <body>
        <!-- 1. HEADER (Sử dụng Flexbox Utilities của Bootstrap) -->
        <jsp:include page="header.jsp" />

        <!-- 2. MAIN LAYOUT (3 Cột: Banner - Content - Banner) -->
        <div class="main-wrapper pb-5">

            <!-- Banner Trái -->
            <aside class="side-banner">
                Banner Trái
            </aside>

            <!-- Main Content (Container chính giữa) -->
            <div class="container" style="max-width: 1200px;">

                <%
                    ProductDAO dao = new ProductDAO();
                    ArrayList<ProductDTO> productListResult = dao.searchBySubCategory("SUB001");
                    ArrayList<ProductDTO> productList2 = dao.searchBySubCategory("SUB002");
                    for (ProductDTO prd : productList2) {
                        productListResult.add(prd);
                    }
                %>

                <!-- 1. LAPTOP BÁN CHẠY -->
                <section class="bg-white rounded p-3 mb-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h2 class="h5 fw-bold text-uppercase m-0">LAPTOP BÁN CHẠY</h2>
                        <a href="MainController?action=ShowProduct&keyword=LPT" class="link-view-all text-primary">Xem tất cả</a>
                    </div>
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <%
                            int count = 0;
                            for (ProductDTO p : productListResult) {
                                if (count >= 5) {
                                    break; // Chỉ chạy tới sản phẩm thứ 5 thì dừng
                                }
                                count++;
                        %>
                        <div class="col">
                            <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                                <div class="card h-100 product-card border-light shadow-sm">
                                    <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                        <!-- Chỗ này để img src từ DB -->
                                        <img src="<%= p.getThumbnail_url()%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title text-truncate placeholder-text"><%= p.getName()%></h6>
                                        <div class="mt-auto">
                                            <%
                                                if (p.getSale_price() != 0) {
                                            %>
                                            <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                            <%
                                            } else {
                                            %>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <%
                            } //kết thúc vòng lặp
                        %>
                    </div>
                </section>

                <!-- 2. VGA BÁN CHẠY -->
                <section class="bg-white rounded p-3 mb-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h2 class="h5 fw-bold text-uppercase m-0">VGA BÁN CHẠY</h2>
                        <a href="MainController?action=ShowProduct&keyword=VGA" class="link-view-all text-primary">Xem tất cả</a>
                    </div>
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <%
                            productListResult = dao.searchBySubCategory("SUB003");

                            count = 0;
                            for (ProductDTO p : productListResult) {
                                if (count >= 5) {
                                    break; // Chỉ chạy tới sản phẩm thứ 5 thì dừng
                                }
                                count++;
                        %>
                        <div class="col">
                            <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                                <div class="card h-100 product-card border-light shadow-sm">
                                    <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                        <!-- Chỗ này để img src từ DB -->
                                        <img src="<%= p.getThumbnail_url()%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title text-truncate placeholder-text"><%= p.getName()%></h6>
                                        <div class="mt-auto">
                                            <%
                                                if (p.getSale_price() != 0) {
                                            %>
                                            <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                            <%
                                            } else {
                                            %>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </section>

                <!-- 3. CPU BÁN CHẠY -->
                <section class="bg-white rounded p-3 mb-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h2 class="h5 fw-bold text-uppercase m-0">CPU BÁN CHẠY</h2>
                        <a href="MainController?action=ShowProduct&keyword=CPU" class="link-view-all text-primary">Xem tất cả</a>
                    </div>
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <%
                            productListResult = dao.searchBySubCategory("SUB004");

                            count = 0;
                            for (ProductDTO p : productListResult) {
                                if (count >= 5) {
                                    break; // Chỉ chạy tới sản phẩm thứ 5 thì dừng
                                }
                                count++;
                        %>
                        <div class="col">
                            <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                                <div class="card h-100 product-card border-light shadow-sm">
                                    <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                        <!-- Chỗ này để img src từ DB -->
                                        <img src="<%= p.getThumbnail_url()%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title text-truncate placeholder-text"><%= p.getName()%></h6>
                                        <div class="mt-auto">
                                            <%
                                                if (p.getSale_price() != 0) {
                                            %>
                                            <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                            <%
                                            } else {
                                            %>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </section>

                <!-- 4. RAM BÁN CHẠY -->
                <section class="bg-white rounded p-3 mb-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h2 class="h5 fw-bold text-uppercase m-0">RAM BÁN CHẠY</h2>
                        <a href="MainController?action=ShowProduct&keyword=RAM" class="link-view-all text-primary">Xem tất cả</a>
                    </div>
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <%
                            productListResult = dao.searchBySubCategory("SUB005");
                            ArrayList<ProductDTO> list1 = dao.searchBySubCategory("SUB006");
                            for (ProductDTO prd : list1) {
                                productListResult.add(prd);
                            }

                            count = 0;
                            for (ProductDTO p : productListResult) {
                                if (count >= 5) {
                                    break; // Chỉ chạy tới sản phẩm thứ 5 thì dừng
                                }
                                count++;
                        %>
                        <div class="col">
                            <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                                <div class="card h-100 product-card border-light shadow-sm">
                                    <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                        <!-- Chỗ này để img src từ DB -->
                                        <img src="<%= p.getThumbnail_url()%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title text-truncate placeholder-text"><%= p.getName()%></h6>
                                        <div class="mt-auto">
                                            <%
                                                if (p.getSale_price() != 0) {
                                            %>
                                            <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                            <%
                                            } else {
                                            %>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </section>

                <!-- 5. MÀN HÌNH BÁN CHẠY -->
                <section class="bg-white rounded p-3 mb-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h2 class="h5 fw-bold text-uppercase m-0">MÀN HÌNH BÁN CHẠY</h2>
                        <a href="MainController?action=ShowProduct&keyword=MON" class="link-view-all text-primary">Xem tất cả</a>
                    </div>
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <%
                            list1.clear();
                            productListResult = dao.searchBySubCategory("SUB007");
                            list1 = dao.searchBySubCategory("SUB008");
                            for (ProductDTO prd : list1) {
                                productListResult.add(prd);
                            }

                            count = 0;
                            for (ProductDTO p : productListResult) {
                                if (count >= 5) {
                                    break; // Chỉ chạy tới sản phẩm thứ 5 thì dừng
                                }
                                count++;
                        %>
                        <div class="col">
                            <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                                <div class="card h-100 product-card border-light shadow-sm">
                                    <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                        <!-- Chỗ này để img src từ DB -->
                                        <img src="<%= p.getThumbnail_url()%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title text-truncate placeholder-text"><%= p.getName()%></h6>
                                        <div class="mt-auto">
                                            <%
                                                if (p.getSale_price() != 0) {
                                            %>
                                            <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                            <%
                                            } else {
                                            %>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </section>

                <!-- 6. BÀN PHÍM BÁN CHẠY -->
                <section class="bg-white rounded p-3 mb-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h2 class="h5 fw-bold text-uppercase m-0">BÀN PHÍM BÁN CHẠY</h2>
                        <a href="MainController?action=ShowProduct&keyword=KEY" class="link-view-all text-primary">Xem tất cả</a>
                    </div>
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <%
                            list1.clear();
                            productListResult = dao.searchBySubCategory("SUB009");

                            count = 0;
                            for (ProductDTO p : productListResult) {
                                if (count >= 5) {
                                    break; // Chỉ chạy tới sản phẩm thứ 5 thì dừng
                                }
                                count++;
                        %>
                        <div class="col">
                            <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                                <div class="card h-100 product-card border-light shadow-sm">
                                    <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                        <!-- Chỗ này để img src từ DB -->
                                        <img src="<%= p.getThumbnail_url()%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title text-truncate placeholder-text"><%= p.getName()%></h6>
                                        <div class="mt-auto">
                                            <%
                                                if (p.getSale_price() != 0) {
                                            %>
                                            <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                            <%
                                            } else {
                                            %>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </section>

                <!-- 7. CHUỘT KHÔNG DÂY BÁN CHẠY -->
                <section class="bg-white rounded p-3 mb-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                        <h2 class="h5 fw-bold text-uppercase m-0">CHUỘT KHÔNG DÂY BÁN CHẠY</h2>
                        <a href="MainController?action=ShowProduct&keyword=MSE" class="link-view-all text-primary">Xem tất cả</a>
                    </div>
                    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <%
                            list1.clear();
                            productListResult = dao.searchBySubCategory("SUB010");

                            count = 0;
                            for (ProductDTO p : productListResult) {
                                if (count >= 5) {
                                    break; // Chỉ chạy tới sản phẩm thứ 5 thì dừng
                                }
                                count++;
                        %>
                        <div class="col">
                            <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                                <div class="card h-100 product-card border-light shadow-sm">
                                    <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                        <!-- Chỗ này để img src từ DB -->
                                        <img src="<%= p.getThumbnail_url()%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column p-2">
                                        <h6 class="card-title text-truncate placeholder-text"><%= p.getName()%></h6>
                                        <div class="mt-auto">
                                            <%
                                                if (p.getSale_price() != 0) {
                                            %>
                                            <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                            <%
                                            } else {
                                            %>
                                            <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </section>
            </div>
            <aside class="side-banner">Banner Phải</aside>
        </div>

        <!-- Banner Phải -->
        <aside class="side-banner">
            Banner Phải
        </aside>

    </div>

    <!-- Bootstrap JS Bundle (Bắt buộc để chạy các tính năng động nếu có) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/script.js"></script>
</body>
</html>
