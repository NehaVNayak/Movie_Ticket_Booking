package movieBooking.admin.dao;

import java.sql.*;
import movieBooking.admin.model.Admin;
import movieBooking.admin.services.AdminService;

public class AdminDao implements AdminService {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public AdminDao(Connection con) {
        this.con = con;
    }

    @Override
    public Admin logAdmin(String email, String password)  {
        Admin admin = null;

        try {
            query = "SELECT * FROM admin WHERE email=? AND password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("ID"));
                admin.setName(rs.getString("Name")); // Assuming Name exists
                admin.setEmail(rs.getString("Email"));
                admin.setDob(rs.getString("DOB"));
                admin.setGender(rs.getString("Gender")); // Assuming Gender exists
                admin.setRole(rs.getString("Role"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return admin;
    }
}
