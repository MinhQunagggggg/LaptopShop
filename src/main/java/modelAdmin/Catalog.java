package modelAdmin;

public class Catalog {
    private int catalogId;
    private String name;

    public Catalog(int catalogId, String name) {
        this.catalogId = catalogId;
        this.name = name;
    }

    // Getter và Setter

    public int getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(int catalogId) {
        this.catalogId = catalogId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
