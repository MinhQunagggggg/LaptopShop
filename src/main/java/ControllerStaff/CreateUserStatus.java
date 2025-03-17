/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ControllerStaff;


public enum CreateUserStatus {
    SUCCESS,         // Tạo thành công
    USERNAME_EXISTS, // Username đã tồn tại
    EMAIL_EXISTS,    // Email đã tồn tại
    FAIL             // Lỗi khác (nội bộ, SQL, v.v.)
}

