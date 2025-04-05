package model;

import java.sql.Timestamp;

public class Order {

    private int variantId, status_id, order_id, user_id, product_id;
    private String productName, description, ram, consigneeName, consigneeAddress, consigneePhone;
    private byte[] imageData;
    private double price;
    private int quantity;
    private double totalPrice;
    private Timestamp createdAt;

    public Order(int variantId, int status_id, int order_id, String productName, byte[] imageData, double price, int quantity, double totalPrice, Timestamp createdAt, String ram ) {
        this.variantId = variantId;
        this.status_id = status_id;
        this.order_id = order_id;
        this.productName = productName;
        this.imageData = imageData;
        this.price = price;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
        this.ram = ram;
    }

    public Order(int variantId, int status_id, int order_id, int user_id, String productName,
            byte[] imageData, double price, int quantity, int product_id,
            double totalPrice, String description, Timestamp createdAt, String ram, String consigneeName, String consigneeAddress ,String consigneePhone) {
        this.variantId = variantId;
        this.status_id = status_id;
        this.order_id = order_id;
        this.user_id = user_id;
        this.productName = productName;
        this.imageData = imageData;
        this.price = price;
        this.quantity = quantity;
        this.product_id = product_id;
        this.totalPrice = totalPrice;
        this.description = description;
        this.createdAt = createdAt;
        this.ram = ram;
        this.consigneeName = consigneeName;
        this.consigneePhone = consigneePhone;
        this.consigneeAddress = consigneeAddress;
        
    }

    public Order(int variantId, String ram, int product_id, double price, int quantity) {
        this.variantId = variantId;
        this.ram = ram;
        this.product_id = product_id;
        this.price = price;
        this.quantity = quantity;
    }

    public Order(int status_id, int order_id, int user_id, double totalPrice, Timestamp createdAt) {
        this.status_id = status_id;
        this.order_id = order_id;
        this.user_id = user_id;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
    }

    public Order(int status_id, double totalPrice, Timestamp createdAt) {
        this.status_id = status_id;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
    }

    // Getters & Setters
    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getConsigneeName() {
        return consigneeName;
    }

    public void setConsigneeName(String consigneeName) {
        this.consigneeName = consigneeName;
    }

    public String getConsigneeAddress() {
        return consigneeAddress;
    }

    public void setConsigneeAddress(String consigneeAddress) {
        this.consigneeAddress = consigneeAddress;
    }

    public String getConsigneePhone() {
        return consigneePhone;
    }

    public void setConsigneePhone(String consigneePhone) {
        this.consigneePhone = consigneePhone;
    }
    
}
