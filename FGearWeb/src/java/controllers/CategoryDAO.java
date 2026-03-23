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

public class CategoryDAO {
    private Connection conn;

    public CategoryDAO(Connection conn) {
        this.conn = conn;
    }

    // CREATE
    public boolean insert(CategoryDTO c) throws SQLException {
        String sql = "INSERT INTO category(name) VALUES (?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, c.getName());
        return ps.executeUpdate() > 0;
    }

    // READ ALL
    public List<CategoryDTO> getAll() throws SQLException {
        List<CategoryDTO> list = new ArrayList<>();
        ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM category");

        while (rs.next()) {
            list.add(new CategoryDTO(
                    rs.getInt("category_id"),
                    rs.getString("name")
            ));
        }
        return list;
    }

    // READ BY ID
    public CategoryDTO getById(int id) throws SQLException {
        String sql = "SELECT * FROM category WHERE category_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new CategoryDTO(
                    rs.getInt("category_id"),
                    rs.getString("name")
            );
        }
        return null;
    }

    // UPDATE
    public boolean update(CategoryDTO c) throws SQLException {
        String sql = "UPDATE category SET name=? WHERE category_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, c.getName());
        ps.setInt(2, c.getCategoryId());
        return ps.executeUpdate() > 0;
    }

    // DELETE
    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM category WHERE category_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }
}