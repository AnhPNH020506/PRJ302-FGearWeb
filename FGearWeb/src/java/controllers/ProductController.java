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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.ProductDAO;
import models.ProductDTO;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ProductController", urlPatterns = {"/products", "/products/show-by-subcategory"})
public class ProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doShowAllProductsByCategory (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        //
        String keyword = request.getParameter("keyword");
        ProductDAO pDao = new ProductDAO();
        ArrayList<ProductDTO> result = pDao.searchAllById(keyword);
        String url = "";
        if (result == null) {
            url = "error.jsp";
        } else {
            url = "pages.jsp";
            request.setAttribute("products", result);
            System.out.println(request.getAttribute("products"));
        }
        
        //Chuyển trang
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        //
        String action = request.getParameter("action");
        if(action.equals("ShowProduct")){
            doShowAllProductsByCategory(request, response);
        }
    }

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

        //Lấy đường dẫn user vừa gọi
//        String path = request.getServletPath();
//        switch (path) {
//            case "/products/show-by-subcategory":
//                //http://localhost:8080/FGearWeb/products/search?sub_id=SUB004
//                searchProductsBySubCategory(request, response);
//                break;
//            case "/products/find":
//                //http://localhost:8080/FGearWeb/products/find?product_id=
//                findSpecificProductByItsId(request, response);
//                System.out.println("Test xem có xuống được đây không, tìm kiếm sp cụ thể");
//                break;
//            default:
//                break;
//        }
        
        //Gọi hàm processRequest ở trên để xử lý tiếp
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
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
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
    
                //SUPPORTING METHODS
//    private void searchProductsBySubCategory(HttpServletRequest request, HttpServletResponse response) {
//        response.setContentType("text/plain;charset=UTF-8"); //hiện Tiếng Việt
//        
//        String sub_id = request.getParameter("sub_id");
//        
//        if (sub_id == null) {
//            sub_id = "";
//        }
//        
//        try {
//            PrintWriter out = response.getWriter();
//            ProductDAO dao = new ProductDAO();
//            ArrayList<ProductDTO> res = dao.searchBySubCategory(sub_id);
//            
//            if(res.isEmpty()) {
//                out.println("Không tìm thấy sản phẩm nào");
//            } else {
//                for (ProductDTO prd : res) {
//                    out.println(prd.toString());
//                }
//            }
//            
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
    
//    private void findSpecificProductByItsId(HttpServletRequest request, HttpServletResponse response) {
//        response.setContentType("text/plain;charset=UTF-8"); //hiện Tiếng Việt
//        
//        String product_id = request.getParameter("product_id");
//        
//        if (product_id == null) {
//            product_id = "";
//        }
//        
//        try {
//            PrintWriter out = response.getWriter();
//            ProductDAO dao = new ProductDAO();
//            ProductDTO res = dao.searchById(product_id);
//            
//            if(res == null) {
//                out.println("Không tìm thấy sản phẩm nào");
//            } else {
//               out.println(res.toString());
//            }
//            
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
}
