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
    public OrdersDTO findOrderByProductId(String product_id_param) { 
        OrdersDTO res = null;
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM orders WHERE product_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, product_id_param);
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
