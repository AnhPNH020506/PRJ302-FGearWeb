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
    protected void doShowAllProductsByCategory(HttpServletRequest request, HttpServletResponse response)
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

    protected void doShowProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        //
        String keyword = request.getParameter("id");
        ProductDAO pDao = new ProductDAO();
        ProductDTO result = pDao.findSpecificProductById(keyword);
        String url = "";
        if (result == null) {
            url = "error.jsp";
        } else {
            url = "product.jsp";
            request.setAttribute("product", result);
//            System.out.println(request.getAttribute("products"));
        }

        //Chuyển trang
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }

    protected void doUpdateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // đảm bảo encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String id = request.getParameter("product_id");
        String name = request.getParameter("name");

        // parse số an toàn
        int price = 0;
        String priceStr = request.getParameter("price");
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                price = Integer.parseInt(priceStr);
            } catch (NumberFormatException e) {
                System.out.println("Invalid price input: " + priceStr);
            }
        }

        int sale_price = 0;
        String saleStr = request.getParameter("sale_price");
        if (saleStr != null && !saleStr.trim().isEmpty()) {
            try {
                sale_price = Integer.parseInt(saleStr);
            } catch (NumberFormatException e) {
                System.out.println("Invalid sale_price input: " + saleStr);
            }
        }

        String thumbnail = request.getParameter("thumbnail_url");
        String brand = request.getParameter("brand");
        String status = request.getParameter("status");
        String spec = request.getParameter("specifications");

        // tạo DTO
        ProductDTO p = new ProductDTO();
        p.setProduct_id(id);
        p.setName(name);
        p.setPrice(price);
        p.setSale_price(sale_price);
        p.setThumbnail_url(thumbnail);
        p.setBrand(brand);
        p.setStatus(status);
        p.setSpecifications(spec);

        ProductDAO dao = new ProductDAO();

        if (dao.updateProduct(p)) {
            System.out.println("UPDATE PRODUCT SUCCESS");
        } else {
            System.out.println("UPDATE PRODUCT FAIL");
        }

        // redirect về admin
        response.sendRedirect("MainController?action=admin&view=products");
        return;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        //
        String action = request.getParameter("action");
        if (action.equals("ShowProduct")) {
            doShowAllProductsByCategory(request, response);
        } else if (action.equals("ShowProductDetail")) {
            doShowProductDetail(request, response);
        } else if (action.equals("deleteProduct")) {
            new ProductDAO().deleteProduct(request.getParameter("id"));
            response.sendRedirect("MainController?action=admin&view=products");
            return;
        } else if (action.equals("updateProduct")) {
            doUpdateProduct(request, response);
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
