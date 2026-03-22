package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import models.*;

@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // check admin
        if (user == null || user.getRole() != 0) {
            response.sendRedirect("index.jsp");
            return;
        }

        String view = request.getParameter("view");

        try {
            if ("users".equals(view)) {
                UserDAO dao = new UserDAO();
                List<UserDTO> list = dao.getAllUsers();
                request.setAttribute("users", list);

            } else if ("products".equals(view)) {
                ProductDAO dao = new ProductDAO();
                List<ProductDTO> list = dao.getAllProducts();
                request.setAttribute("products", list);

            } else if ("orders".equals(view)) {
                OrdersDAO dao = new OrdersDAO();
                List<OrdersDTO> list = dao.addToCart(user.getUserId()); // tạm dùng
                request.setAttribute("orders", list);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        processRequest(req, res);
    }
}