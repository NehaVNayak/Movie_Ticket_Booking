/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package movieBooking.connection;
import java.sql.*;

/**
 *
 * @author nehan
 */
public class ConnectionDB {
    public static Connection getCon() throws ClassNotFoundException, SQLException {
       Class.forName("com.mysql.cj.jdbc.Driver");
       return DriverManager.getConnection("jdbc:mysql://localhost:3306/movieticket", "root", "123456");
    }
}
