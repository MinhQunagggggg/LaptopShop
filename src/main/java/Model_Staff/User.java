package Model_Staff;

/**
 *
 * @author PC
 */
public class User {

    private int id;
    private String name;
    private String username;
    private String email;
    private String phone;
    private String password;
    private byte[] avatarUrl;  // Sửa từ String thành byte[]
    private int role_id;
    private String address;

    public User() {
    }

    public User(int id, String name, String username, String email, String phone, String password, byte[] avatarUrl, int role_id, String address) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.avatarUrl = avatarUrl;  // Sửa từ String thành byte[]
        this.role_id = role_id;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public byte[] getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(byte[] avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
