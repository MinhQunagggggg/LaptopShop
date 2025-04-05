package Model_Staff;

import java.sql.Timestamp;

public class Warranty {
    private int warranty_id;
    private int oder_detail_id;
    private int user_id;
    private String name;  // Thêm thuộc tính name
    private String phone; // Thêm thuộc tính phone
    private String address;
    private int status_id;
    private String sevice_center;
    private String notes;
    private Timestamp date;

    public Warranty() {
    }

    public Warranty(int warranty_id, int oder_detail_id, int user_id, String name, String phone, String address, int status_id, String sevice_center, String notes, Timestamp date) {
        this.warranty_id = warranty_id;
        this.oder_detail_id = oder_detail_id;
        this.user_id = user_id;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.status_id = status_id;
        this.sevice_center = sevice_center;
        this.notes = notes;
        this.date = date;
    }

 

    public int getWarranty_id() {
        return warranty_id;
    }

    public void setWarranty_id(int warranty_id) {
        this.warranty_id = warranty_id;
    }

    public int getOder_detail_id() {
        return oder_detail_id;
    }

    public void setOder_detail_id(int oder_detail_id) {
        this.oder_detail_id = oder_detail_id;
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

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public String getSevice_center() {
        return sevice_center;
    }

    public void setSevice_center(String sevice_center) {
        this.sevice_center = sevice_center;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
     public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
}
