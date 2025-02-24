package Model_Staff;

public class OrderDetail {
    private String imageUrl;
    private String productName;
    private String description;
    private String status;
    private int quantity;
    private double price;

    public OrderDetail(String imageUrl, String productName, String description, String status, int quantity, double price) {
        this.imageUrl = imageUrl;
        this.productName = productName;
        this.description = description;
        this.status = status;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and Setters
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
