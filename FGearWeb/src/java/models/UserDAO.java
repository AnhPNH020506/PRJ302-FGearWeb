/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import utils.DbUtils;

/**
 *
 * @author DELL
 */
public class UserDAO {

    //constructor
    public UserDAO() {
        //
    }

    public UserDTO login(String email, String password) {
        UserDTO user = searchByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        } else {
            return null;
        }
    }

    public UserDTO searchByEmail(String email) {
        UserDTO user = null;

        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM users WHERE email=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            System.out.println(sql); //giá trị của sql không bị thay đổi
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                String user_id = rs.getString("user_id");
                String username = rs.getString("username");
//                String email = rs.getString("email");
                String password = rs.getString("password");
                String contact = rs.getString("contact");
                String sex = rs.getString("sex");
                Date sqlDob = rs.getDate("dob");
                LocalDate dob = (sqlDob != null) ? sqlDob.toLocalDate() : null;
                String address = rs.getString("address");
                int role = rs.getInt("role");
                String statusStr = rs.getString("status");
                Date sqlCreatedAt = rs.getDate("created_at");
                LocalDate created_at = (sqlCreatedAt != null) ? sqlCreatedAt.toLocalDate() : null;
                Date sqlUpdatedAt = rs.getDate("updated_at");
                LocalDate updated_at = (sqlUpdatedAt != null) ? sqlUpdatedAt.toLocalDate() : null;

                user = new UserDTO(user_id, username, email, password, contact, sex, dob, address, role, statusStr, created_at, updated_at);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean register(String email, String name, String password) {
        boolean check = false;
        try {
            Connection conn = DbUtils.getConnection();

            String sql = "INSERT INTO users(user_id, username, email, password, contact, sex, dob, address, role, status, created_at, updated_at) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 2, 'ACTIVE', GETDATE(), GETDATE())";
            PreparedStatement ps = conn.prepareStatement(sql);
            // tạo user_id mới
            String newId = "USR" + (int) (Math.random() * 900 + 100);

            ps.setString(1, newId);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, "");        // contact
            ps.setString(6, "Other");   // sex
            ps.setDate(7, java.sql.Date.valueOf("2000-01-01")); // dob
            ps.setString(8, "");        // address

            check = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
