<%@page import="models.UserDAO"%>
<%@page import="models.ProductReviewDAO"%>
<%@page import="models.ProductReviewDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="models.ProductDAO"%>
<%@page import="models.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.UserDTO" %>
<!DOCTYPE html>
<%!
    public String formatCurrency(int amount) {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(amount) + "vnđ";
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết sản phẩm - FGear</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="assets/css/style.css"/>

    <style>
        /* =========================================
           CSS TÙY CHỈNH CHO HEADER & LAYOUT CHUNG
           ========================================= */
        :root {
            --gearvn-red: #ff6600; /* Chỉnh lại màu đỏ cho giống ảnh mẫu hơn */
        }

        body {
            background-color: #f4f6f8;
            font-family: 'Roboto', Arial, sans-serif;
            padding-bottom: 40px;
        }

        /* --- Header CSS --- */
        .bg-gearvn { background-color: var(--gearvn-red); }
        .header-search-input:focus { box-shadow: none; border-color: white; }
        .btn-glass { background: rgba(255, 255, 255, 0.2); color: white; border: none; }
        .btn-glass:hover { background: rgba(255, 255, 255, 0.3); color: white; }
        .hover-opacity-100 { opacity: 1 !important; }
        .header-user { transition: opacity 0.2s; color: white; }
        .header-user:hover { opacity: 0.8; }

        /* =========================================
           CSS CHO TRANG CHI TIẾT SẢN PHẨM
           ========================================= */
        .breadcrumb-custom a {
            color: #0056b3;
            text-decoration: none;
            font-size: 14px;
        }
        .breadcrumb-custom a:hover { text-decoration: underline; }
        
        .product-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            line-height: 1.4;
        }

        .product-price-sale {
            font-size: 32px;
            font-weight: bold;
            color: var(--gearvn-red);
        }

        .product-price-old {
            font-size: 16px;
            text-decoration: line-through;
            color: #999;
        }

        .discount-badge {
            background-color: #fff;
            color: var(--gearvn-red);
            border: 1px solid var(--gearvn-red);
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }

        /* Khung khuyến mãi (Flash Sale) */
        .promo-box {
            border: 1px dashed var(--gearvn-red);
            border-radius: 8px;
            padding: 15px;
            background-color: #fffafb;
            position: relative;
            margin-top: 15px;
        }
        .promo-title {
            background-color: var(--gearvn-red);
            color: white;
            padding: 4px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 10px;
        }

        /* Nút mua hàng */
        .btn-buy-now {
            background-color: var(--gearvn-red);
            color: white;
            font-weight: bold;
            text-transform: uppercase;
            padding: 12px;
            border-radius: 8px;
            border: none;
            transition: all 0.3s;
        }
        .btn-buy-now:hover {
            background-color: #c00015;
            color: white;
        }

        .btn-consult {
            background-color: white;
            color: #0056b3;
            font-weight: bold;
            text-transform: uppercase;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #0056b3;
            transition: all 0.3s;
        }
        .btn-consult:hover {
            background-color: #f0f8ff;
            color: #0056b3;
        }

        /* Thumbnail nhỏ xíu dưới ảnh chính */
        .thumb-img {
            width: 60px;
            height: 60px;
            object-fit: contain;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            padding: 2px;
        }
        .thumb-img:hover {
            border-color: var(--gearvn-red);
        }
        .thumb-img.active {
            border-color: var(--gearvn-red);
            border-width: 2px;
        }
        
        /* Ẩn thanh cuộn mặc định cho đẹp */
        .product-slider::-webkit-scrollbar {
            display: none;
        }
        .product-slider {
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
            scroll-behavior: smooth; /* Hiệu ứng trượt mượt mà */
        }
        /* Style cho nút bấm hai bên */
        .slider-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: white;
            border: 1px solid #ddd;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            z-index: 10;
            transition: all 0.2s;
        }
        .slider-btn:hover {
            background-color: #f36f21;
            color: white;
            border-color: #f36f21;
        }
    </style>
