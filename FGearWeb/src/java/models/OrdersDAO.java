/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utils.DbUtils;

/**
 *
 * @author AD
 */
public class OrdersDAO {

    public OrdersDAO() {
    }
    
    //METHODS
    
        //delete
    public boolean deleteOrder(String order_id) {
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();
            // Lệnh SQL cập nhật giảm quantity đi 1 đơn vị
            String sql = "DELETE FROM orders WHERE order_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán giá trị order_id vào dấu ?
            ps.setString(1, order_id);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }
    
        //update
    public boolean updateBANKStatus(String order_id, String shipping_address, String receipt) {
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();
            // Lệnh SQL cập nhật giảm quantity đi 1 đơn vị
            String sql = "UPDATE orders SET payment_method = 'BANK', payment_status = 'DONE', order_status = 'CONFIRMED', shipping_address = ?, receipt = ? WHERE order_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán giá trị vào dấu ? theo đúng thứ tự
            ps.setString(1, shipping_address);
            ps.setString(2, receipt);
            ps.setString(3, order_id);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }
    public boolean updateCODStatus(String order_id, String shipping_address) {
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();
            // Lệnh SQL cập nhật giảm quantity đi 1 đơn vị
            String sql = "UPDATE orders SET payment_method = 'COD', order_status = 'CONFIRMED', shipping_address = ? WHERE order_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán giá trị vào dấu ? theo đúng thứ tự
            ps.setString(1, shipping_address);
            ps.setString(2, order_id);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }
    public boolean decreaseQuantity(String order_id) {
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();
            // Lệnh SQL cập nhật giảm quantity đi 1 đơn vị
            String sql = "UPDATE orders SET quantity = quantity - 1 WHERE order_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán giá trị order_id vào dấu ?
            ps.setString(1, order_id);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }

    public boolean increseQuantity(String order_id) {
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();
            // Lệnh SQL cập nhật tăng quantity lên 1 đơn vị
            String sql = "UPDATE orders SET quantity = quantity + 1 WHERE order_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán giá trị order_id vào dấu ?
            ps.setString(1, order_id);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }
    
    public OrdersDTO findSpecificOrderById(String order_id_param){
        OrdersDTO res = null;
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM orders WHERE order_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, order_id_param);
            ResultSet rs =  pst.executeQuery();
            while(rs.next()){
                // Truy xuất dữ liệu từ ResultSet dựa theo các field của OrdersDTO
                String order_id = rs.getString("order_id");
                String shipping_address = rs.getString("shipping_address");
                double total_price = rs.getDouble("total_price");
                double shipping_fee = rs.getDouble("shipping_fee");
                String payment_method = rs.getString("payment_method");
                String payment_status = rs.getString("payment_status");
                String order_status = rs.getString("order_status");
                String created_at = rs.getString("created_at");
                String db_user_id = rs.getString("user_id");
                String shipper_id = rs.getString("shipper_id");
                String promotion_id = rs.getString("promotion_id");
                int quantity = rs.getInt("quantity");
                String product_id = rs.getString("product_id");

                // Tạo đối tượng OrdersDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                res = new OrdersDTO(order_id, shipping_address, total_price, 
                                    shipping_fee, payment_method, payment_status, 
                                    order_status, created_at, db_user_id, 
                                    shipper_id, promotion_id, quantity, product_id);
            }
            if (pst != null) pst.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        //kết quả
        if (res == null){
            return null;
        } else {
            return res;
        }
    }
        //add
    public boolean addCODOrder(String product_id, String user_id, String shipping_address){
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();

            // Lệnh SQL insert đủ 4 cột và set cứng order_status là CONFIRMED
            // Giả định cột lưu địa chỉ trong database của bạn tên là shipping_address
            String sql = "INSERT INTO orders (product_id, user_id, payment_method, shipping_address, order_status) VALUES (?, ?, 'COD', ?, 'CONFIRMED')";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán 4 giá trị vào dấu ? theo đúng thứ tự
            ps.setString(1, product_id);
            ps.setString(2, user_id);
            ps.setString(3, shipping_address);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }
    public boolean addBANKOrder(String product_id, String user_id, String shipping_address, String receipt){
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();

            // Lệnh SQL insert đủ 4 cột và set cứng order_status là CONFIRMED
            // Giả định cột lưu địa chỉ trong database của bạn tên là shipping_address
            String sql = "INSERT INTO orders (product_id, user_id, payment_method, shipping_address, order_status, receipt) VALUES (?, ?, 'BANK', ?, 'CONFIRMED', ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán 4 giá trị vào dấu ? theo đúng thứ tự
            ps.setString(1, product_id);
            ps.setString(2, user_id);
            ps.setString(3, shipping_address);
            ps.setString(4, receipt);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }
    
