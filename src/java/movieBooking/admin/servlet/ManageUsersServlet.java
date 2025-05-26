/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package movieBooking.admin.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import movieBooking.admin.dao.UserDao;
import movieBooking.admin.model.User;
import movieBooking.connection.ConnectionDB;


/**
 *
 * @author nehan
 */
public class ManageUsersServlet extends HttpServlet {
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDao userDao = new UserDao(ConnectionDB.getCon());
            List<User> users = userDao.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin/manage_users.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try (PrintWriter out = response.getWriter()) {
            UserDao userDao = new UserDao(ConnectionDB.getCon());

            if ("add".equals(action)) {
                User user = new User();
                user.setPassword(request.getParameter("password"));
                user.setName(request.getParameter("name"));
                user.setEmail(request.getParameter("email"));
                user.setDob(request.getParameter("dob"));
                user.setGender(request.getParameter("gender"));
                
                userDao.addUser(user);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                userDao.deleteUser(id);
            }

            response.sendRedirect("ManageUsersServlet");
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ManageUsersServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}