</head>
<body>
    <%
        ProductDTO product = (ProductDTO)request.getAttribute("product");
    %>
    <jsp:include page="header.jsp" />

    <div style="color:${not empty param.error ? 'red' : 'green'}; text-align:center; margin-bottom:10px;">
        <bold>${not empty param.error ? param.error : param.msg}</bold>
    </div>
    <div style="color:red; text-align:center; margin-bottom:10px;">
        <bold>${error}</bold>
    </div>
    
                    
    <div class="container bg-white p-4 rounded shadow-sm mt-4 mb-4" style="max-width: 1200px;">
        
        <%
            UserDTO curUser = (UserDTO)session.getAttribute("user");
            if (curUser != null) {
                System.out.println(curUser.getUserId());
            }
       %>

        <div class="breadcrumb-custom mb-3">
            <a href="http://localhost:8080/FGearWeb"><i class="fa-solid fa-house"></i> Trang chủ</a> 
            <span class="text-muted mx-1">/</span> 
            <span class="text-muted"><%= product.getSlug() %></span>
        </div>

        <div class="row">
            <div class="col-md-5">
                <div class="border rounded p-2 mb-3 d-flex justify-content-center align-items-center" style="height: 400px;">
                    <img id="main-product-image" src="<%= product.getThumbnail_url() %>" alt="<%= "TEST" %>" class="img-fluid" style="max-height: 100%; object-fit: contain;">
                </div>
                <div class="d-flex gap-2 justify-content-center">
                    <img src="<%= product.getThumbnail_url() %>" class="thumb-img active" id="1" alt="thumb 1">
                    <img src="${pageContext.request.contextPath}/assets/img/fgear-logo.png" class="thumb-img" id="2" alt="thumb 2">
                    <img src="${pageContext.request.contextPath}/assets/img/fgear-logo.png" class="thumb-img" id="3" alt="thumb 3">
                    <img src="${pageContext.request.contextPath}/assets/img/fgear-logo.png" class="thumb-img" id="4" alt="thumb 4">
                </div>
            </div>

            <div class="col-md-7 ps-md-4">
                <h1 class="product-title mb-2"><%= product.getName() %></h1>
                <div class="mb-3">
                    <a href="#" class="text-decoration-none text-primary fs-6">Xem đánh giá</a>
                </div>

                <div class="d-flex align-items-end gap-3 mb-2">
                    <% if (product.getSale_price() != 0) { 
                        // Tính phần trăm giảm giá
                    %>
                        <span class="product-price-sale"><%= product.getFormattedSale_price()%></span>
                        <span class="product-price-old pb-1"><%= product.getFormattedPrice()%></span>
                        <%
                            double discount = (double) (product.getPrice() - product.getSale_price()) / product.getPrice() * 100;
                        %>
                        <span class="discount-bdage mb-2">-<%= (int)Math.round(discount) %>% </span>
                    <% } else { %>
                        <span class="product-price-sale"><%= product.getFormattedPrice() %></span>
                    <% } %>
                </div>

                <% if (curUser != null) { %>
                    <!-- TRƯỜNG HỢP ĐÃ ĐĂNG NHẬP: Form submit đến Controller xử lý giỏ hàng -->
                    <div class="row g-2 mb-4">
                        <div class="col-8">
                            <form action="MainController" method="POST" class="h-100">
                                <input type="hidden" name="action" value="addNewOrderMuaNgay">
                                <input type="hidden" name="productId" value="<%= product.getProduct_id() %>"> 
                                <input type="hidden" name="userId" value="<%= curUser.getUserId() %>"> 
                                <!-- Nút MUA NGAY -->
                                <button type="button" class="btn btn-buy-now w-100 h-100 d-flex flex-column align-items-center justify-content-center py-2" style="border-width: 2px; color: white; background-color: #f36f21"
                                        data-bs-toggle="modal" 
                                        data-bs-target="#buyNowModal"
                                        data-product-id="<%= product.getProduct_id() %>"
                                        data-product-name="<%= product.getName() %>"
                                        data-price="<%= product.getFormattedPrice() %>">
                                    <span class="fw-bold fs-5">MUA NGAY</span>
                                    <span class="fw-normal" style="font-size: 11px;">Giao tận nơi/Nhận tại cửa hàng</span>
                                </button>
                            </form>
                        </div>

                        <div class="col-4">
                            <form action="MainController" method="POST" class="h-100">
                                <input type="hidden" name="action" value="addProductToOrderGioHang">
                                <input type="hidden" name="productId" value="<%= product.getProduct_id() %>"> 
                                <input type="hidden" name="userId" value="<%= curUser.getUserId() %>"> 
                                <button type="submit" class="btn btn-buy-now w-100 h-100 d-flex flex-column align-items-center justify-content-center py-2" style="border-width: 2px; color: white; background-color: #f36f21">
                                    <i class="fa-solid fa-cart-plus fs-5 mb-1"></i>
                                    <span class="fw-bold text-center" style="font-size: 12px;">THÊM VÀO GIỎ</span>
                                </button>
                            </form>
                        </div>
                    </div>
                <% } else { %>
                    <!-- TRƯỜNG HỢP CHƯA ĐĂNG NHẬP: Form submit để chuyển hướng sang trang Login -->
                    <div class="row g-2 mb-4">
                        <div class="col-8">
                            <!-- Nút Mua ngay khi chưa đăng nhập (Tôi cũng bọc Form đẩy về trang báo lỗi login luôn, bạn tự chỉnh action nếu muốn nhé) -->
                            <form action="MainController" method="POST" class="h-100">
                                <input type="hidden" name="action" value="requireLoginUser">
                                <input type="hidden" name="productid" value="<%= product.getProduct_id() %>">
                                <button type="submit" class="btn btn-buy-now w-100 h-100 d-flex flex-column align-items-center justify-content-center py-2" style="background-color: #f36f21; color: white; border: none;">
                                    <span class="fw-bold fs-5">MUA NGAY</span>
                                    <span class="fw-normal" style="font-size: 11px;">Giao tận nơi/Nhận tại cửa hàng</span>
                                </button>
                            </form>
                        </div>

                        <div class="col-4">
                            <form action="MainController" method="POST" class="h-100">
                                <!-- Action này gửi về Controller để xử lý redirect sang login kèm thông báo lỗi -->
                                <input type="hidden" name="action" value="requireLoginUser">
                                <input type="hidden" name="productid" value="<%= product.getProduct_id() %>">
                                <button type="submit" class="btn btn-buy-now w-100 h-100 d-flex flex-column align-items-center justify-content-center py-2" style="border-width: 2px; color: white; background-color: #f36f21">
                                    <i class="fa-solid fa-cart-plus fs-5 mb-1"></i>
                                    <span class="fw-bold text-center" style="font-size: 12px;">THÊM VÀO GIỎ</span>
                                </button>
                            </form>
                        </div>
                    </div>
                <% } %>
                                
                <div class="border mb-4">
                    <div class="text-black p-2 fw-bold fs-6 text-center" style="background-color: #9CA3AF;">
                        Thông số kỹ thuật
                    </div>
                    <%
                        String specs = product.getSpecifications();
                        
                        // Tạo một Map để lưu trữ các cặp key-value
                        Map<String, String> specsMap = new HashMap<>();

                        // Bước 1: Tách chuỗi lớn thành các đoạn nhỏ dựa trên dấu chấm phẩy ";"
                        String[] pairs = specs.split(";");

                        for (String pair : pairs) {
                            // Bước 2: Tách từng đoạn nhỏ thành key và value dựa trên dấu hai chấm ":"
                            String[] keyValue = pair.split(":");

                            // Kiểm tra xem có đúng 2 phần (key và value) không để tránh lỗi
                            if (keyValue.length == 2) {
                                // Dùng trim() để xóa các khoảng trắng thừa ở hai đầu
                                String key = keyValue[0].trim();
                                String value = keyValue[1].trim();

                                // Đưa vào Map
                                specsMap.put(key, value);
                            }
                        }
                    %>
                    <table class="table mb-0" style="font-size: 14px;">
                        <tbody>
                            <% for (Map.Entry<String, String> entry : specsMap.entrySet()) { %>
                                <tr>
                                    <td class="fw-bold text-capitalize" style="width: 20%; border-right: 1px solid #dee2e6;">
                                        <%= entry.getKey() %>
                                    </td>
                                    <td>
                                        <%= entry.getValue() %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <div class="pt-3 border-top">
                    <p class="mb-2"><strong>- Nhà sản xuất:</strong> <%= product.getBrand() %></p>
                    <p class="mb-2"><strong>- Hỗ trợ đổi mới trong 7 ngày.</strong></p>
                </div>
            </div>
        </div>
    </div>
                    
    <div class="container bg-white p-4 rounded shadow-sm mt-4 mb-4" style="max-width: 1200px;">
        <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
            <h2 class="h5 fw-bold text-uppercase m-0">SẢN PHẨM KHÁC</h2>
            <a href="index.jsp" class="link-view-all text-primary text-decoration-none">Xem tất cả</a>
        </div>

        <div class="position-relative">

            <button class="slider-btn position-absolute top-50 start-0 translate-middle-y ms-n2" id="slideLeftBtn">
                <i class="fa-solid fa-chevron-left"></i>
            </button>

            <div class="d-flex flex-nowrap overflow-auto product-slider gap-3 py-2 px-1" id="productSlider">
                <%
                    ProductDAO pdao = new ProductDAO();
                    ArrayList<ProductDTO> result = pdao.searchProductRandomly();
                    for (ProductDTO p : result) {
                %>
                <div style="flex: 0 0 auto; width: 212px;">
                    <a href="MainController?action=ShowProductDetail&id=<%= p.getProduct_id() %>" class="text-decoration-none text-dark d-block h-100">
                        <div class="card h-100 product-card border-light shadow-sm">
                            <div class="ratio ratio-1x1 bg-light rounded-top d-flex align-items-center justify-content-center text-secondary">
                                <img src="<%= p.getThumbnail_url()%>" alt="<%= p.getName() %>" class="img-fluid p-2" style="object-fit: contain; max-height: 100%; width: 100%;"/>
                            </div>
                            <div class="card-body d-flex flex-column p-2">
                                <h6 class="card-title text-truncate placeholder-text" title="<%= p.getName() %>"><%= p.getName()%></h6>
                                <div class="mt-auto">
                                    <% if (p.getSale_price() != 0) { %>
                                    <div class="text-decoration-line-through text-muted small placeholder-text"><%= p.getFormattedPrice()%></div>
                                    <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedSale_price()%></div>
                                    <% } else { %>
                                    <div class="fw-bold text-danger placeholder-text"><%= p.getFormattedPrice()%></div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <%
                    } // kết thúc vòng lặp
                %>
            </div>

            <button class="slider-btn position-absolute top-50 end-0 translate-middle-y me-n2" id="slideRightBtn">
                <i class="fa-solid fa-chevron-right"></i>
            </button>
        </div>
    </div>
            
    <!-- Mục review -->
    <%  
        ProductReviewDAO prDao = new ProductReviewDAO();
        ArrayList<ProductReviewDTO> product_reviews = prDao.filterByName(product.getProduct_id());
        
        //hàm tính trung bình
        double avg = 0;
        if (product_reviews != null && !product_reviews.isEmpty()) {
            for (ProductReviewDTO prd_rv : product_reviews) {
                avg += prd_rv.getRating();
            }
            avg = avg / product_reviews.size();
            // Làm tròn 1 chữ số thập phân nếu cần
            avg = Math.round(avg * 10.0) / 10.0;
        }
    %>
    <div class="container bg-white p-4 rounded shadow-sm mt-4 mb-4" style="max-width: 1200px;">
        <h2 class="h5 fw-bold mb-4">Đánh giá & Nhận xét <%= product.getName() %></h2>

        <!-- Khối thống kê tổng quan -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-4 border-bottom">
            <div class="d-flex align-items-center">
                <div class="fw-bold me-3 text-dark" style="font-size: 48px; line-height: 1;"><%= avg %></div>
                <div>
                    <div class="text-warning fs-5 mb-1">
                        <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                    </div>
                    <div class="text-muted" style="font-size: 14px;">(<%= product_reviews != null ? product_reviews.size() : 0 %> nhận xét)<i class="fa-regular fa-circle-question" style="margin-left: 4px;"></i></div>
                </div>
            </div>
            
            <!-- Nút bật form đánh giá -->
            <button class="btn text-white fw-bold px-4 py-2" style="background-color: var(--gearvn-red, #ff6600); border-radius: 4px;" onclick="toggleReviewForm()">
                <i class="fa-solid fa-pen-to-square me-2"></i>Viết đánh giá
            </button>
        </div>

        <!-- FORM ĐÁNH GIÁ (ẨN MẶC ĐỊNH) -->
        <div id="reviewFormContainer" class="mb-4 p-4 border rounded" style="display: none; background-color: #f8f9fa;">
            <h5 class="fw-bold mb-3">Gửi đánh giá của bạn</h5>
            <!-- Lưu ý: Nếu upload file (ảnh), cần thêm enctype="multipart/form-data" -->
            <form action="MainController" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="commentReview">
                <input type="hidden" name="productId" value="<%= product.getProduct_id() %>">
                
                <!-- Chọn số sao -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Chất lượng sản phẩm:</label>
                    <div id="starRatingSelector" class="text-warning fs-3" style="cursor: pointer;">
                        <!-- Mặc định chọn 5 sao -->
                        <i class="fa-solid fa-star" data-value="1"></i>
                        <i class="fa-solid fa-star" data-value="2"></i>
                        <i class="fa-solid fa-star" data-value="3"></i>
                        <i class="fa-solid fa-star" data-value="4"></i>
                        <i class="fa-solid fa-star" data-value="5"></i>
                    </div>
                    <!-- Ô hidden này sẽ chứa giá trị int từ 1-5 gửi xuống server -->
                    <input type="hidden" name="ratingValue" id="ratingValueInput" value="5">
                </div>

                <!-- Nhập nội dung -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Nội dung đánh giá:</label>
                    <textarea class="form-control" name="reviewContent" rows="4" placeholder="Chia sẻ cảm nhận của bạn về sản phẩm..." required></textarea>
                </div>

                <!-- Upload hình ảnh -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Thêm hình ảnh (không bắt buộc):</label>
                    <input type="file" class="form-control" name="reviewImage" accept="image/*">
                </div>

                <!-- Cụm nút bấm -->
                <div class="d-flex gap-2">
                    <button type="submit" class="btn text-white fw-bold px-4" style="background-color: var(--gearvn-red, #ff6600);">Gửi đánh giá</button>
                    <button type="button" class="btn btn-outline-secondary px-4" onclick="toggleReviewForm()">Hủy</button>
                </div>
            </form>
        </div>

        <!-- DANH SÁCH BÌNH LUẬN CŨ -->
        <div class="review-list">
            <% 
                // NẾU KHÔNG CÓ REVIEW NÀO
                if (product_reviews == null || product_reviews.isEmpty()) { 
            %>
                <div class="text-center py-5">
                    <i class="fa-regular fa-comments text-muted mb-3" style="font-size: 48px;"></i>
                    <p class="text-muted fs-5">Chưa có nhận xét nào về sản phẩm này.</p>
                </div>
            <% 
                // NẾU CÓ REVIEW TRONG DATABASE
                } else { 
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                    for (ProductReviewDTO rev : product_reviews) { 
                        String formattedDate = rev.getCreated_at() != null ? sdf.format(rev.getCreated_at()) : "";
                        String avatarChar = (rev.getUser_id() != null && rev.getUser_id().length() > 0) ? rev.getUser_id().substring(0, 1).toUpperCase() : "U";
            %>
            
            <div class="d-flex gap-3 mb-4 pb-4 border-bottom">
                <div class="rounded-circle d-flex align-items-center justify-content-center fw-bold flex-shrink-0" style="width: 45px; height: 45px; font-size: 16px; background-color: #e2e8f0; color: #475569;">
                    <%= avatarChar %>
                </div>
                
                <div class="flex-grow-1">
                    <div class="d-flex align-items-center mb-1" style="font-size: 14px;">
                        <span class="fw-bold text-dark me-2"><%= rev.getUsername() %></span>
                        <span class="text-muted me-2">| <%= formattedDate %> |</span>
                    </div>
                    
                    <div class="d-flex align-items-center mb-2">
                        <div class="text-warning me-2" style="font-size: 13px;">
                            <% for(int i=1; i<=5; i++) { 
                                if(i <= rev.getRating()) { %>
                                    <i class="fa-solid fa-star"></i>
                                <% } else { %>
                                    <i class="fa-regular fa-star"></i>
                            <%      } 
                                } 
                            %>
                        </div>
                        <span class="fw-bold text-dark" style="font-size: 14px;">
                            <%= rev.getRating() >= 4 ? "Cực kì hài lòng" : (rev.getRating() == 3 ? "Bình thường" : "Không hài lòng") %>
                        </span>
                    </div>
                    
                    <div class="mb-3 text-dark" style="font-size: 14px; line-height: 1.5;">
                        <%= rev.getContent() %>
                    </div>
                    
                    <% if (rev.getImage_url() != null && !rev.getImage_url().trim().isEmpty()) { %>
                    <div class="d-flex gap-2">
                        <img src="<%= rev.getImage_url() %>" class="rounded border" style="width: 60px; height: 60px; object-fit: cover; cursor: pointer;">
                    </div>
                    <% } %>
                    
                </div>
            </div>
            <%      } // Đóng vòng lặp for
                } // Đóng thẻ else 
            %>
        </div>
    </div>
        
    <!-- Modal Mua Ngay -->
    <div class="modal fade" id="buyNowModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title fw-bold">Xác nhận Mua Ngay</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <!-- Form gửi thẳng về MainController -->
          <form action="MainController" method="POST" enctype="multipart/form-data">
            <div class="modal-body">
                <!-- Đổi action thành processBuyNow để Controller biết đây là luồng mua trực tiếp -->
                <input type="hidden" name="action" value="processOrderBuyNow">
                <!-- Thẻ ẩn chứa Product ID -->
                <input type="hidden" name="productId" id="modalProductId" value="">
                <input type="hidden" name="userId" value="<%= curUser.getUserId()%>">
                <p>Bạn đang mua sản phẩm:</p>
                <h6 id="modalBuyNowProductName" class="fw-bold text-primary"></h6>
                <div class="d-flex justify-content-between mt-3">
                    <span>Giá sản phẩm:</span>
                    <span id="modalBuyNowPrice" class="fw-bold fs-5" style="color: var(--gearvn-red, #ff6600);"></span>
                </div>

                <hr>
                <div class="mb-3">
                    <label for="shippingAddress" class="form-label">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                    <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="2" placeholder="Nhập số nhà, tên đường, phường/xã, quận/huyện..." required></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Phương thức thanh toán</label>
                    <select class="form-select" name="paymentMethod" id="paymentMethodSelect">
                        <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                        <option value="BANK">Chuyển khoản ngân hàng</option>
                    </select>
                </div>
            
                <div id="qrSection" class="mb-3 d-none text-center bg-light p-3 rounded border">
                    <p class="mb-2 fw-bold" style="color: var(--gearvn-red, #ff6600);">Quét mã QR để thanh toán</p>

                    <!-- Ảnh QR của bạn -->
                    <img src="${pageContext.request.contextPath}/assets/img/qr_payment.png" class="img-fluid border p-1 mb-3" style="max-width: 200px;" alt="QR Code">

                    <!-- Nút Upload ảnh -->
                    <div class="text-start">
                        <div class="text-start">
                            <label class="form-label fw-bold">Tải lên biên lai chuyển khoản <span class="text-danger">*</span></label>
                            <!-- 1. Nút bấm GIẢ (Dùng Label trang trí thành nút Bootstrap) -->
                            <label for="receiptImage" class="btn btn-outline-secondary d-block" style="cursor: pointer; border-style: dashed;">
                                Upload ảnh
                            </label>
                            <!-- 2. Thẻ input THẬT bị ẩn đi bằng class d-none -->
                            <input class="d-none" type="file" id="receiptImage" name="receiptImage" accept="image/*">
                            <!-- 3. Nơi hiển thị tên file sau khi khách đã chọn xong -->
                            <div id="fileNameDisplay" class="text-muted mt-1" style="font-size: 13px; font-style: italic;">
                                Chưa có file nào được chọn
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
              <button type="submit" class="btn text-white fw-bold" style="background-color: var(--gearvn-red, #ff6600);">Xác nhận Mua</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/script.js"></script>
    <script src="assets/js/script2.js"></script>
    <script src="assets/js/script3.js"></script>
    <script src="assets/js/processBuyNow.js"></script>
    <script src="assets/js/showReview.js"></script>
</body>
</html>