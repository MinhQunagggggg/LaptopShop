package modelAdmin;

public class Monitor {
    private int monitorId;
    private int productId;
    private String model;
    private float size;
    private String panelType;
    private String resolution;
    private String bitDepth;
    private String colorGamut;
    private int brightness;
    private int refreshRate;
    private String hdr;
    private String ports;
    private boolean audioOut;
    private String functionKeys;
    private float weight;
    private String dimensions;
    private String color;
    private String productName;
    private String description;
    private byte[] image;

    // ✅ Constructor
    public Monitor(int monitorId, int productId, String model, float size, String panelType, String resolution, 
                   String bitDepth, String colorGamut, int brightness, int refreshRate, 
                   String hdr, String ports, boolean audioOut, String functionKeys, 
                   float weight, String dimensions, String color, String productName, 
                   String description, byte[] image) {
        this.monitorId = monitorId;
        this.productId = productId;
        this.model = model;
        this.size = size;
        this.panelType = panelType;
        this.resolution = resolution;
        this.bitDepth = bitDepth;
        this.colorGamut = colorGamut;
        this.brightness = brightness;
        this.refreshRate = refreshRate;
        this.hdr = hdr;
        this.ports = ports;
        this.audioOut = audioOut;
        this.functionKeys = functionKeys;
        this.weight = weight;
        this.dimensions = dimensions;
        this.color = color;
        this.productName = productName;
        this.description = description;
        this.image = image;
    }

    // ✅ Getter và Setter
    public int getMonitorId() { return monitorId; }
    public void setMonitorId(int monitorId) { this.monitorId = monitorId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public float getSize() { return size; }
    public void setSize(float size) { this.size = size; }

    public String getPanelType() { return panelType; }
    public void setPanelType(String panelType) { this.panelType = panelType; }

    public String getResolution() { return resolution; }
    public void setResolution(String resolution) { this.resolution = resolution; }

    public String getBitDepth() { return bitDepth; }
    public void setBitDepth(String bitDepth) { this.bitDepth = bitDepth; }

    public String getColorGamut() { return colorGamut; }
    public void setColorGamut(String colorGamut) { this.colorGamut = colorGamut; }

    public int getBrightness() { return brightness; }
    public void setBrightness(int brightness) { this.brightness = brightness; }

    public int getRefreshRate() { return refreshRate; }
    public void setRefreshRate(int refreshRate) { this.refreshRate = refreshRate; }

    public String getHdr() { return hdr; }
    public void setHdr(String hdr) { this.hdr = hdr; }

    public String getPorts() { return ports; }
    public void setPorts(String ports) { this.ports = ports; }

    public boolean isAudioOut() { return audioOut; }
    public void setAudioOut(boolean audioOut) { this.audioOut = audioOut; }

    public String getFunctionKeys() { return functionKeys; }
    public void setFunctionKeys(String functionKeys) { this.functionKeys = functionKeys; }

    public float getWeight() { return weight; }
    public void setWeight(float weight) { this.weight = weight; }

    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }
}
