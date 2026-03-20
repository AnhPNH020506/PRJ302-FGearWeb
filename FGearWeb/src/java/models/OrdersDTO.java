/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.text.NumberFormat;
import java.util.Locale;

/**
 *
 * @author DELL
 */
public class OrdersDTO {
    private String order_id;
    private String shipping_address;
    private double total_price; 
    private double shipping_fee; 
    private String payment_method;
    private String payment_status;
    private String order_status;
    private String created_at;
    private String user_id;
    private String shipper_id;
    private String promotion_id;
    private int quantity;
    private String product_id;

    public OrdersDTO() {
    }

    public OrdersDTO(String order_id, String shipping_address, double total_price, double shipping_fee, String payment_method, String payment_status, String order_status, String created_at, String user_id, String shipper_id, String promotion_id, int quantity, String product_id) {
        this.order_id = order_id;
        this.shipping_address = shipping_address;
        this.total_price = total_price;
        this.shipping_fee = shipping_fee;
        this.payment_method = payment_method;
        this.payment_status = payment_status;
        this.order_status = order_status;
        this.created_at = created_at;
        this.user_id = user_id;
        this.shipper_id = shipper_id;
        this.promotion_id = promotion_id;
        this.quantity = quantity;
        this.product_id = product_id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public String getShipping_address() {
        return shipping_address;
    }

    public double getTotal_price() {
        return total_price;
    }

    public double getShipping_fee() {
        return shipping_fee;
    }

    public String getPayment_method() {
        return payment_method;
    }

    public String getPayment_status() {
        return payment_status;
    }

    public String getOrder_status() {
        return order_status;
    }

    public String getCreated_at() {
        return created_at;
    }

    public String getUser_id() {
        return user_id;
    }

    public String getShipper_id() {
        return shipper_id;
    }

    public String getPromotion_id() {
        return promotion_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getProduct_id() {
        return product_id;
    }
    
    //SETTERS
    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public void setShipping_address(String shipping_address) {
        this.shipping_address = shipping_address;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    public void setShipping_fee(double shipping_fee) {
        this.shipping_fee = shipping_fee;
    }

    public void setPayment_method(String payment_method) {
        this.payment_method = payment_method;
    }

    public void setPayment_status(String payment_status) {
        this.payment_status = payment_status;
    }

    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public void setShipper_id(String shipper_id) {
        this.shipper_id = shipper_id;
    }

    public void setPromotion_id(String promotion_id) {
        this.promotion_id = promotion_id;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }
    
    public String formatCurrency(double amount) {
        // Tạo Locale cho Việt Nam để có dấu chấm (.) phân cách hàng nghìn
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat currencyFormatter = NumberFormat.getInstance(localeVN);

        // Format số và cộng thêm ký hiệu ₫ vào cuối
        return currencyFormatter.format(amount) + "₫";
    }
    
    public String getFormattedTotalPrice() {
        return formatCurrency(this.total_price);
    }
}
