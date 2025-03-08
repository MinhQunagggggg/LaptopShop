/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author CE182250
 */
public class Order {
    private int orderId;
    private Timestamp createdAt;
    private double totalPrice;
    private String statusName; // 🔹 Trạng thái đơn hàng

    // ✅ Constructor phù hợp
    public Order(int orderId, Timestamp createdAt, double totalPrice, String statusName) {
        this.orderId = orderId;
        this.createdAt = createdAt;
        this.totalPrice = totalPrice;
        this.statusName = statusName;
    }

    // ✅ Getters và Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
}
