/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBContext;
import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.ProductVariant;

/**
 *
 * @author CE182250
 */
public class ProductDAO {

    public List<Product> getProductsByCatalog(String catalogName) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.product_id, p.name, p.image_data, v.price "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "JOIN ProductTypes c ON p.catalog_id = c.catalog_id "
                + "WHERE c.name = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, catalogName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<String> getAllCatalogs() {
        List<String> catalogs = new ArrayList<>();
        String query = "SELECT DISTINCT name FROM ProductTypes";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                catalogs.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return catalogs;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String query = "SELECT DISTINCT name FROM UsageCategories";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categories.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {
        List<Product> products = new ArrayList<>();

        String query = "SELECT DISTINCT p.product_id, "
                + "       p.name AS product_name, "
                + "       p.image_data, "
                + "       v.price "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "WHERE v.price BETWEEN ? AND ? "
                + "ORDER BY v.price ASC";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Product> getProductsByCategories(String categoryName) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.product_id, p.name, p.image_data, v.price "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "JOIN UsageCategories c ON p.category_id = c.category_id "
                + "WHERE c.name = ? "
                + "ORDER BY p.product_id";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<String> getBrandsByCatalog(String catalogName) {
        List<String> brands = new ArrayList<>();
        String query = "SELECT DISTINCT b.name FROM Brands b "
                + "JOIN Products p ON b.brand_id = p.brand_id "
                + "JOIN Catalog c ON p.catalog_id = c.catalog_id "
                + "WHERE c.name = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, catalogName);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    brands.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    public List<Product> getProductsByCatalogAndBrand(String catalogName, String brandName) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.product_id, p.name, p.image_data, v.price "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "JOIN Brands b ON p.brand_id = b.brand_id "
                + "JOIN Catalog c ON p.catalog_id = c.catalog_id "
                + "WHERE c.name = ? AND b.name = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, catalogName);
            ps.setString(2, brandName);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(new Product(
                            rs.getInt("product_id"),
                            rs.getString("name"),
                            rs.getBytes("image_data"),
                            rs.getDouble("price")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean doesCatalogHaveBrands(String catalogName) {
        String query = "SELECT COUNT(DISTINCT b.brand_id) FROM Brands b "
                + "JOIN Products p ON b.brand_id = p.brand_id "
                + "JOIN Catalog c ON p.catalog_id = c.catalog_id "
                + "WHERE c.name = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, catalogName);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return true; // Danh mục có brand
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Danh mục không có brand
    }

    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT TOP 10 "
                + "    p.product_id, p.name AS product_name, p.image_data, "
                + "    p.description, COALESCE(b.name, 'N/A') AS brand_name, "
                + "    v.price, v.stock "
                + "FROM Products p "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN ProductVariants v ON p.product_id = v.product_id "
                + "WHERE p.name LIKE ? "
                + "   OR SOUNDEX(p.name) = SOUNDEX(?) "
                + // Tìm theo phát âm tương tự
                "ORDER BY p.name ASC;";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + txtSearch + "%");
            ps.setString(2, txtSearch);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price"),
                        rs.getString("brand_name"),
                        rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getAccessoryCatalogs() {
        List<String> catalogs = new ArrayList<>();
        String query = "SELECT name FROM Catalog WHERE catalog_id != 1"; // Bỏ Laptop

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                catalogs.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return catalogs;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.product_id, p.name, p.image_data, v.price, b.name as brand_name, p.description "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "JOIN Brands b ON p.brand_id = b.brand_id";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getBytes("image_data"),
                        rs.getDouble("price"),
                        rs.getString("brand_name"),
                        rs.getString("description") // ✅ Lấy mô tả sản phẩm
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy danh sách tất cả thương hiệu
    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        String query = "SELECT DISTINCT name FROM Brands";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                brands.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    // Lọc sản phẩm theo thương hiệu
    public List<Product> getProductsByBrand(String brandName) {
        List<Product> products = new ArrayList<>();
        String query = "WITH UniqueProducts AS ( "
                + "    SELECT p.product_id, p.name, p.image_data, v.price, "
                + "           ROW_NUMBER() OVER (PARTITION BY p.name ORDER BY v.price ASC) AS rank "
                + "    FROM Products p "
                + "    JOIN ProductVariants v ON p.product_id = v.product_id "
                + "    JOIN Brands b ON p.brand_id = b.brand_id "
                + "    WHERE b.name = ? "
                + ") "
                + "SELECT product_id, name, image_data, price FROM UniqueProducts WHERE rank = 1";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, brandName);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(new Product(
                            rs.getInt("product_id"),
                            rs.getString("name"),
                            rs.getBytes("image_data"),
                            rs.getDouble("price"),
                            brandName // Giữ nguyên cách gọi constructor
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<String> getSubBrandsByBrand(String brandName) {
        List<String> subBrands = new ArrayList<>();
        String query = "SELECT name \n"
                + "FROM SubBrands \n"
                + "WHERE brand_id = (\n"
                + "    SELECT brand_id \n"
                + "    FROM Brands \n"
                + "    WHERE name = ?\n"
                + ");";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, brandName);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    subBrands.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subBrands;
    }

    public List<Product> getProductsBySubBrand(String subBrandName) {
        List<Product> products = new ArrayList<>();
        String query = "WITH UniqueProducts AS ( "
                + "    SELECT p.product_id, p.name, p.image_data, v.price, "
                + "           ROW_NUMBER() OVER (PARTITION BY p.name ORDER BY v.price ASC) AS rank "
                + "    FROM Products p "
                + "    JOIN ProductVariants v ON p.product_id = v.product_id "
                + "    JOIN SubBrands sb ON p.subbrand_id = sb.subbrand_id "
                + "    WHERE sb.name = ? "
                + ") "
                + "SELECT product_id, name, image_data, price FROM UniqueProducts WHERE rank = 1";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, subBrandName);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(new Product(
                            rs.getInt("product_id"),
                            rs.getString("name"),
                            rs.getBytes("image_data"),
                            rs.getDouble("price"),
                            subBrandName
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<String> getSubBrandsOfLenovo() {
        List<String> subBrands = new ArrayList<>();
        String query = "SELECT name FROM SubBrands WHERE brand_id = (SELECT brand_id FROM Brands WHERE name = 'Lenovo')";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                subBrands.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subBrands;
    }

    // Phân trang sản phẩm theo thương hiệu
    public List<Product> getProductsByBrandWithPagination(String brand, int page, int pageSize) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM ( "
                + "   SELECT p.product_id, p.name, p.image_data, v.price, "
                + "          ROW_NUMBER() OVER (ORDER BY p.product_id) AS row_num "
                + "   FROM Products p "
                + "   JOIN ProductVariants v ON p.product_id = v.product_id "
                + "   JOIN Brands b ON p.brand_id = b.brand_id "
                + "   WHERE b.name = ? "
                + ") AS TempTable "
                + "WHERE row_num BETWEEN ? AND ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, brand);
            ps.setInt(2, (page - 1) * pageSize + 1);
            ps.setInt(3, page * pageSize);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Product(
                            rs.getInt("product_id"),
                            rs.getString("name"),
                            rs.getBytes("image_data"),
                            rs.getDouble("price"),
                            brand
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy tổng số sản phẩm của thương hiệu
    public int getTotalProductsByBrand(String brand) {
        String query = "SELECT COUNT(*) FROM Products p "
                + "JOIN Brands b ON p.brand_id = b.brand_id "
                + "WHERE b.name = ?";
        int total = 0;

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, brand);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Lấy chi tiết sản phẩm theo ID
    public Product getProductInfo(int productId) {
        String query = "SELECT p.product_id, p.name, p.image_data, p.description, "
                + "v.price, b.name AS brand_name, c.name AS category_name, p.catalog_id "
                + "FROM Products p "
                + "LEFT JOIN ProductVariants v ON p.product_id = v.product_id "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN UsageCategories c ON p.category_id = c.category_id "
                + "WHERE p.product_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("product_id"),
                            rs.getString("name"),
                            rs.getBytes("image_data"), // ✅ Đọc dữ liệu ảnh dạng `byte[]`
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("brand_name"),
                            rs.getString("category_name"),
                            rs.getInt("catalog_id")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy thông số kỹ thuật của sản phẩm theo `catalog_id`
    public void getProductSpecifications(Product product) {
        String query = "DECLARE @product_id INT = ?; "
                + "DECLARE @catalog_id INT; "
                + "DECLARE @sql NVARCHAR(MAX) = ''; "
                + "SELECT @catalog_id = catalog_id FROM Products WHERE product_id = @product_id; "
                + "IF @catalog_id = 1 "
                + "BEGIN "
                + "    SET @sql = 'SELECT * FROM LaptopSpecifications WHERE product_id = ' + CAST(@product_id AS NVARCHAR); "
                + "END "
                + "ELSE IF @catalog_id = 2 "
                + "BEGIN "
                + "    SET @sql = 'SELECT * FROM Monitors WHERE product_id = ' + CAST(@product_id AS NVARCHAR); "
                + "END "
                + "ELSE IF @catalog_id = 3 "
                + "BEGIN "
                + "    SET @sql = 'SELECT * FROM Mouse WHERE product_id = ' + CAST(@product_id AS NVARCHAR); "
                + "END "
                + "ELSE IF @catalog_id = 4 "
                + "BEGIN "
                + "    SET @sql = 'SELECT * FROM Keyboards WHERE product_id = ' + CAST(@product_id AS NVARCHAR); "
                + "END "
                + "ELSE IF @catalog_id = 5 "
                + "BEGIN "
                + "    SET @sql = 'SELECT * FROM Headphones WHERE product_id = ' + CAST(@product_id AS NVARCHAR); "
                + "END "
                + "ELSE "
                + "BEGIN "
                + "    SET @sql = 'SELECT NULL AS message'; "
                + "END; "
                + "EXEC sp_executesql @sql;";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, product.getId());
            ResultSet rs = ps.executeQuery();

            Map<String, String> specifications = new LinkedHashMap<>();
            while (rs.next()) {
                for (int i = 3; i <= rs.getMetaData().getColumnCount(); i++) {
                    String columnName = rs.getMetaData().getColumnName(i);
                    String columnValue = rs.getString(i);
                    if (columnValue != null && !columnValue.equals("N/A")) {
                        specifications.put(columnName, columnValue);
                    }
                }
            }
            product.setSpecifications(specifications);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ProductVariant> getRamOptionsByProductId(int productId) {
        List<ProductVariant> ramOptions = new ArrayList<>();
        String query = "SELECT variant_id, ram, price FROM ProductVariants WHERE product_id = ? ORDER BY ram ASC";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ramOptions.add(new ProductVariant(
                            rs.getInt("variant_id"),
                            rs.getString("ram"),
                            rs.getDouble("price")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ramOptions;
    }

}
