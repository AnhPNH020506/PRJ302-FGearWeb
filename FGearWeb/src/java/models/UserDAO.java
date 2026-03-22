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
import utils.HashPasswordUtils;

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

        if (user != null) {
            String hashed = HashPasswordUtils.hashPassword(password);
            if (user.getPassword().equals(hashed)) {
                return user;
            }
        }
        
        return null;
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

    public boolean updatePassword(String email, String password) {

        String sql = "UPDATE Users SET password=? WHERE email=?";

        try {
            String hashed = HashPasswordUtils.hashPassword(password);

            Connection conn = DbUtils.getConnection();

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, hashed);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean checkEmail(String email) {

        String sql = "SELECT email FROM Users WHERE email=?";

        try {

            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean register(String email, String name, String password) {
        boolean check = false;
        String sql = "INSERT INTO users(email, username, password, updated_at) VALUES (?, ?, ?, ?)";

        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            String hashed = HashPasswordUtils.hashPassword(password);

            ps.setString(1, email);
            ps.setString(2, name);
            ps.setString(3, hashed);

            String x = java.time.LocalDate.now().toString();
            ps.setString(4, x);

            int result = ps.executeUpdate();

            if (result > 0) {
                check = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return check;
    }
    // ================= ADMIN CRUD =================

// GET ALL USERS
    public java.util.List<UserDTO> getAllUsers() {
        java.util.List<UserDTO> list = new java.util.ArrayList<>();

        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM users";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserDTO user = new UserDTO(
                        rs.getString("user_id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("contact"),
                        rs.getString("sex"),
                        rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null,
                        rs.getString("address"),
                        rs.getInt("role"),
                        rs.getString("status"),
                        rs.getDate("created_at") != null ? rs.getDate("created_at").toLocalDate() : null,
                        rs.getDate("updated_at") != null ? rs.getDate("updated_at").toLocalDate() : null
                );
                list.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

// DELETE USER
    public boolean deleteUser(String id) {
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "UPDATE users SET status='BANNED' WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

// UPDATE USER
   // UPDATE USER
public boolean updateUser(UserDTO u) {
    int result = 0;
    try {
        Connection conn = DbUtils.getConnection();
        String sql = "UPDATE users SET username=?, email=?, contact=?, address=?, role=?, status=?, updated_at=? WHERE user_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, u.getUsername());
        ps.setString(2, u.getEmail());       // thêm email
        ps.setString(3, u.getContact());
        ps.setString(4, u.getAddress());
        ps.setInt(5, u.getRole());
        ps.setString(6, u.getStatus());
        ps.setDate(7, java.sql.Date.valueOf(java.time.LocalDate.now())); // cập nhật thời gian sửa
        ps.setString(8, u.getUserId());

        result = ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result > 0;
}


// ADD USER
    public boolean addUser(String name, String email, String password) {
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "INSERT INTO users(username,email,password) VALUES(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            String hashed = HashPasswordUtils.hashPassword(password);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, hashed);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
