package movieBooking.admin.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import movieBooking.admin.model.User;
import movieBooking.connection.ConnectionDB;

public class UserDao {
    private Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    // 1️⃣ Get all users
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT Name,Email,Password,DOB,Gender FROM user";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                users.add(new User(
                    rs.getString("Name"),
                    rs.getString("Email"),
                    rs.getString("Password"),
                    rs.getString("DOB"),
                    rs.getString("Gender")
                ));
            }
        }
        return users;
    }

    // 2️⃣ Add user
    public boolean addUser(User user) throws SQLException {
        String sql = "INSERT INTO user (Name, Email, Password, DOB, Gender) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getDob());
            stmt.setString(5, user.getGender());
            return stmt.executeUpdate() > 0;
        }
    }

    // 3️⃣ Get user by ID
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM user WHERE ID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("ID"),
                    rs.getString("Name"),
                    rs.getString("Email"),
                    rs.getString("Password"),
                    rs.getString("DOB"),
                    rs.getString("Gender")
                );
            }
        }
        return null;
    }

    // 4️⃣ Update user
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE user SET Name=?, Email=?, Password=?, DOB=?, Gender=? WHERE ID=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getDob());
            stmt.setString(5, user.getGender());
            stmt.setInt(6, user.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    // 5️⃣ Delete user
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM user WHERE ID=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
}
