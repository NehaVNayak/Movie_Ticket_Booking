/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package movieBooking.admin.services;

import movieBooking.admin.model.Admin;

/**
 *
 * @author nehan
 */
public interface AdminService {
    public Admin logAdmin(String email, String password);
}
