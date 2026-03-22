/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.OrdersDAO;
import models.OrdersDTO;
import models.ProductDAO;
import models.ProductDTO;
import models.UserDTO;

/**
 *
 * @author AD
 */
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doAddNewOrderMuaNgay(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        //
        String user_id = request.getParameter("userId");
        String product_id = request.getParameter("productId");
        
        OrdersDAO oDao = new OrdersDAO();
        ArrayList<OrdersDTO> result = null; //XÍU CODE LẠI
        String url = "";
        if (result == null) {
            url = "error.jsp";
        } else {
            url = "product.jsp";
            request.setAttribute("products", result);
            System.out.println(request.getAttribute("products"));
        }
        
        //Chuyển trang
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
    
    protected void doAddProductToOrderGioHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //
        String error = "";
        String msg = "" ;
        String product_id = (String)request.getParameter("productId");
        String user_id = (String)request.getParameter("userId");
        System.out.println("CHECK THỬ PRODUCT ID TRONG ORDERCONTROLLER NÈ: " + product_id + " " + user_id);
        
        OrdersDAO odao = new OrdersDAO();
        OrdersDTO testFinding = odao.findOrderByProductId(product_id);
        System.out.println(testFinding);
        if (testFinding == null) {
            if (odao.addOrder(user_id, product_id)) {
                System.out.println("ADD THÀNH CÔNG");
                msg = "Added to Cart Successfully";
            } else {
                error = "Lỗi hệ thống: Không thể thêm vào database!";
                System.out.println("LỖI KHÔNG THỂ THÊM ORDER NÀY VÀO DATABASE");
            }
        } else {
            error = "Product existed in cart!";
            request.setAttribute("error", error);
            RequestDispatcher rd = request.getRequestDispatcher("MainController?action=ShowProductDetail&id=" + product_id);
            rd.forward(request, response);
        }
        //kết thúc
        String redirectUrl = "MainController?action=ShowProductDetail&id=" + product_id;
        // Nối thêm msg hoặc error vào URL
        if (!error.isEmpty()) {
            redirectUrl += "&error=" + java.net.URLEncoder.encode(error, "UTF-8");
        } else if (!msg.isEmpty()) {
            redirectUrl += "&msg=" + java.net.URLEncoder.encode(msg, "UTF-8");
        }
        response.sendRedirect(redirectUrl);
        return;
    }
    protected void doUpdateAmount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String order_id = (String)request.getParameter("orderId");
        String action = (String)request.getParameter("action");
        String url = "";
        System.out.println(order_id);
        
        OrdersDAO oDao = new OrdersDAO();
        if (action.equals("decreaseAmountPrdOrder")) {
            if(oDao.findSpecificOrderById(order_id).getQuantity() >= 2) {
                if(oDao.decreaseQuantity(order_id)) System.out.println("Update increse thành công");
                url = "cart.jsp";
            }
            url = "cart.jsp";
        } else if (action.equals("increaseAmountPrdOrder")) {
            if(oDao.increseQuantity(order_id)) System.out.println("Update decrease thành công");
            url = "cart.jsp";
        } 
        
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
    
    protected void doDeleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String order_id = (String)request.getParameter("orderId");
        String url = "";
        
        OrdersDAO oDao = new OrdersDAO();
        if (oDao.deleteOrder(order_id)){
            System.out.println("Delete thành công order");
            url = "cart.jsp";
        }
        
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
    
    protected void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String order_id = request.getParameter("orderId");
    String paymentMethod = request.getParameter("paymentMethod");
    String shipping_address = request.getParameter("shippingAddress");
    String receipt = request.getParameter("receipt"); // lấy từ form

    OrdersDAO oDao = new OrdersDAO();
    boolean ok = false;

    if ("COD".equals(paymentMethod)) {
        ok = oDao.updateCODStatus(order_id, shipping_address);
    } else if ("BANK".equals(paymentMethod)) {
        ok = oDao.updateBANKStatus(order_id, shipping_address, receipt);
    }

    if (ok) {
        System.out.println("UPDATE ORDER SUCCESS");
    } else {
        System.out.println("UPDATE ORDER FAIL");
    }

    // redirect về trang admin orders
    response.sendRedirect("MainController?action=admin&view=orders");
}

    protected void doBuyNow(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String product_id = (String)request.getParameter("productId");
        String user_id = (String)request.getParameter("userId");
        String payment_method = (String)request.getParameter("paymentMethod");
        String shipping_address = (String)request.getParameter("shippingAddress");
        String receipt = (String)request.getAttribute("receipt"); 
        String url = ""; //product.jsp
        String msg = "";
        String error = "";
        
        OrdersDAO oDao = new OrdersDAO();
        if(payment_method.equals("COD")) {
            if(oDao.addCODOrder(product_id, user_id, shipping_address)){
                System.out.println("ĐÃ MUA HÀNG THÀNH CÔNG");
                url = "index.jsp";
                msg = "Mua hàng thành công";
            } else {
                System.out.println("MUA HÀNG THẤT BẠI");
                error = "Mua hàng thất bại";
            }
        } else if (payment_method.equals("BANK")){
//            System.out.println("product_id: " + product_id);
//            System.out.println("user_id: " + user_id);
//            System.out.println("shipping_address: " + shipping_address);
//            System.out.println("receipt: " + receipt);
            if(oDao.addBANKOrder(product_id, user_id, shipping_address, receipt)){
                System.out.println("ĐÃ MUA HÀNG THÀNH CÔNG");
                url = "index.jsp";
                msg = "Mua hàng thành công";
            } else {
                System.out.println("MUA HÀNG THẤT BẠI");
                error = "Mua hàng thất bại";
            }
        }
        
        request.setAttribute("error", error);
        request.setAttribute("msg", msg);
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if(action.equals("addNewOrderMuaNgay")){
            doAddNewOrderMuaNgay(request,response);
        } else if (action.equals("addProductToOrderGioHang")){
            doAddProductToOrderGioHang(request,response);
        } else if (action.equals("decreaseAmountPrdOrder") || action.equals("increaseAmountPrdOrder")) {
            doUpdateAmount(request, response);
        } else if (action.equals("deleteOrder")){
            doDeleteOrder(request, response);
        } else if (action.equals("updateOrderStatus")){
            updateOrderStatus(request, response);
        } else if (action.equals("processOrderBuyNow")) {
            doBuyNow(request,response);
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
