package modelAdmin;

public class Headphone {
    private int headphoneId;
    private int productId;
    private String brand;
    private int warrantyMonths;
    private String connectionType;
    private boolean wired;
    private String color;
    private String ledColor;
    private float weight;
    private String frequencyRange;
    private String material;
    private int driverSize;
    private String productName;
    private String description;
    private int accessoryBrandId;
    private byte[] imageData;

    public Headphone(int headphoneId, int productId, String brand, int warrantyMonths, String connectionType, boolean wired, String color, String ledColor, float weight, String frequencyRange, String material, int driverSize, String productName, String description, int accessoryBrandId, byte[] imageData) {
        this.headphoneId = headphoneId;
        this.productId = productId;
        this.brand = brand;
        this.warrantyMonths = warrantyMonths;
        this.connectionType = connectionType;
        this.wired = wired;
        this.color = color;
        this.ledColor = ledColor;
        this.weight = weight;
        this.frequencyRange = frequencyRange;
        this.material = material;
        this.driverSize = driverSize;
        this.productName = productName;
        this.description = description;
        this.accessoryBrandId = accessoryBrandId;
        this.imageData = imageData;
    }

    // Getters và Setters

    public int getHeadphoneId() {
        return headphoneId;
    }

    public void setHeadphoneId(int headphoneId) {
        this.headphoneId = headphoneId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public int getWarrantyMonths() {
        return warrantyMonths;
    }

    public void setWarrantyMonths(int warrantyMonths) {
        this.warrantyMonths = warrantyMonths;
    }

    public String getConnectionType() {
        return connectionType;
    }

    public void setConnectionType(String connectionType) {
        this.connectionType = connectionType;
    }

    public boolean isWired() {
        return wired;
    }

    public void setWired(boolean wired) {
        this.wired = wired;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getLedColor() {
        return ledColor;
    }

    public void setLedColor(String ledColor) {
        this.ledColor = ledColor;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public String getFrequencyRange() {
        return frequencyRange;
    }

    public void setFrequencyRange(String frequencyRange) {
        this.frequencyRange = frequencyRange;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public int getDriverSize() {
        return driverSize;
    }

    public void setDriverSize(int driverSize) {
        this.driverSize = driverSize;
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

    public int getAccessoryBrandId() {
        return accessoryBrandId;
    }

    public void setAccessoryBrandId(int accessoryBrandId) {
        this.accessoryBrandId = accessoryBrandId;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }
}
