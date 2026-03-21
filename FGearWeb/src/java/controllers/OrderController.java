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
