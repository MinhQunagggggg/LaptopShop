// model/OrderDetail.java
package modelAdmin;

public class OrderDetail {
    private int orderDetailId;
    private int orderId;
    private int variantId;
    private int quantity;
    private double price;

    // Constructors
    public OrderDetail() {}
    
    public OrderDetail(int orderDetailId, int orderId, int variantId, int quantity, double price) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and Setters
    public int getOrderDetailId() { return orderDetailId; }
    public void setOrderDetailId(int orderDetailId) { this.orderDetailId = orderDetailId; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}