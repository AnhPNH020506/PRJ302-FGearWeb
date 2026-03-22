<%-- 
    Document   : cart.jsp
    Created on : Mar 20, 2026, 12:17:22 PM
    Author     : AD
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="models.ProductDAO"%>
<%@page import="models.ProductDTO"%>
<%@page import="models.OrdersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.OrdersDTO"%>
<%@page import="models.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Giỏ hàng - FGear</title>
        
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
        
        <!-- HEADER CHUẨN ĐÃ ĐƯỢC TÍCH HỢP -->
        <jsp:include page="header.jsp" />
        
        <%
            UserDTO user = (UserDTO)session.getAttribute("user");

            // NẾU CÓ USER THÌ CHẠY TOÀN BỘ KHỐI GIAO DIỆN VÀ QUERY DATABASE NÀY
            if (user != null) {
        %>

                <!-- NỘI DUNG GIỎ HÀNG CỦA BẠN SẼ CODE Ở ĐÂY -->

                <div class="container bg-white p-4 rounded shadow-sm mt-4 mb-4" style="max-width: 800px;">
                <!-- Tiêu đề giỏ hàng -->
                    <%
                        ProductDAO pDao = new ProductDAO();
                        OrdersDAO oDao = new OrdersDAO();
                        ArrayList<OrdersDTO> orders = oDao.searchAllOrdersByUserId(user.getUserId());
                        if (orders == null){
                    %>
                    <!-- GIAO DIỆN KHI GIỎ HÀNG TRỐNG -->
                    <div class="text-center py-5">
                        <!-- Icon giỏ hàng (sử dụng FontAwesome giống với icon thùng rác của bạn) -->
                        <i class="fa-solid fa-cart-plus mb-3" style="font-size: 5rem; color: #dee2e6;"></i>
                        <h5 class="fw-bold mt-2" style="color: #333;">Giỏ hàng của bạn đang trống</h5>
                        <p class="text-muted mb-4">Có vẻ như bạn chưa thêm sản phẩm nào vào giỏ hàng.</p>
                        <!-- Nút điều hướng về trang chủ / trang sản phẩm -->
                        <a href="index.jsp" class="btn text-white fw-bold px-4 py-2" style="background-color: var(--gearvn-red, #ff6600); border-radius: 4px;">
                            Tiếp tục mua sắm
                        </a>
                    </div> 
                    <% } else { %>
                    <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                        <h4 class="fw-bold m-0" style="color: #333;">Giỏ hàng của tôi</h4>
                        <span class="text-muted"><%= orders.size() %> đơn hàng</span>
                    </div>

                    <!-- SẢN PHẨM SỐ 1 -->
                    <%
                        for (OrdersDTO ord : orders) {
                            ProductDTO prd = pDao.findSpecificProductById(ord.getProduct_id());
                            // Chỉ hiển thị nếu tìm thấy sản phẩm tương ứng trong database
                            if (prd != null) {
                    %>
                                <!-- Bắt đầu phần giao diện của 1 Item trong giỏ hàng -->
                                <div class="cart-item border-bottom py-3">
                                    <div class="row align-items-center">
                                        <!-- Cột 1: Checkbox & Ảnh -->
                                        <div class="col-4 col-md-2 d-flex align-items-center gap-2">
                                            <!-- Thay link ảnh fix cứng bằng link ảnh lấy từ database (Giả sử prd có thuộc tính image_url) -->
                                            <img src="<%= prd.getThumbnail_url() %>" 
                                                 class="img-fluid rounded border p-1" alt="<%= prd.getName() %>" style="width: 80px; height: 80px; object-fit: contain;">
                                        </div>

                                        <!-- Cột 2: Thông tin sản phẩm -->
                                        <div class="col-8 col-md-5">
                                            <!-- Hiển thị tên sản phẩm -->
                                            <h6 class="text-truncate mb-1" style="font-size: 15px; color: #333;"><%= prd.getName() %></h6>

                                            <!-- Hiển thị giá sản phẩm -->
                                            <div class="fw-bold fs-5" style="color: var(--gearvn-red, #ff6600);">
                                                <%= ord.getFormattedTotalPrice() %>
                                            </div>
                                        </div>

                                        <!-- Cột 3: Số lượng & Nút thao tác -->
                                        <div class="col-12 col-md-5 d-flex align-items-center justify-content-between justify-content-md-end gap-3 mt-3 mt-md-0">
                                            <!-- Bộ chọn số lượng -->
                                            <div class="input-group input-group-sm" style="width: 100px;">
                                                <!-- Nút Trừ -->
                                                <a href="MainController?action=decreaseAmountPrdOrder&orderId=<%= ord.getOrder_id()%>" class="btn btn-outline-secondary">-</a>

                                                <!-- Hiển thị số lượng -->
                                                <input type="text" class="form-control text-center" value="<%= ord.getQuantity() %>" readonly>

                                                <!-- Nút Cộng -->
                                                <a href="MainController?action=increaseAmountPrdOrder&orderId=<%= ord.getOrder_id() %>" class="btn btn-outline-secondary">+</a>
                                            </div>
                                            
                                            <div class="d-flex gap-2">
                                                <!-- Nút xóa (Bạn có thể bọc Form hoặc gắn href chứa Order ID để gọi Controller xử lý xóa) -->
                                                <%
                                                    if(!ord.getOrder_status().equals("CONFIRMED")){
                                                %>
                                                <a href="MainController?action=deleteOrder&orderId=<%= ord.getOrder_id() %>" class="btn btn-sm btn-outline-secondary border-0" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                                <% } %>

                                                <!-- Nút Mua hàng riêng lẻ -->
                                                <%
                                                    // Lấy trạng thái của đơn hàng (giả định hàm getter của ông là getOrder_status())
                                                    String status = ord.getOrder_status(); 

                                                    // Kiểm tra trạng thái processing hoặc proccessing (không phân biệt hoa/thường)
                                                    if ("processing".equalsIgnoreCase(status) || "proccessing".equalsIgnoreCase(status)) {
                                                %>
                                                    <!-- Nút Thanh toán (Giữ nguyên như cũ) -->
                                                    <button type="button" class="btn btn-sm text-white fw-bold px-3"
                                                            style="background-color: var(--gearvn-red, #ff6600); border-radius: 4px;"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#paymentModal"
                                                            data-order-id="<%= ord.getOrder_id() %>"
                                                            data-product-name="<%= prd.getName() %>"
                                                            data-price="<%= ord.getFormattedTotalPrice() %>">
                                                        Thanh toán
                                                    </button>
                                                <%
                                                    } else if ("CONFIRMED".equalsIgnoreCase(status)) {
                                                %>
                                                    <!-- Nút Đã xác nhận (Xám xịt, không hover, không click được) -->
                                                    <button type="button" class="btn btn-sm fw-bold px-3 text-secondary"
                                                            style="background-color: #e9ecef; border: 1px solid #ced4da; border-radius: 4px; cursor: not-allowed;"
                                                            disabled>
                                                        Đã xác nhận đơn hàng
                                                    </button>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Kết thúc phần giao diện của 1 Item -->
                    <%
                            } // Đóng if (prd != null)
                        } // Đóng vòng lặp for
                    } //đóng if check orders
                    %>
                </div>
        <%
            } else { 
                // NẾU USER NULL, CHỈ HIỂN THỊ DÒNG CHỮ NÀY, KHÔNG CÓ BẤT KỲ THẺ DIV NÀO KHÁC
        %>
                <span style="color: red; font-size: 24px; font-weight: bold;">Quay về trang đăng nhập để xem giỏ hàng của bạn</span>
        <%
            }
        %>
        
        <!-- Modal Thanh Toán -->
        <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title fw-bold" id="paymentModalLabel">Xác nhận thanh toán</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <!-- Form xử lý thanh toán gửi về Servlet -->
              <form action="MainController" method="POST" enctype="multipart/form-data">
                <div class="modal-body">
                    <input type="hidden" name="action" value="updateOrderStatus">
                    <input type="hidden" name="orderId" id="modalOrderId" value="">

                    <p>Bạn đang thanh toán cho sản phẩm:</p>
                    <h6 id="modalProductName" class="fw-bold text-primary"></h6>
                    <div class="d-flex justify-content-between mt-3">
                        <span>Tổng tiền:</span>
                        <span id="modalPrice" class="fw-bold fs-5" style="color: var(--gearvn-red, #ff6600);"></span>
                    </div>

                    <hr>
                    <!-- Thêm các input nhập địa chỉ, sđt, phương thức thanh toán ở đây -->
                    <!-- THÊM Ô NHẬP ĐỊA CHỈ GIAO HÀNG TẠI ĐÂY -->
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
        
        <!-- Script -->
        <script src="assets/js/payment_form.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bỏ comment nếu bạn cần link tới file JS riêng của bạn -->
         <script src="assets/js/script.js"></script>
    </body>
</html>