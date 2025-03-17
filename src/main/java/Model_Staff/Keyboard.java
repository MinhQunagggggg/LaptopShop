package Model_Staff;

public class Keyboard {
    private int id;
    private int productId;
    private String brand;
    private int warrantyMonths;
    private String type;
    private String connectionType;
    private boolean wired;
    private String keycapMaterial;
    private String switchType;
    private String color;
    private String ledColor; // ✅ Có thể NULL
    private String dimensions;
    private Double weight; // ✅ Dùng `Double` để hỗ trợ NULL
    private Integer batteryCapacity; // ✅ Dùng `Integer` để hỗ trợ NULL
    private String keycapProfile;

    // ✅ Constructor với `NULL`-Safe giá trị
    public Keyboard(int productId, String brand, int warrantyMonths, String type, String connectionType, boolean wired,
                    String keycapMaterial, String switchType, String color, String ledColor, String dimensions, 
                    Double weight, Integer batteryCapacity, String keycapProfile) {
        this.productId = productId;
        this.brand = brand;
        this.warrantyMonths = warrantyMonths;
        this.type = type;
        this.connectionType = connectionType;
        this.wired = wired;
        this.keycapMaterial = keycapMaterial;
        this.switchType = switchType;
        this.color = color;
        this.ledColor = (ledColor != null) ? ledColor : "Không có"; // ✅ Nếu NULL → "Không có"
        this.dimensions = dimensions;
        this.weight = (weight != null) ? weight : 0.0; // ✅ Nếu NULL → 0.0
        this.batteryCapacity = (batteryCapacity != null) ? batteryCapacity : 0; // ✅ Nếu NULL → 0
        this.keycapProfile = keycapProfile;
    }

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
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
    public void setLedColor(String ledColor) { this.ledColor = (ledColor != null) ? ledColor : "Không có"; }
    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }
    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = (weight != null) ? weight : 0.0; }
    public Integer getBatteryCapacity() { return batteryCapacity; }
    public void setBatteryCapacity(Integer batteryCapacity) { this.batteryCapacity = (batteryCapacity != null) ? batteryCapacity : 0; }
    public String getKeycapProfile() { return keycapProfile; }
    public void setKeycapProfile(String keycapProfile) { this.keycapProfile = keycapProfile; }
}
