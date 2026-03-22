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
 * @author DELL
 */
public class ProductDAO {

    public ProductDAO() {
        //constructor
    }

    //SEARCH
    public ProductDTO findSpecificProductById(String id) {
        ProductDTO prd = null;

        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM product WHERE product_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            //  ->Dòng lệnh giúp biên dịch câu lệnh SQL
            pst.setString(1, id);
            //  ->set thêm id vào câu lệnh sql
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                String product_id = rs.getString("product_id");
                String name = rs.getString("name");
                int price = rs.getInt("price");
                int sale_price = rs.getInt("sale_price");
                String slug = rs.getString("slug");
                String thumbnail_url = rs.getString("thumbnail_url");
                int warranty_period = rs.getInt("warranty_period");
                String brand = rs.getString("brand");
                String status = rs.getString("status"); // Sửa thành String vì trong DB và DTO là String
                String specifications = rs.getString("specifications");
                String sub_id = rs.getString("sub_id");

                // Tạo đối tượng ProductDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                prd = new ProductDTO(product_id, name, price, sale_price, slug,
                        thumbnail_url, warranty_period, brand,
                        status, specifications, sub_id);
            }
            if (pst != null) {
                pst.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return prd;
    }

    public ArrayList<ProductDTO> searchAllById(String id) {
        ArrayList<ProductDTO> res = new ArrayList<>();

        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM product WHERE product_id LIKE ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            //  ->Dòng lệnh giúp biên dịch câu lệnh SQL
            pst.setString(1, "%" + id + "%");
            //  ->set thêm id vào câu lệnh sql
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                String product_id = rs.getString("product_id");
                String name = rs.getString("name");
                int price = rs.getInt("price");
                int sale_price = rs.getInt("sale_price");
                String slug = rs.getString("slug");
                String thumbnail_url = rs.getString("thumbnail_url");
                int warranty_period = rs.getInt("warranty_period");
                String brand = rs.getString("brand");
                String status = rs.getString("status"); // Sửa thành String vì trong DB và DTO là String
                String specifications = rs.getString("specifications");
                String sub_id = rs.getString("sub_id");

                // Tạo đối tượng ProductDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                ProductDTO prd = new ProductDTO(product_id, name, price, sale_price, slug,
                        thumbnail_url, warranty_period, brand,
                        status, specifications, sub_id);
                res.add(prd);
            }
            if (pst != null) {
                pst.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        if (res.isEmpty()) {
            return null;
        } else {
            return res;
        }
    }

    public ArrayList<ProductDTO> searchBySubCategory(String sub_id) {
        ArrayList<ProductDTO> result = new ArrayList<>();

        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM product WHERE sub_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, sub_id);
            System.out.println(pst);
            ResultSet rs = pst.executeQuery();
            //
            while (rs.next()) {
                String product_id = rs.getString("product_id");
                String name = rs.getString("name");
                int price = rs.getInt("price");
                int sale_price = rs.getInt("sale_price");
                String slug = rs.getString("slug");
                String thumbnail_url = rs.getString("thumbnail_url");
                int warranty_period = rs.getInt("warranty_period");
                String brand = rs.getString("brand");
                String status = rs.getString("status"); // Sửa thành String vì trong DB và DTO là String
                String specifications = rs.getString("specifications");
                String sub_id_prd = rs.getString("sub_id");

                // Tạo đối tượng ProductDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                ProductDTO prd = new ProductDTO(product_id, name, price, sale_price, slug,
                        thumbnail_url, warranty_period, brand,
                        status, specifications, sub_id_prd);
                result.add(prd);
            }

            if (pst != null) {
                pst.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return result;
    }

    //search product randomly
    public ArrayList<ProductDTO> searchProductRandomly() {
        ArrayList<ProductDTO> result = new ArrayList<>();

        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT TOP 15 * FROM product ORDER BY NEWID();";
            PreparedStatement pst = conn.prepareStatement(sql);
            System.out.println(pst);
            ResultSet rs = pst.executeQuery();
            //
            while (rs.next()) {
                String product_id = rs.getString("product_id");
                String name = rs.getString("name");
                int price = rs.getInt("price");
                int sale_price = rs.getInt("sale_price");
                String slug = rs.getString("slug");
                String thumbnail_url = rs.getString("thumbnail_url");
                int warranty_period = rs.getInt("warranty_period");
                String brand = rs.getString("brand");
                String status = rs.getString("status"); // Sửa thành String vì trong DB và DTO là String
                String specifications = rs.getString("specifications");
                String sub_id_prd = rs.getString("sub_id");

                // Tạo đối tượng ProductDTO (Giả sử bạn đã có constructor đầy đủ tham số theo thứ tự này)
                ProductDTO prd = new ProductDTO(product_id, name, price, sale_price, slug,
                        thumbnail_url, warranty_period, brand,
                        status, specifications, sub_id_prd);
                result.add(prd);
            }

            if (pst != null) {
                pst.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return result;
    }

    //TEST
    public ProductDTO searchById(String product_id) {
        ProductDTO res = new ProductDTO();
        return res;
    }

    //ADMIN + STAFF
    // GET ALL
    public java.util.List<ProductDTO> getAllProducts() {
        java.util.List<ProductDTO> list = new java.util.ArrayList<>();

        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM product";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getString("product_id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("sale_price"),
                        rs.getString("slug"),
                        rs.getString("thumbnail_url"),
                        rs.getInt("warranty_period"),
                        rs.getString("brand"),
                        rs.getString("status"),
                        rs.getString("specifications"),
                        rs.getString("sub_id")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

// DELETE
    public boolean deleteProduct(String id) {
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "DELETE FROM product WHERE product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
//update
    public boolean updateProduct(ProductDTO p) {
    int result = 0;
    try {
        Connection conn = DbUtils.getConnection();
        String sql = "UPDATE product SET name=?, price=?, sale_price=?, thumbnail_url=?, brand=?, status=?, specifications=? WHERE product_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, p.getName());
        ps.setInt(2, p.getPrice());
        ps.setInt(3, p.getSale_price());
        ps.setString(4, p.getThumbnail_url());
        ps.setString(5, p.getBrand());
        ps.setString(6, p.getStatus());
        ps.setString(7, p.getSpecifications());
        ps.setString(8, p.getProduct_id());

        result = ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result > 0;
}
}
