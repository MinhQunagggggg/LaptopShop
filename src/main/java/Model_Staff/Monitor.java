package Model_Staff;


public class Monitor {
    private int productId;
    private String model;
    private double size;
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
    private double weight;
    private String dimensions;
    private String color;

    // ✅ Constructor hợp lệ
    public Monitor(int productId, String model, double size, String panelType, String resolution, 
                   String bitDepth, String colorGamut, int brightness, int refreshRate, 
                   String hdr, String ports, boolean audioOut, String functionKeys, 
                   double weight, String dimensions, String color) {
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
    }

    // 👉 Thêm các getter và setter nếu cần
    public int getProductId() {
        return productId;
    }

    public String getModel() {
        return model;
    }

    public double getSize() {
        return size;
    }

    public String getPanelType() {
        return panelType;
    }

    public String getResolution() {
        return resolution;
    }

    public String getBitDepth() {
        return bitDepth;
    }

    public String getColorGamut() {
        return colorGamut;
    }

    public int getBrightness() {
        return brightness;
    }

    public int getRefreshRate() {
        return refreshRate;
    }

    public String getHdr() {
        return hdr;
    }

    public String getPorts() {
        return ports;
    }

    public boolean isAudioOut() {
        return audioOut;
    }

    public String getFunctionKeys() {
        return functionKeys;
    }

    public double getWeight() {
        return weight;
    }

    public String getDimensions() {
        return dimensions;
    }

    public String getColor() {
        return color;
    }
}
