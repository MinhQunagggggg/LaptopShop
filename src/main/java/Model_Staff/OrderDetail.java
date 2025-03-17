package Model_Staff;

import java.sql.Timestamp;

public class OrderDetail {
    private int orderId;
    private int userId;
    private String customerName;
    private String customerPhone;
    private String orderStatus;
    private Timestamp orderDate;
    private double totalPrice;

    private String consigneeName;
    private String consigneePhone;
    private String consigneeAddress;

    private String imageUrl;
    private String productName;
    private String productDescription;
    private String productStatus;
    private int quantity;
    private double price;

    // ✅ Constructor mới có cả thông tin người nhận
    public OrderDetail(int orderId, int userId, String customerName, String customerPhone, String orderStatus, Timestamp orderDate,
                       double totalPrice, String consigneeName, String consigneePhone, String consigneeAddress,
                       String imageUrl, String productName, String productDescription, String productStatus,
                       int quantity, double price) {
        this.orderId = orderId;
        this.userId = userId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.orderStatus = orderStatus;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;

        this.consigneeName = consigneeName;
        this.consigneePhone = consigneePhone;
        this.consigneeAddress = consigneeAddress;

        this.imageUrl = imageUrl;
        this.productName = productName;
        this.productDescription = productDescription;
        this.productStatus = productStatus;
        this.quantity = quantity;
        this.price = price;
    }

    // ✅ Getters cho thông tin người nhận
    public String getConsigneeName() {
        return consigneeName;
    }

    public String getConsigneePhone() {
        return consigneePhone;
    }

    public String getConsigneeAddress() {
        return consigneeAddress;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }


}
