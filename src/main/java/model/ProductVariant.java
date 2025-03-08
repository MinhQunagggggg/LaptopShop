/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author CE182250
 */
public class ProductVariant {
    private int variantId;
    private String ram;
    private double price;

    public ProductVariant(int variantId, String ram, double price) {
        this.variantId = variantId;
        this.ram = ram;
        this.price = price;
    }

    public int getVariantId() { return variantId; }
    public String getRam() { return ram; }
    public double getPrice() { return price; }
}
