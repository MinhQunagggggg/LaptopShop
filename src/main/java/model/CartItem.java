/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author CE182250
 */
public class CartItem {
    private int variantId;
    private String productName;
    private byte[] imageData;
    private double price;
    private int quantity;
    private double totalPrice;

    public CartItem(int variantId, String productName, byte[] imageData, double price, int quantity, double totalPrice) {
        this.variantId = variantId;
        this.productName = productName;
        this.imageData = imageData;
        this.price = price;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    public int getVariantId() { return variantId; }
    public String getProductName() { return productName; }
    public byte[] getImageData() { return imageData; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public double getTotalPrice() { return totalPrice; }
}

