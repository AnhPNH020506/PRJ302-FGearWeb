/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.UserDAO;
import models.UserDTO;
import utils.EmailUtils;
import utils.HashPasswordUtils;

/**
 *
 * @author DELL
 */
public class UserController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String url = "";
        HttpSession session = request.getSession();

//        System.out.println(request.getServletPath())
        String action = request.getParameter("action");
        System.out.println(action);

        if (action.equals("login") && session.getAttribute("user") == null) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            String hashedPassword = HashPasswordUtils.hashPassword(password);
            
            UserDAO udao = new UserDAO();
            UserDTO user = udao.login(email, hashedPassword);

            if (user != null) {
                url =  "index.jsp";
                session.setAttribute("user", user);
            } else {
                url = "login.jsp";
                request.setAttribute("error", "Invalid email or password");
            }
//            session.setAttribute("user", user) DÒNG NÀY QUAN TRỌNG
        }/*REGISTER*/ else if (action.equals("register")) {
            String email = request.getParameter("email");
            String name = request.getParameter("nameRegister");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirmPassword");
            UserDAO udao = new UserDAO();
            if (!password.equals(confirm)) {
                request.setAttribute("message", "Mật khẩu không trùng khớp ");
                //GIỮ LẠI DỮ LIỆU 
                request.setAttribute("email", email);
                request.setAttribute("nameRegister", name);
                url = "register.jsp";
            } else {
                String hashedPassword = HashPasswordUtils.hashPassword(password);

                boolean check = udao.register(email, name, hashedPassword);

                if (check) {

                    // gửi mail async (không làm chậm web)
                    new Thread(() -> {
                        try {

                            String subject = "Welcome to FGear 🎉";

                            String content
                                    = "Xin chào " + name + ",\n\n"
                                    + "Tài khoản của bạn đã được đăng ký thành công tại FGear.\n\n"
                                    + "Bạn có thể đăng nhập và bắt đầu mua sắm.\n\n"
                                    + "Trân trọng,\n"
                                    + "FGear Team";
                            EmailUtils.sendEmail(email, subject, content);

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }).start();

                    request.setAttribute("success", "Đăng kí thành công! Hãy kiểm tra email.");
                    url = "login.jsp";

                } else {
                    request.setAttribute("error", "Đăng kí không thành công");
                    url = "register.jsp";
                }
            }
        }/*LOGOUT*/ else if (action.equals("logout")) {
            session.invalidate();
            //url = "index.jsp";
            response.sendRedirect("index.jsp");
            return;
        }

        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
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
        HttpSession session = request.getSession();
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
//        response.setContentType("text/html;charset=UTF-8");
//        request.setCharacterEncoding("UTF-8");
//        response.setCharacterEncoding("UTF-8");
//        
//        String url = "";
//        HttpSession session = request.getSession();
//        
////        System.out.println(request.getServletPath())
//        String action = request.getParameter("action");
//        System.out.println(action);
//        
//        if (action.equals("login") && session.getAttribute("user") == null) {
//            String email = request.getParameter("email");
//            String password = request.getParameter("password");
//            //
//            UserDAO udao = new UserDAO();
//            UserDTO user = udao.login(email, password);
//            
//            if (user != null) {
//                url = "index.jsp";
//                session.setAttribute("user", user);
//            } else {
//                url = "login.jsp";
//                request.setAttribute("message", "Invalid email or password");
//            }
////            session.setAttribute("user", user) DÒNG NÀY QUAN TRỌNG
//        } else if (action.equals("logout")) {
//            session.invalidate();
//            url = "index.jsp";
//        }
//        
//        RequestDispatcher rd = request.getRequestDispatcher(url);
//        rd.forward(request, response);
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
