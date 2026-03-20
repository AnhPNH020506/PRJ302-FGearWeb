<%@page import="models.ProductDAO"%>
<%@page import="models.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FGear</title>

    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <!-- File CSS gốc của bạn (dành cho các style chung khác nếu có) -->
    <link rel="stylesheet" href="assets/css/style.css"/>

    <style>
        /* =========================================
           CSS TÙY CHỈNH CHO HEADER & LAYOUT CHUNG
           ========================================= */
        :root {
            --gearvn-red: #ff6600;
        }

        body {
            background-color: #f0f0f0; /* Nền xám nhạt */
            font-family: 'Roboto', Arial, sans-serif;
            padding-bottom: 40px;
        }

        /* --- Header CSS --- */
        .bg-gearvn {
            background-color: var(--gearvn-red);
        }

        .header-search-input:focus {
            box-shadow: none; /* Bỏ viền xanh mặc định của Bootstrap khi click */
            border-color: white;
        }

        .btn-glass {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
        }
        .btn-glass:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
        }

        /* Hiệu ứng hover cho phần user trong header */
        .hover-opacity-100 { opacity: 1 !important; }
        .header-user { transition: opacity 0.2s; color: white; }
        .header-user:hover { opacity: 0.8; }


        /* =========================================
           CSS CHO CARD SẢN PHẨM & SCROLLBAR
           ========================================= */
        /* Hiệu ứng Hover cho Card Sản phẩm */
        .product-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
            text-decoration: none !important; /* Bỏ gạch chân link */
            color: inherit;
        }

        .product-card:hover {
            transform: translateY(-4px); /* Nổi nhẹ lên */
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
            border-color: var(--gearvn-red) !important; /* Đổi màu viền cam */
        }

        /* Giới hạn tên sản phẩm tối đa 2 dòng, phần dư hiện dấu ... */
        .text-clamp-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 42px; /* Chiều cao cố định để không làm lệch form card */
            font-size: 14px;
            color: #333;
        }

        /* Tùy chọn Scrollbar nếu bạn có quá nhiều sản phẩm trong 1 mục */
        .scrollable-grid {
/*            max-height: 1400px;
            overflow-y: auto;
            overflow-x: hidden;
            padding-right: 5px;*/
        }
        .scrollable-grid::-webkit-scrollbar { width: 6px; }
        .scrollable-grid::-webkit-scrollbar-track { background: #f8f9fa; border-radius: 4px; }
        .scrollable-grid::-webkit-scrollbar-thumb { background: #cecece; border-radius: 4px; }
        .scrollable-grid::-webkit-scrollbar-thumb:hover { background: var(--gearvn-red); }
    </style>
</head>
<body>

    <!-- ================= 1. HEADER ================= -->
    <jsp:include page="header.jsp" />
    <!-- ================= 2. MAIN CONTENT ================= -->
    <div class="container" style="max-width: 1200px;">
        <%
            //ép kiểu dữ liệu
            ArrayList<ProductDTO> list = (ArrayList<ProductDTO>)request.getAttribute("products");
            String keyword = request.getParameter("keyword");
            ProductDTO prd = list.get(0);
            

        %>
        <!-- MỤC 1: SẢN PHẨM -->
        <section class="bg-white rounded p-4 mb-4 shadow-sm">
            
            <!-- Header Section -->
            <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                <%
                    if(keyword.equals("LPT") || keyword.equals("CPU") || keyword.equals("VGA") || keyword.equals("MSE") || keyword.equals("RAM")) {
                %>
                        <h2 class="h5 fw-bold text-uppercase m-0 text-dark"><%= prd.getName().split(" ")[0] %></h2>
                <%    
                    } else {
                %>
                        <h2 class="h5 fw-bold text-uppercase m-0 text-dark"><%= prd.getName().split(" ")[0] + " " + prd.getName().split(" ")[1]%></h2>
                <%
                    }
                %>
            </div>

            <!-- Lưới Sản Phẩm: 2 cột(Mobile) -> 3 cột(Tablet) -> 5 cột(Desktop) -->
            <div class="scrollable-grid">
                <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-3">
                    <!-- SẢN PHẨM MẪU 1 -->
                    <%
                        for (ProductDTO product : list) {
                    %>
                    <div class="col">
                        <a href="MainController?action=ShowProductDetail&id=<%= product.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                            <div class="card h-100 product-card border-light shadow-sm">
                                <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                    <!-- Chỗ này để img src từ DB -->
                                    <img src="<%= product.getThumbnail_url()%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column p-2">
                                    <h6 class="card-title text-truncate placeholder-text"><%= product.getName()%></h6>
                                    <div class="mt-auto">
                                        <%
                                            if (product.getSale_price() != 0) {
                                        %>
                                        <div class="text-decoration-line-through text-muted small placeholder-text"><%= product.getFormattedPrice()%></div>
                                        <div class="fw-bold text-danger placeholder-text"><%= product.getFormattedSale_price()%></div>
                                        <%
                                        } else {
                                        %>
                                        <div class="fw-bold text-danger placeholder-text"><%= product.getFormattedPrice()%></div>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <!-- [ Kết thúc vòng lặp ] -->
                    <%
                      }  
                    %>
                </div>
            </div>
        </section>

    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Link file script JS gốc của bạn (để xử lý click mở danh mục nếu có) -->
    <script src="assets/js/script.js"></script>
</body>
</html>