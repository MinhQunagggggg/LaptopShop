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
    private int productId; 
    private double price;
    private int quantity;
    private double totalPrice;
    private String ram; // 🛠️ Thêm thuộc tính RAM
    private int stock; // ✅ Thêm stock

    public CartItem(int variantId, String productName, byte[] imageData, double price, int quantity, double totalPrice, String ram) {
        this.variantId = variantId;
        this.productName = productName;
        this.imageData = imageData;
        this.price = price;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.ram = ram; // 🛠️ Gán giá trị RAM
    }
    public CartItem(int variantId, int productId, String productName, byte[] imageData, double price, int quantity, double totalPrice, String ram, int stock) {
        this.variantId = variantId;
        this.productId = productId;
        this.productName = productName;
        this.imageData = imageData;
        this.price = price;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.ram = ram;
        this.stock = stock;
    }
    public CartItem(int variantId, int productId, String productName, byte[] imageData, double price, int quantity, double totalPrice, String ram) {
        this.variantId = variantId;
        this.productId = productId; // 🔹 Gán `productId`
        this.productName = productName;
        this.imageData = imageData;
        this.price = price;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.ram = ram;
    }

    public int getVariantId() { return variantId; }
    public String getProductName() { return productName; }
    public byte[] getImageData() { return imageData; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public double getTotalPrice() { return totalPrice; }
    public String getRam() { return ram; } // 🛠️ Getter cho RAM
    public int getProductId() { return productId; }

     public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    
    public int getStock() {
        return stock;
    }
}

