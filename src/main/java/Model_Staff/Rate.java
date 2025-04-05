package Model_Staff;

/**
 *
 * @author PC
 */
public class Rate {
    private int rating_id;
    private int user_id;
    private int product_id;
    private int rating;
    private String name;
    private String phone;
    private byte[] imageUser; // Lưu ảnh dưới dạng byte[] từ VARBINARY

    public Rate() {
    }

    public Rate(int rating_id, int user_id, int product_id, int rating, String name, String phone, byte[] imageUser) {
        this.rating_id = rating_id;
        this.user_id = user_id;
        this.product_id = product_id;
        this.rating = rating;
        this.name = name;
        this.phone = phone;
        this.imageUser = imageUser;
    }

    public int getRating_id() {
        return rating_id;
    }

    public void setRating_id(int rating_id) {
        this.rating_id = rating_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
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

    public byte[] getImageUser() {
        return imageUser;
    }

    public void setImageUser(byte[] imageUser) {
        this.imageUser = imageUser;
    }
}
