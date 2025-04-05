package Model_Staff;


public class Mouse {
    private int mouseId;
    private int productId;
    private String brand;
    private int warrantyMonths;
    private String connectionType;
    private boolean wired;
    private int dpi;
    private String switchType;
    private String mouseLed;
    private String color;
    private String dimensions;
    private Double weight;

    public Mouse(int productId, String brand, int warrantyMonths, String connectionType, boolean wired, 
                 int dpi, String switchType, String mouseLed, String color, String dimensions, Double weight) {
        this.productId = productId;
        this.brand = brand;
        this.warrantyMonths = warrantyMonths;
        this.connectionType = connectionType;
        this.wired = wired;
        this.dpi = dpi;
        this.switchType = switchType;
        this.mouseLed = mouseLed;
        this.color = color;
        this.dimensions = dimensions;
        this.weight = weight;
    }

    // Getter và Setter
    public int getMouseId() {
        return mouseId;
    }

    public void setMouseId(int mouseId) {
        this.mouseId = mouseId;
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

    public int getDpi() {
        return dpi;
    }

    public void setDpi(int dpi) {
        this.dpi = dpi;
    }

    public String getSwitchType() {
        return switchType;
    }

    public void setSwitchType(String switchType) {
        this.switchType = switchType;
    }

    public String getMouseLed() {
        return mouseLed;
    }

    public void setMouseLed(String mouseLed) {
        this.mouseLed = mouseLed;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }
}
