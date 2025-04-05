package model;

import java.util.Date;

public class WarrantyItem {

    private int variantId, orderdetailId, userId, productId;
    private String productName;
    private String ram;
    private Date purchaseDate;
    private Date warrantyEndDate;
    private Date warrantyStartDate;
    private String serviceCenter;
    private String notes;
    private String name;
    private String phone;
    private String address;
    private int statusId;
    private int warrantyId;
    private Date warrantyDate;

    public WarrantyItem(int warrantyId, int orderdetailId, int productId, int userId, String serviceCenter,
            String notes, String name, String phone, String address, int statusId, int variantId) {
        this.warrantyId = warrantyId;
        this.orderdetailId = orderdetailId;
        this.productId = productId;
        this.userId = userId;
        this.serviceCenter = serviceCenter;
        this.notes = notes;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.statusId = statusId;
        this.variantId = variantId;
    }

    // Constructor rỗng (giữ nguyên)
    public WarrantyItem() {
    }

    // Constructor với 7 tham số (giữ nguyên, nhưng thêm startDate)
    public WarrantyItem(int variantId, int orderdetailId, String productName, String ram, Date warrantyEndDate, Date warrantyStartDate, int statusId, int warrantyId) {
        this.variantId = variantId;
        this.orderdetailId = orderdetailId;
        this.productName = productName;
        this.ram = ram;
        this.warrantyEndDate = warrantyEndDate;
        this.warrantyStartDate = warrantyStartDate;
        this.statusId = statusId;
        this.warrantyId = warrantyId;
    }

    public WarrantyItem(int variantId, int orderdetailId, String productName, String ram, Date warrantyEndDate, Date warrantyStartDate) {
        this.variantId = variantId;
        this.orderdetailId = orderdetailId;
        this.productName = productName;
        this.ram = ram;
        this.warrantyEndDate = warrantyEndDate;
        this.warrantyStartDate = warrantyStartDate;
    }

    public WarrantyItem(int userId, int productId) {
        this.userId = userId;
        this.productId = productId;
    }

    public Date getWarrantyDate() {
        return warrantyDate;
    }

    public void setWarrantyDate(Date warrantyDate) {
        this.warrantyDate = warrantyDate;
    }

    public String getServiceCenter() {
        return serviceCenter;
    }

    public void setServiceCenter(String serviceCenter) {
        this.serviceCenter = serviceCenter;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public int getWarrantyId() {
        return warrantyId;
    }

    public void setWarrantyId(int warrantyId) {
        this.warrantyId = warrantyId;
    }

    public Date getWarrantyStartDate() {
        return warrantyStartDate;
    }

    public void setWarrantyStartDate(Date warrantyStartDate) {
        this.warrantyStartDate = warrantyStartDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    // Getter và Setter hiện có (giữ nguyên)
    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public int getOrderdetailId() {
        return orderdetailId;
    }

    public void setOrderdetailId(int orderdetailId) {
        this.orderdetailId = orderdetailId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public Date getWarrantyEndDate() {
        return warrantyEndDate;
    }

    public void setWarrantyEndDate(Date warrantyEndDate) {
        this.warrantyEndDate = warrantyEndDate;
    }

}
