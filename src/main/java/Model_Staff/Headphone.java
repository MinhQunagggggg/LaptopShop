package Model_Staff;

public class Headphone {
    private int headphoneId;
    private int productId;
    private String brand;
    private int warrantyMonths;
    private String connectionType;
    private boolean wired;
    private String color;
    private String ledColor;
    private double weight;
    private String frequencyRange;
    private String material;
    private int driverSize;

    // Constructors
    public Headphone() {}

    public Headphone( int productId, String brand, int warrantyMonths, String connectionType,
                     boolean wired, String color, String ledColor, double weight, String frequencyRange,
                     String material, int driverSize) {
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
    }

    // Getters and Setters
    public int getHeadphoneId() { return headphoneId; }
    public void setHeadphoneId(int headphoneId) { this.headphoneId = headphoneId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public int getWarrantyMonths() { return warrantyMonths; }
    public void setWarrantyMonths(int warrantyMonths) { this.warrantyMonths = warrantyMonths; }

    public String getConnectionType() { return connectionType; }
    public void setConnectionType(String connectionType) { this.connectionType = connectionType; }

    public boolean isWired() { return wired; }
    public void setWired(boolean wired) { this.wired = wired; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getLedColor() { return ledColor; }
    public void setLedColor(String ledColor) { this.ledColor = ledColor; }

    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }

    public String getFrequencyRange() { return frequencyRange; }
    public void setFrequencyRange(String frequencyRange) { this.frequencyRange = frequencyRange; }

    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }

    public int getDriverSize() { return driverSize; }
    public void setDriverSize(int driverSize) { this.driverSize = driverSize; }
}
