package modelAdmin;

public class Stat {
    private int month;
    private int year;
    private int count;

    public Stat(int month, int year, int count) {
        this.month = month;
        this.year = year;
        this.count = count;
    }

    public int getMonth() { return month; }
    public int getYear() { return year; }
    public int getCount() { return count; }
}

