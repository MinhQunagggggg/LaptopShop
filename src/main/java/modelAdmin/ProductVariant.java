package modelAdmin;

public class ProductVariant {

    private int variantId;
    private int productId;
    private double price;
    private int stock;
    private String ram; // Thêm thuộc tính RAM

    public ProductVariant() {
    }

    public ProductVariant(int productId, double price, int stock) {

        this.productId = productId;
        this.price = price;
        this.stock = stock;
    }

    public ProductVariant(int productId, double price, int stock, String ram) {
        this.productId = productId;
        this.price = price;
        this.stock = stock;
        this.ram = ram;
    }

    // Getter & Setter
    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

}
