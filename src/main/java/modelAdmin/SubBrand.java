package modelAdmin;

public class SubBrand {
    private int subBrandId;
    private String name;

    public SubBrand(int subBrandId, String name) {
        this.subBrandId = subBrandId;
        this.name = name;
    }

    // Getter và Setter

    public int getSubBrandId() {
        return subBrandId;
    }

    public void setSubBrandId(int subBrandId) {
        this.subBrandId = subBrandId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
