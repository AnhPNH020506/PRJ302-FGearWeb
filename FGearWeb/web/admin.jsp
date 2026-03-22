<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; display: flex; }
        .sidebar {
            width: 200px;
            background: #111;
            color: white;
            height: 100vh;
            padding: 20px;
        }
        .sidebar a {
            display: block;
            color: white;
            margin: 10px 0;
            text-decoration: none;
        }
        .content { flex: 1; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { border: 1px solid #ccc; padding: 10px; vertical-align: top; }
        .btn { padding: 5px 10px; border: none; cursor: pointer; }
        .btn-delete { background: red; color: white; }
        label { display: inline-block; width: 100px; font-weight: bold; }
        form input, form select { margin-bottom: 5px; }
    </style>
</head>

<body>

<div class="sidebar">
    <h3>ADMIN</h3>
    <a href="MainController?action=admin&view=users">Users</a>
    <a href="MainController?action=admin&view=products">Products</a>
    <a href="MainController?action=admin&view=orders">Orders</a>
</div>

<div class="content">

<!-- ================= USERS ================= -->
<c:if test="${empty users}">
    <c:redirect url="login.jsp"/>
</c:if>

<c:if test="${not empty users}">
    <h2>User List</h2>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Update Info</th><th>Delete</th>
        </tr>
        <c:forEach var="u" items="${users}">
            <tr>
                <td>${u.userId}</td>
                <td>${u.username}</td>
                <td>${u.email}</td>
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="updateUser"/>
                        <input type="hidden" name="user_id" value="${u.userId}"/>

                        <label>Username:</label><input name="username" value="${u.username}"/><br/>
                        <label>Email:</label><input name="email" value="${u.email}"/><br/>
                        <label>Contact:</label><input name="contact" value="${u.contact}"/><br/>
                        <label>Address:</label><input name="address" value="${u.address}"/><br/>
                        <label>Role:</label><input name="role" value="${u.role}" style="width:40px"/><br/>
                        <label>Status:</label><input name="status" value="${u.status}" style="width:60px"/><br/>

                        <button class="btn">Update</button>
                    </form>
                </td>
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="deleteUser"/>
                        <input type="hidden" name="id" value="${u.userId}"/>
                        <button class="btn btn-delete">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<!-- ================= PRODUCTS ================= -->
<c:if test="${not empty products}">
    <h2>Product List</h2>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Price</th><th>Update Info</th><th>Delete</th>
        </tr>
        <c:forEach var="p" items="${products}">
            <tr>
                <!-- hiển thị dữ liệu gốc -->
                <td>${p.product_id}</td>
                <td>${p.name}</td>
                <td>${p.price}</td>

                <!-- form update -->
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="updateProduct"/>
                        <input type="hidden" name="product_id" value="${p.product_id}"/>

                        <label>Name:</label>
                        <input name="name" value="${p.name}"/><br/>

                        <label>Price:</label>
                        <input name="price" value="${p.price}"/><br/>

                        <label>Sale Price:</label>
                        <input name="sale_price" value="${p.sale_price}"/><br/>

                        <label>Brand:</label>
                        <input name="brand" value="${p.brand}"/><br/>

                        <label>Status:</label>
                        <input name="status" value="${p.status}"/><br/>

                        <label>Image URL:</label>
                        <input name="thumbnail_url" value="${p.thumbnail_url}"/><br/>

                        <label>Specifications:</label>
                        <input name="specifications" value="${p.specifications}"/><br/>

                        <button class="btn">Update</button>
                    </form>
                </td>

                <!-- form delete -->
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="deleteProduct"/>
                        <input type="hidden" name="id" value="${p.product_id}"/>
                        <button class="btn btn-delete">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>


<!-- ================= ORDERS ================= -->
<c:if test="${not empty orders}">
    <h2>Order List</h2>
    <table>
        <tr>
            <th>ID</th><th>User</th><th>Product</th><th>Update Info</th><th>Delete</th>
        </tr>
        <c:forEach var="o" items="${orders}">
            <tr>
                <td>${o.order_id}</td>
                <td>${o.user_id}</td>
                <td>${o.product_id}</td>
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="updateOrderStatus"/>
                        <input type="hidden" name="orderId" value="${o.order_id}"/>

                        <label>Payment:</label>
                        <select name="paymentMethod">
                            <option value="COD" ${o.payment_method == 'COD' ? 'selected' : ''}>COD</option>
                            <option value="BANK" ${o.payment_method == 'BANK' ? 'selected' : ''}>BANK</option>
                        </select><br/>

                        <label>Shipping Address:</label>
                        <input name="shippingAddress" value="${o.shipping_address}"/><br/>

                        <!-- chỉ hiện receipt nếu là BANK -->
                        <c:if test="${o.payment_method == 'BANK'}">
                            <label>Receipt:</label>
                            <input name="receipt" value="${o.receipt}"/><br/>
                        </c:if>

                        <button class="btn">Update</button>
                    </form>
                </td>
                <td>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="deleteOrder"/>
                        <input type="hidden" name="orderId" value="${o.order_id}"/>
                        <button class="btn btn-delete">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>


</div>
</body>
</html>
