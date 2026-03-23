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

public class ShipperDAO {
    private Connection conn;

    public ShipperDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean insert(ShipperDTO s) throws SQLException {
        String sql = "INSERT INTO shipper(company_name, contact) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, s.getCompanyName());
        ps.setString(2, s.getContact());
        return ps.executeUpdate() > 0;
    }

    public List<ShipperDTO> getAll() throws SQLException {
        List<ShipperDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM shipper";
        ResultSet rs = conn.createStatement().executeQuery(sql);

        while (rs.next()) {
            list.add(new ShipperDTO(
                    rs.getInt("shipper_id"),
                    rs.getString("company_name"),
                    rs.getString("contact")
            ));
        }
        return list;
    }

    public ShipperDTO getById(int id) throws SQLException {
        String sql = "SELECT * FROM shipper WHERE shipper_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new ShipperDTO(
                    rs.getInt("shipper_id"),
                    rs.getString("company_name"),
                    rs.getString("contact")
            );
        }
        return null;
    }

    public boolean update(ShipperDTO s) throws SQLException {
        String sql = "UPDATE shipper SET company_name=?, contact=? WHERE shipper_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, s.getCompanyName());
        ps.setString(2, s.getContact());
        ps.setInt(3, s.getShipperId());
        return ps.executeUpdate() > 0;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM shipper WHERE shipper_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }
}
