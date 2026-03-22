/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.nio.file.Paths;
import java.io.File;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import models.OrdersDAO;
import models.ProductDAO;
import models.UserDTO;
import models.UserDAO;

/**
 *
 * @author DELL
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 30, // Giới hạn file 10MB
        maxRequestSize = 1024 * 1024 * 50 // Giới hạn tổng request 50MB
)
public class MainController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        System.out.println("action ở MainController: " + action);
//        System.out.println("action2 ở MainController: " + action2);
        String url = "index.jsp";

        // CÁCH FIX: Check null trước khi làm bất cứ việc gì với biến action
        if (action == null) {
            // Nếu action null, cho nó về trang chủ hoặc báo lỗi nhẹ nhàng
            url = "index.jsp";
        } else {
            // Dùng so sánh ngược: "chuỗi".equals(biến) để không bao giờ bị NullPointer
            if (action.contains("Product") && !action.contains("Order")) {
                url = "ProductController";
            } else if (action.contains("Order")) {
                url = "OrderController";
            } else if ("admin".equals(action)) {
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");

                if (user == null || user.getRole() != 0) { // nhớ check lại role DB
                    System.out.println("KHÔNG PHẢI ADMIN → redirect login");
                    url = "login.jsp";
                } else {
                    System.out.println("ADMIN ĐĂNG NHẬP → vào AdminController");
                    url = "AdminController";
                }

                // ===================================================
            } else if ("requireLoginUser".equals(action)) {
                String productId = request.getParameter("productid");
                request.setAttribute("error", "You must login first");
                request.setAttribute("productId", productId);
                url = "login.jsp";
            } else if ("sendCode".equals(action) || "verifyCode".equals(action) || "resetPassword".equals(action)) {
                url = "ForgotPasswordController";
            } else if (action.equals("updateUser")) {
                url = "UserController";
            } else if (action.equals("updateProduct")) {
                url = "ProductController";
            } else if (action.equals("updateOrderStatus")) {
                url = "OrderController";
            } else if ("deleteUser".equals(action)) {
                String id = request.getParameter("id");
                new UserDAO().deleteUser(id);
                response.sendRedirect("MainController?action=admin&view=users");
                return;
            } else if ("deleteProduct".equals(action)) {
                String id = request.getParameter("id");
                new ProductDAO().deleteProduct(id);
                response.sendRedirect("MainController?action=admin&view=products");
                return;
            } else if ("deleteOrder".equals(action)) {
                String orderId = request.getParameter("orderId");
                new OrdersDAO().deleteOrder(orderId);
                response.sendRedirect("MainController?action=admin&view=orders");
                return;
            }

        }

        if (!response.isCommitted()) {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String paymentMethod = request.getParameter("paymentMethod");
        String paymentImgPath = null; // Biến để lưu đường dẫn ảnh nhét vào DB

        // NẾU KHÁCH CHỌN CHUYỂN KHOẢN THÌ MỚI ĐI TÌM ẢNH ĐỂ LƯU
        if ("BANK".equals(paymentMethod)) {
            // Lấy thẻ input có name="receiptImage"
            Part filePart = request.getPart("receiptImage");

            // Kiểm tra xem khách có chọn file thật không
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

                // 1. ĐƯỜNG DẪN ẢO CỦA SERVER (Để web hiện ảnh liền)
                String serverPath = getServletContext().getRealPath("/") + "assets" + File.separator + "img" + File.separator + "payment_image";
                File serverDir = new File(serverPath);
                if (!serverDir.exists()) {
                    serverDir.mkdirs();
                }

                // 2. ĐƯỜNG DẪN GỐC TRÊN MÁY BẠN (Lấy theo hình bạn gửi để không bị mất ảnh khi Clean & Build)
                String sourcePath = "C:\\Users\\AD\\Documents\\GitHub\\PRJ302-FGearWeb\\FGearWeb\\web\\assets\\img\\payment_image";
                File sourceDir = new File(sourcePath);
                if (!sourceDir.exists()) {
                    sourceDir.mkdirs();
                }

                // TIẾN HÀNH LƯU ẢNH VÀO SERVER TRƯỚC
                String fullServerFilePath = serverPath + File.separator + uniqueFileName;
                filePart.write(fullServerFilePath);

                // COPY ẢNH VỀ SOURCE GỐC ĐỂ BACKUP
                String fullSourceFilePath = sourcePath + File.separator + uniqueFileName;
                try {
                    java.nio.file.Files.copy(
                            Paths.get(fullServerFilePath),
                            Paths.get(fullSourceFilePath),
                            java.nio.file.StandardCopyOption.REPLACE_EXISTING
                    );
                    System.out.println("Đã backup ảnh an toàn vào Source code!");
                } catch (Exception e) {
                    System.out.println("Lỗi khi backup ảnh: " + e.getMessage());
                }

                // Chuẩn bị đường dẫn để lưu xuống Database (luôn là đường dẫn tương đối này)
                paymentImgPath = "assets/img/payment_image/" + uniqueFileName;
                request.setAttribute("receipt", paymentImgPath);
                System.out.println("Đường dẫn lưu Database: " + paymentImgPath);
            }
        }
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
