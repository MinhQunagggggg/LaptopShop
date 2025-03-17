package Model_Staff;

public class ProductSpecification {
    private int specId;
    private int productId;
    private String cpu;
    private String storage;
    private String resolution;
    private String graphics;
    private String ports;
    private String wireless;
    private String camera;
    private String battery;
    private String dimensions;
    private String weight;
    private String keyboard;
    private String material;
    private String warranty;
    private String os;
    private String condition;
    private String refreshRate;
    private String ram;

    // ✅ Constructor
    public ProductSpecification(int specId, int productId, String cpu, String storage, String resolution, 
                                String graphics, String ports, String wireless, String camera, 
                                String battery, String dimensions, String weight, String keyboard, 
                                String material, String warranty, String os, String condition, 
                                String refreshRate, String ram) {
        this.specId = specId;
        this.productId = productId;
        this.cpu = cpu;
        this.storage = storage;
        this.resolution = resolution;
        this.graphics = graphics;
        this.ports = ports;
        this.wireless = wireless;
        this.camera = camera;
        this.battery = battery;
        this.dimensions = dimensions;
        this.weight = weight;
        this.keyboard = keyboard;
        this.material = material;
        this.warranty = warranty;
        this.os = os;
        this.condition = condition;
        this.refreshRate = refreshRate;
        this.ram = ram;
    }

    // ✅ Getters và Setters
    public int getSpecId() { return specId; }
    public int getProductId() { return productId; }
    public String getCpu() { return cpu; }
    public String getStorage() { return storage; }
    public String getResolution() { return resolution; }
    public String getGraphics() { return graphics; }
    public String getPorts() { return ports; }
    public String getWireless() { return wireless; }
    public String getCamera() { return camera; }
    public String getBattery() { return battery; }
    public String getDimensions() { return dimensions; }
    public String getWeight() { return weight; }
    public String getKeyboard() { return keyboard; }
    public String getMaterial() { return material; }
    public String getWarranty() { return warranty; }
    public String getOs() { return os; }
    public String getCondition() { return condition; }
    public String getRefreshRate() { return refreshRate; }
    public String getRam() { return ram; }

    public void setCpu(String cpu) { this.cpu = cpu; }
    public void setStorage(String storage) { this.storage = storage; }
    public void setResolution(String resolution) { this.resolution = resolution; }
    public void setGraphics(String graphics) { this.graphics = graphics; }
    public void setPorts(String ports) { this.ports = ports; }
    public void setWireless(String wireless) { this.wireless = wireless; }
    public void setCamera(String camera) { this.camera = camera; }
    public void setBattery(String battery) { this.battery = battery; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }
    public void setWeight(String weight) { this.weight = weight; }
    public void setKeyboard(String keyboard) { this.keyboard = keyboard; }
    public void setMaterial(String material) { this.material = material; }
    public void setWarranty(String warranty) { this.warranty = warranty; }
    public void setOs(String os) { this.os = os; }
    public void setCondition(String condition) { this.condition = condition; }
    public void setRefreshRate(String refreshRate) { this.refreshRate = refreshRate; }
    public void setRam(String ram) { this.ram = ram; }
}
