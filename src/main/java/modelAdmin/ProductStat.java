/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelAdmin;

public class ProductStat {
    private int month;
    private int year;
    private String productName;
    private int totalQuantity;

    public ProductStat(int month, int year, String productName, int totalQuantity) {
        this.month = month;
        this.year = year;
        this.productName = productName;
        this.totalQuantity = totalQuantity;
    }

    public int getMonth() { return month; }
    public int getYear() { return year; }
    public String getProductName() { return productName; }
    public int getTotalQuantity() { return totalQuantity; }
}