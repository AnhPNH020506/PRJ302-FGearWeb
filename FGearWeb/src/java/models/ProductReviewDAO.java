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
public class ProductReviewDAO {

    public ProductReviewDAO() {
    }
    
    public ArrayList<ProductReviewDTO> searchReviewAll(String column, String id) {
        ArrayList<ProductReviewDTO> result = new ArrayList<>();
        
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT pr.*, u.username " 
                        + "FROM ProductReviews pr " 
                        + "JOIN users u ON pr.user_id = u.user_id " 
                        + "WHERE pr." + column + " = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            ResultSet rs =  pst.executeQuery();
            //
            while(rs.next()){
                int review_id = rs.getInt("review_id");
                String product_id = rs.getString("product_id");
                String user_id = rs.getString("user_id");
                int rating = rs.getInt("rating");
                String content = rs.getString("content");
                String image_url = rs.getString("image_url");
                String parent_id = rs.getString("parent_id");
                // 2. LẤY DATE BẰNG TIMESTAMP (giữ nguyên giờ:phút:giây.mili-giây)
                java.sql.Timestamp created_at = rs.getTimestamp("created_at");
                String username = rs.getString("username");

                // Tạo đối tượng ProductDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                ProductReviewDTO rev = new ProductReviewDTO(review_id, product_id, user_id, rating, content, image_url, parent_id, created_at, username);
                result.add(rev);
            }
            
            if (pst != null) pst.close();
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return result;
    }
    public ArrayList<ProductReviewDTO> filterByName(String id) {
        return searchReviewAll("product_id", id);
    }
}
