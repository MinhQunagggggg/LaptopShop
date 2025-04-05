package modelAdmin;

public class Keyboard {
    private int keyboardId;
    private int productId;
    private String brand;
    private int warrantyMonths;
    private String type;
    private String connectionType;
    private boolean wired;
    private String keycapMaterial;
    private String switchType;
    private String color;
    private String ledColor;
    private String dimensions;
    private float weight;
    private int batteryCapacity;
    private String keycapProfile;
    private String productName;
    private String description;
    private int accessoryBrandId;
    private byte[] imageData;

    // Constructor
    public Keyboard(int keyboardId, int productId, String brand, int warrantyMonths, String type, String connectionType, boolean wired, String keycapMaterial, String switchType, String color, String ledColor, String dimensions, float weight, int batteryCapacity, String keycapProfile, String productName, String description, int accessoryBrandId, byte[] imageData) {
        this.keyboardId = keyboardId;
        this.productId = productId;
        this.brand = brand;
        this.warrantyMonths = warrantyMonths;
        this.type = type;
        this.connectionType = connectionType;
        this.wired = wired;
        this.keycapMaterial = keycapMaterial;
        this.switchType = switchType;
        this.color = color;
        this.ledColor = ledColor;
        this.dimensions = dimensions;
        this.weight = weight;
        this.batteryCapacity = batteryCapacity;
        this.keycapProfile = keycapProfile;
        this.productName = productName;
        this.description = description;
        this.accessoryBrandId = accessoryBrandId;
        this.imageData = imageData;
    }

    // Getters và Setters
    public int getKeyboardId() { return keyboardId; }
    public void setKeyboardId(int keyboardId) { this.keyboardId = keyboardId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public int getWarrantyMonths() { return warrantyMonths; }
    public void setWarrantyMonths(int warrantyMonths) { this.warrantyMonths = warrantyMonths; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getConnectionType() { return connectionType; }
    public void setConnectionType(String connectionType) { this.connectionType = connectionType; }
    public boolean isWired() { return wired; }
    public void setWired(boolean wired) { this.wired = wired; }
    public String getKeycapMaterial() { return keycapMaterial; }
    public void setKeycapMaterial(String keycapMaterial) { this.keycapMaterial = keycapMaterial; }
    public String getSwitchType() { return switchType; }
    public void setSwitchType(String switchType) { this.switchType = switchType; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public String getLedColor() { return ledColor; }
    public void setLedColor(String ledColor) { this.ledColor = ledColor; }
    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }
    public float getWeight() { return weight; }
    public void setWeight(float weight) { this.weight = weight; }
    public int getBatteryCapacity() { return batteryCapacity; }
    public void setBatteryCapacity(int batteryCapacity) { this.batteryCapacity = batteryCapacity; }
    public String getKeycapProfile() { return keycapProfile; }
    public void setKeycapProfile(String keycapProfile) { this.keycapProfile = keycapProfile; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getAccessoryBrandId() { return accessoryBrandId; }
    public void setAccessoryBrandId(int accessoryBrandId) { this.accessoryBrandId = accessoryBrandId; }
    public byte[] getImageData() { return imageData; }
    public void setImageData(byte[] imageData) { this.imageData = imageData; }
}
