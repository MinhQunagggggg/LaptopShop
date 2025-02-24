package modelAdmin;

public class ProductAdmin {
    private int productId;
    private String name;
    private String description;
    private int categoryId;
    private int brandId;
    private int subBrandId;
    private int catalogId;
    private byte[] imageData;

    // Constructor không có productId (Khi tạo mới sản phẩm)
    public ProductAdmin(String name, String description, int categoryId, int brandId, int subBrandId, int catalogId, byte[] imageData) {
        this.name = name;
        this.description = description;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.subBrandId = subBrandId;
        this.catalogId = catalogId;
        this.imageData = imageData;
    }

    // Constructor đầy đủ (Dùng khi lấy sản phẩm từ database)
    public ProductAdmin(int productId, String name, String description, int categoryId, int brandId, int subBrandId, int catalogId, byte[] imageData) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.subBrandId = subBrandId;
        this.catalogId = catalogId;
        this.imageData = imageData;
    }

    

    // Getter và Setter
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getSubBrandId() {
        return subBrandId;
    }

    public void setSubBrandId(int subBrandId) {
        this.subBrandId = subBrandId;
    }

    public int getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(int catalogId) {
        this.catalogId = catalogId;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }
}
