package modelAdmin;

public class ProductSpecification {
    private int productId;
    private String cpu;
    private String ram;
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

    public ProductSpecification(int productId, String cpu, String ram, String storage, 
                                String resolution, String graphics, String ports, String wireless, 
                                String camera, String battery, String dimensions, String weight, 
                                String keyboard, String material, String warranty, String os, 
                                String condition, String refreshRate) {
        this.productId = productId;
        this.cpu = cpu;
        this.ram = ram;
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
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getStorage() {
        return storage;
    }

    public void setStorage(String storage) {
        this.storage = storage;
    }

    public String getResolution() {
        return resolution;
    }

    public void setResolution(String resolution) {
        this.resolution = resolution;
    }

    public String getGraphics() {
        return graphics;
    }

    public void setGraphics(String graphics) {
        this.graphics = graphics;
    }

    public String getPorts() {
        return ports;
    }

    public void setPorts(String ports) {
        this.ports = ports;
    }

    public String getWireless() {
        return wireless;
    }

    public void setWireless(String wireless) {
        this.wireless = wireless;
    }

    public String getCamera() {
        return camera;
    }

    public void setCamera(String camera) {
        this.camera = camera;
    }

    public String getBattery() {
        return battery;
    }

    public void setBattery(String battery) {
        this.battery = battery;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getKeyboard() {
        return keyboard;
    }

    public void setKeyboard(String keyboard) {
        this.keyboard = keyboard;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getWarranty() {
        return warranty;
    }

    public void setWarranty(String warranty) {
        this.warranty = warranty;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getRefreshRate() {
        return refreshRate;
    }

    public void setRefreshRate(String refreshRate) {
        this.refreshRate = refreshRate;
    }
}
