/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 *
 * @author CE182250
 */
public class Product {
    private int id;
    private String name;
    private String description;
    private String imageUrl;
    private double price;
    private String brandName;
    private String categoryName;
    private String subBrandName;
    private String accessoryBrand;
    private String ram;
    private String cpu;
    private String storage;
    private String screen;
    private String ports;
    private String battery;
    private String weight;
    private String dimensions;
    private String os;
    private String keyboard;
    private String material;
    private String warranty;
    private String condition;
    private String refreshRate;
    private double averageRating;
    private String comments;
     private int catalogId;
     private Map<String, String> specifications;

   public Product(int id, String name, String imageUrl, String description, double price, String brandName, String categoryName, int catalogId) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
        this.description = description;
        this.price = price;
        this.brandName = brandName;
        this.categoryName = categoryName;
        this.catalogId = catalogId;
    }
    

 public Product(int id, String name, String imageUrl, double price, String brandName, String description) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
        this.price = price;
        this.brandName = brandName;
        this.description = description;
    }

    public Product(int id, String name, String imageUrl, double price, String description) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
        this.price = price;
        this.description = description;
    }

    public Product(int id, String name, String imageUrl, double price) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
        this.price = price;
    }

// Getter để lấy dữ liệu trong JSP
    public int getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public String getImageUrl() { return imageUrl; }
    public double getPrice() { return price; }
    public String getBrandName() { return brandName; }
    public String getCategoryName() { return categoryName; }
    public String getSubBrandName() { return subBrandName; }
    public String getAccessoryBrand() { return accessoryBrand; }
    public String getRam() { return ram; }
    public String getCpu() { return cpu; }
    public String getStorage() { return storage; }
    public String getScreen() { return screen; }
    public String getPorts() { return ports; }
    public String getBattery() { return battery; }
    public String getWeight() { return weight; }
    public String getDimensions() { return dimensions; }
    public String getOs() { return os; }
    public String getKeyboard() { return keyboard; }
    public String getMaterial() { return material; }
    public String getWarranty() { return warranty; }
    public String getCondition() { return condition; }
    public String getRefreshRate() { return refreshRate; }
    public double getAverageRating() { return averageRating; }
    public String getComments() { return comments; }
    public int getCatalogId() { return catalogId; }
    public Map<String, String> getSpecifications() { return specifications; }

    public void setSpecifications(Map<String, String> specifications) {
        this.specifications = specifications;
    }
    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }
     public List<String> getCommentsList() {
        if (comments == null || comments.isEmpty()) {
            return new ArrayList<>();
        }
        return Arrays.asList(comments.split("\\|"));
    }
}


   