//    public boolean addBuyNowOrder(String product_id, String user_id, String payment_method, String shipping_address) {
//        int result = 0;
//        try {
//            Connection conn = DbUtils.getConnection();
//
//            // Lệnh SQL insert đủ 4 cột và set cứng order_status là CONFIRMED
//            // Giả định cột lưu địa chỉ trong database của bạn tên là shipping_address
//            String sql = "INSERT INTO orders (product_id, user_id, payment_method, shipping_address, order_status) VALUES (?, ?, ?, ?, 'CONFIRMED')";
//            PreparedStatement ps = conn.prepareStatement(sql);
//
//            // Gán 4 giá trị vào dấu ? theo đúng thứ tự
//            ps.setString(1, product_id);
//            ps.setString(2, user_id);
//            ps.setString(3, payment_method);
//            ps.setString(4, shipping_address);
//
//            result = ps.executeUpdate();
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//        }
//        return result > 0;
//    }
    
    public boolean addOrder(String user_id, String product_id) {
        int result = 0;
        try {
            Connection conn = DbUtils.getConnection();
            // Lệnh SQL chỉ insert vào 2 cột tương ứng
            String sql = "INSERT INTO orders(user_id, product_id) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Gán 2 giá trị vào dấu ?
            ps.setString(1, user_id);
            ps.setString(2, product_id);

            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result > 0;
    }
    public OrdersDTO findOrderByProductId(String product_id_param, String user_id_param) { 
        OrdersDTO res = null;
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM orders WHERE product_id=? and user_id= ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, product_id_param);
            pst.setString(1, user_id_param);
            ResultSet rs =  pst.executeQuery();
            while(rs.next()){
                // Truy xuất dữ liệu từ ResultSet dựa theo các field của OrdersDTO
                String order_id = rs.getString("order_id");
                String shipping_address = rs.getString("shipping_address");
                double total_price = rs.getDouble("total_price");
                double shipping_fee = rs.getDouble("shipping_fee");
                String payment_method = rs.getString("payment_method");
                String payment_status = rs.getString("payment_status");
                String order_status = rs.getString("order_status");
                String created_at = rs.getString("created_at");
                String db_user_id = rs.getString("user_id");
                String shipper_id = rs.getString("shipper_id");
                String promotion_id = rs.getString("promotion_id");
                int quantity = rs.getInt("quantity");
                String product_id = rs.getString("product_id");

                // Tạo đối tượng OrdersDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                res = new OrdersDTO(order_id, shipping_address, total_price, 
                                    shipping_fee, payment_method, payment_status, 
                                    order_status, created_at, db_user_id, 
                                    shipper_id, promotion_id, quantity, product_id);
            }
            if (pst != null) pst.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        //kết quả
        if (res == null){
            return null;
        } else {
            return res;
        }
    }
    
    public ArrayList<OrdersDTO> searchAllOrdersByUserId(String user_id) { 
        ArrayList<OrdersDTO> res = new ArrayList<>();
        
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM orders WHERE user_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, user_id);
            ResultSet rs =  pst.executeQuery();
            
            while(rs.next()){
                // Truy xuất dữ liệu từ ResultSet dựa theo các field của OrdersDTO
                String order_id = rs.getString("order_id");
                String shipping_address = rs.getString("shipping_address");
                double total_price = rs.getDouble("total_price");
                double shipping_fee = rs.getDouble("shipping_fee");
                String payment_method = rs.getString("payment_method");
                String payment_status = rs.getString("payment_status");
                String order_status = rs.getString("order_status");
                String created_at = rs.getString("created_at");
                String db_user_id = rs.getString("user_id");
                String shipper_id = rs.getString("shipper_id");
                String promotion_id = rs.getString("promotion_id");
                int quantity = rs.getInt("quantity");
                String product_id = rs.getString("product_id");

                // Tạo đối tượng OrdersDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                OrdersDTO order = new OrdersDTO(order_id, shipping_address, total_price, 
                                                shipping_fee, payment_method, payment_status, 
                                                order_status, created_at, db_user_id, 
                                                shipper_id, promotion_id, quantity, product_id);

                // Thêm vào list kết quả
                res.add(order);
            }
            if (pst != null) pst.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        if (res.isEmpty()){
            return null;
        } else {
            return res;
        }
    }
    
    public ArrayList<OrdersDTO> addToCart(String user_id) { 
        ArrayList<OrdersDTO> res = new ArrayList<>();
        
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM orders WHERE user_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, user_id);
            ResultSet rs =  pst.executeQuery();
            
            while(rs.next()){
                // Truy xuất dữ liệu từ ResultSet dựa theo các field của OrdersDTO
                String order_id = rs.getString("order_id");
                String shipping_address = rs.getString("shipping_address");
                double total_price = rs.getDouble("total_price");
                double shipping_fee = rs.getDouble("shipping_fee");
                String payment_method = rs.getString("payment_method");
                String payment_status = rs.getString("payment_status");
                String order_status = rs.getString("order_status");
                String created_at = rs.getString("created_at");
                String db_user_id = rs.getString("user_id");
                String shipper_id = rs.getString("shipper_id");
                String promotion_id = rs.getString("promotion_id");
                int quantity = rs.getInt("quantity");
                String product_id = rs.getString("product_id");

                // Tạo đối tượng OrdersDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                OrdersDTO order = new OrdersDTO(order_id, shipping_address, total_price, 
                                                shipping_fee, payment_method, payment_status, 
                                                order_status, created_at, db_user_id, 
                                                shipper_id, promotion_id, quantity, product_id);

                // Thêm vào list kết quả
                res.add(order);
            }
            if (pst != null) pst.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        if (res.isEmpty()){
            return null;
        } else {
            return res;
        }
    }
}
