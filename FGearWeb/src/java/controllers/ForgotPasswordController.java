package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import models.UserDAO;
import utils.EmailUtils;
import utils.HashPasswordUtils;

public class ForgotPasswordController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equals("sendCode")) {
            sendCode(request, response);
        }

        if (action.equals("verifyCode")) {
            verifyCode(request, response);
        }

        if (action.equals("resetPassword")) {
            resetPassword(request, response);
        }
    }

    private void sendCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        UserDAO dao = new UserDAO();

        // kiểm tra email tồn tại
        if (!dao.checkEmail(email)) {

            request.setAttribute("msg", "Email not found!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        // tạo code 4 số
        String code = String.valueOf((int) (Math.random() * 9000) + 1000);

        HttpSession session = request.getSession();

        session.setAttribute("resetCode", code);
        session.setAttribute("resetEmail", email);

        // lưu thời gian tạo code
        session.setAttribute("codeTime", System.currentTimeMillis());

        try {

            EmailUtils.sendEmail(email, "Your verification code", "Your code is: " + code);

            request.setAttribute("msg", "Verification code sent to your email!");
            request.getRequestDispatcher("verifyCode.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void verifyCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String realCode = (String) session.getAttribute("resetCode");
        String userCode = request.getParameter("code");

        long codeTime = (long) session.getAttribute("codeTime");

        //  code hết hạn 5 phút
        if (System.currentTimeMillis() - codeTime > 5 * 60 * 1000) {

            request.setAttribute("msg", "Code expired! Please request again.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        if (userCode.equals(realCode)) {

            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);

        } else {

            request.setAttribute("msg", "Wrong verification code!");
            request.getRequestDispatcher("verifyCode.jsp").forward(request, response);

        }
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        //  kiểm tra có qua bước verify chưa
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {

            response.sendRedirect("forgotPassword.jsp");
            return;
        }

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        //  kiểm tra độ dài mật khẩu
        if (password.length() < 6 || password.length() > 20) {

            request.setAttribute("msg", "Password must be 6-20 characters!");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        //  kiểm tra confirm password
        if (!password.equals(confirmPassword)) {

            request.setAttribute("msg", "Confirm password does not match!");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        String hashed = HashPasswordUtils.hashPassword(password);
        boolean check = dao.updatePassword(email, hashed);

        if (check) {

            //  xóa session reset
            session.removeAttribute("resetCode");
            session.removeAttribute("resetEmail");
            session.removeAttribute("codeTime");

            request.setAttribute("msg", "Password changed successfully!");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } else {

            request.setAttribute("msg", "Error updating password!");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);

        }
    }
}
