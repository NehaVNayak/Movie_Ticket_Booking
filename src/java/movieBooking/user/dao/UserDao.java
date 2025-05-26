/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package movieBooking.user.dao;

import java.sql.*;
import movieBooking.admin.model.User;
import movieBooking.user.services.UserService;
/*import movieBooking.user.services.AdminService;*/

public class UserDao implements UserService{
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;
    
    public UserDao(Connection con) {
        this.con = con;
    }

    public User logUser(String email, String password)  {
        User user = null;

        try {
            query = "SELECT * FROM user WHERE email=? AND password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("ID"));
                user.setName(rs.getString("Name")); // Assuming Name exists
                user.setEmail(rs.getString("Email"));
                user.setDob(rs.getString("DOB"));
                user.setGender(rs.getString("Gender")); // Assuming Gender exists
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return user;
    }
    
}




