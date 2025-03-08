/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author CE182250
 */
public class OrderDetail {

    private int orderId;
    private int variantId;
    private int quantity;
    private double price;

    public OrderDetail(int orderId, int variantId, int quantity, double price) {
        this.orderId = orderId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.price = price;
    }

    public OrderDetail(int orderId, int variantId, int quantity) {
        this.orderId = orderId;
        this.variantId = variantId;
        this.quantity = quantity;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getVariantId() {
        return variantId;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPrice() {
        return price;
    }
}
