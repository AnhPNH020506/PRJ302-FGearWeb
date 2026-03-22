/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.ProductDAO;
import models.ProductDTO;
import models.ProductReviewDAO;

/**
 *
 * @author AD
 */
public class ProductReviewController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doAddProductReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String reviewImage = (String)request.getAttribute("reviewImagePath");
        String reviewContent = request.getParameter("reviewContent");
        int ratingValue = Integer.parseInt(request.getParameter("ratingValue"));
        String productId = request.getParameter("productId");
        String user_id = request.getParameter("user_id");
        
        //SỬA DẤU - LỖI FONT KHI VIẾT DẤU
        reviewContent = new String(reviewContent.getBytes("ISO-8859-1"), "UTF-8");
        System.out.println(reviewContent + " " + ratingValue + " " + productId + " " + user_id);
        String error = "";
        String msg = "";
        
        ProductReviewDAO pdao = new ProductReviewDAO();
        if (pdao.addProductReview(reviewContent, ratingValue, productId, user_id, reviewImage)) {
            System.out.println("Hàm add productReview đã thành công");
            msg = "bình luận thành công";
        } else {
            System.out.println("add productReview ĐÃ THẤT BẠI");
            error = "Error";
            request.setAttribute("error", error);
        }
        
        //Chuyển trang
        RequestDispatcher rd = request.getRequestDispatcher("MainController?action=ShowProductDetail&id=" + productId);
        rd.forward(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        System.out.println("action ở ProductReviewController: " + action);
        if(action.equals("commentReview")){
            doAddProductReview(request,response);
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
