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
        %>
        
        <!-- NỘI DUNG GIỎ HÀNG CỦA BẠN SẼ CODE Ở ĐÂY -->
            
        <div class="container bg-white p-4 rounded shadow-sm mt-4 mb-4" style="max-width: 800px;">
        <!-- Tiêu đề giỏ hàng -->
            <%
                ProductDAO pDao = new ProductDAO();
                OrdersDAO oDao = new OrdersDAO();
                ArrayList<OrdersDTO> orders = oDao.searchAllOrdersByUserId(user.getUserId());

                // Bắt đầu vòng lặp ở đây
                
            %>
            <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                <h4 class="fw-bold m-0" style="color: #333;">Giỏ hàng của tôi</h4>
                <span class="text-muted"><%= orders.size() %> sản phẩm</span>
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
                                        <button class="btn btn-outline-secondary" type="button">-</button>
                                        <!-- Lấy số lượng thực tế từ đơn hàng (OrdersDTO) -->
                                        <input type="text" class="form-control text-center" value="<%= ord.getQuantity() %>" readonly>
                                        <button class="btn btn-outline-secondary" type="button">+</button>
                                    </div>

                                    <div class="d-flex gap-2">
                                        <!-- Nút xóa (Bạn có thể bọc Form hoặc gắn href chứa Order ID để gọi Controller xử lý xóa) -->
                                        <a href="MainController?action=deleteOrder&orderId=<%= ord.getOrder_id() %>" class="btn btn-sm btn-outline-secondary border-0" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>

                                        <!-- Nút Mua hàng riêng lẻ -->
                                        <button class="btn btn-sm text-white fw-bold px-3" style="background-color: var(--gearvn-red, #ff6600); border-radius: 4px;">
                                            Thanh toán
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Kết thúc phần giao diện của 1 Item -->
            <%
                    } // Đóng if (prd != null)
                } // Đóng vòng lặp for
            %>
        </div>
        
        <!-- Script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bỏ comment nếu bạn cần link tới file JS riêng của bạn -->
        <!-- <script src="assets/js/script.js"></script> -->
    </body>
</html>