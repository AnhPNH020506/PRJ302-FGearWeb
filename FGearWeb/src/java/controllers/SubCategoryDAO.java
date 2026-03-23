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

public class SubCategoryDAO {
    private Connection conn;

    public SubCategoryDAO(Connection conn) {
        this.conn = conn;
    }

    // CREATE
    public boolean insert(SubCategoryDTO s) throws SQLException {
        String sql = "INSERT INTO subcategory(name, slug, category_id) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, s.getName());
        ps.setString(2, s.getSlug());
        ps.setInt(3, s.getCategoryId());
        return ps.executeUpdate() > 0;
    }

    // READ ALL
    public List<SubCategoryDTO> getAll() throws SQLException {
        List<SubCategoryDTO> list = new ArrayList<>();
        ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM subcategory");

        while (rs.next()) {
            list.add(new SubCategoryDTO(
                    rs.getInt("sub_id"),
                    rs.getString("name"),
                    rs.getString("slug"),
                    rs.getInt("category_id")
            ));
        }
        return list;
    }

    // READ BY ID
    public SubCategoryDTO getById(int id) throws SQLException {
        String sql = "SELECT * FROM subcategory WHERE sub_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new SubCategoryDTO(
                    rs.getInt("sub_id"),
                    rs.getString("name"),
                    rs.getString("slug"),
                    rs.getInt("category_id")
            );
        }
        return null;
    }

    // UPDATE
    public boolean update(SubCategoryDTO s) throws SQLException {
        String sql = "UPDATE subcategory SET name=?, slug=?, category_id=? WHERE sub_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, s.getName());
        ps.setString(2, s.getSlug());
        ps.setInt(3, s.getCategoryId());
        ps.setInt(4, s.getSubId());
        return ps.executeUpdate() > 0;
    }

    // DELETE
    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM subcategory WHERE sub_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }
}
