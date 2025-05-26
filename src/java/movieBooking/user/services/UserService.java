/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package movieBooking.user.services;

import movieBooking.admin.model.User;

/**
 *
 * @author nehan
 */
public interface UserService {
    public User logUser(String email, String password);
}
