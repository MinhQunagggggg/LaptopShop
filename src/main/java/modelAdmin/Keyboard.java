package modelAdmin;

public class Keyboard {
    private int id;
    private int productId;
    private String brand;
    private String connectionType;
    private boolean mechanical;
    private String switchType;
    private boolean rgb;
    private String layout;
    private String dimensions;
    private double weight;
    private int warrantyMonths;

    public Keyboard(int productId, String brand, String connectionType, boolean mechanical, String switchType, boolean rgb, String layout, String dimensions, double weight, int warrantyMonths) {
        this.productId = productId;
        this.brand = brand;
        this.connectionType = connectionType;
        this.mechanical = mechanical;
        this.switchType = switchType;
        this.rgb = rgb;
        this.layout = layout;
        this.dimensions = dimensions;
        this.weight = weight;
        this.warrantyMonths = warrantyMonths;
    }

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public String getConnectionType() { return connectionType; }
    public void setConnectionType(String connectionType) { this.connectionType = connectionType; }
    public boolean isMechanical() { return mechanical; }
    public void setMechanical(boolean mechanical) { this.mechanical = mechanical; }
    public String getSwitchType() { return switchType; }
    public void setSwitchType(String switchType) { this.switchType = switchType; }
    public boolean isRgb() { return rgb; }
    public void setRgb(boolean rgb) { this.rgb = rgb; }
    public String getLayout() { return layout; }
    public void setLayout(String layout) { this.layout = layout; }
    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }
    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }
    public int getWarrantyMonths() { return warrantyMonths; }
    public void setWarrantyMonths(int warrantyMonths) { this.warrantyMonths = warrantyMonths; }
}
