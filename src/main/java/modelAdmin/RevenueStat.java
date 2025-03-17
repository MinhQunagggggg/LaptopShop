/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelAdmin;

public class RevenueStat {
    private int month;
    private int year;
    private double totalRevenue;

    public RevenueStat(int month, int year, double totalRevenue) {
        this.month = month;
        this.year = year;
        this.totalRevenue = totalRevenue;
    }

    public int getMonth() { return month; }
    public int getYear() { return year; }
    public double getTotalRevenue() { return totalRevenue; }
}