<%-- 
    Document   : verifyCode
    Created on : Mar 14, 2026, 4:16:54 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Verify Code</h2>

        <form action="MainController" method="post">

            <input type="hidden" name="action" value="verifyCode">

            Code:
            <input type="text" name="code" required>

            <button type="submit">Verify</button>

        </form>

        ${msg}
    </body>
</html>
