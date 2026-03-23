/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author User
 */
import java.sql.*;
import java.util.*;

public class PromotionDAO {

    private Connection conn;

    public PromotionDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean insert(PromotionDTO p) throws SQLException {
        String sql = "INSERT INTO promotion(code, discount_value, start_date, end_date, usage_limit) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, p.getCode());
        ps.setDouble(2, p.getDiscountValue());
        ps.setDate(3, p.getStartDate());
        ps.setDate(4, p.getEndDate());
        ps.setInt(5, p.getUsageLimit());
        return ps.executeUpdate() > 0;
    }

    public List<PromotionDTO> getAll() throws SQLException {
        List<PromotionDTO> list = new ArrayList<>();
        ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM promotion");

        while (rs.next()) {
            list.add(map(rs));
        }
        return list;
    }

    public PromotionDTO getById(int id) throws SQLException {
        String sql = "SELECT * FROM promotion WHERE promotion_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return map(rs);
        return null;
    }

    public boolean update(PromotionDTO p) throws SQLException {
        String sql = "UPDATE promotion SET code=?, discount_value=?, start_date=?, end_date=?, usage_limit=? WHERE promotion_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, p.getCode());
        ps.setDouble(2, p.getDiscountValue());
        ps.setDate(3, p.getStartDate());
        ps.setDate(4, p.getEndDate());
        ps.setInt(5, p.getUsageLimit());
        ps.setInt(6, p.getPromotionId());
        return ps.executeUpdate() > 0;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM promotion WHERE promotion_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }

    private PromotionDTO map(ResultSet rs) throws SQLException {
        return new PromotionDTO(
                rs.getInt("promotion_id"),
                rs.getString("code"),
                rs.getDouble("discount_value"),
                rs.getDate("start_date"),
                rs.getDate("end_date"),
                rs.getInt("usage_limit")
        );
    }
}
