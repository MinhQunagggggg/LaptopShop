<%@page import="DAOAdmin.ProductDAO"%>
<%@page import="modelAdmin.ProductAdmin"%>
<%@page import="modelAdmin.SubBrand"%>
<%@page import="modelAdmin.Catalog"%>
<%@page import="modelAdmin.Brand"%>
<%@page import="modelAdmin.Category"%>
<%@page import="DAOAdmin.SubBrandDAO"%>
<%@page import="DAOAdmin.CategoryDAO"%>
<%@page import="DAOAdmin.CatalogDAO"%>
<%@page import="DAOAdmin.BrandDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.List"%>

<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDAO productDAO = new ProductDAO();
    ProductAdmin product = productDAO.getProductById(productId);

    if (product == null) {
        response.sendRedirect("list_products.jsp?error=notfound");
        return;
    }

%>
<%    // Lấy danh sách tất cả danh mục, thương hiệu, sub-brand, catalog
    CategoryDAO categoryDAO = new CategoryDAO();
    BrandDAO brandDAO = new BrandDAO();
    SubBrandDAO subBrandDAO = new SubBrandDAO();
    CatalogDAO catalogDAO = new CatalogDAO();

    List<Category> categories = categoryDAO.getAllCategoriesMNgoc();
    List<Brand> brands = brandDAO.getAllBrands();
    List<SubBrand> subBrands = subBrandDAO.getAllSubBrandsMNgoc();
    List<Catalog> catalogs = catalogDAO.getAllCatalogsMNgoc();
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa sản phẩm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f9;
            }
            h2 {
                text-align: center;
                margin-top: 20px;
                color: #333;
            }
            .form-container {
                width: 50%;
                margin: 0 auto;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            label {
                font-weight: bold;
                margin-bottom: 8px;
                display: block;
                color: #333;
            }
            input[type="text"], textarea, select, input[type="file"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 4px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }
            button {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
            .error-message {
                color: red;
                text-align: center;
                margin-top: 20px;
            }
            .image-preview {
                margin: 10px 0;
            }
            .image-preview img {
                width: 150px;
                height: auto;
            }
        </style>
    </head>
    <body>
        <h2>Chỉnh sửa sản phẩm</h2>
        <div class="form-container">
            <form action="EditProductServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="<%= product.getProductId()%>">

                <label for="name">Tên sản phẩm:</label>
                <input type="text" id="name" name="name" value="<%= product.getName()%>" required>

                <label for="description">Mô tả:</label>
                <textarea id="description" name="description" required><%= product.getDescription()%></textarea>

                <label for="categoryId">Danh mục:</label>
                <select name="categoryId" required>
                    <% for (Category category : categories) {%>
                    <option value="<%= category.getCategoryId()%>" <%= (category.getCategoryId() == product.getCategoryId()) ? "selected" : ""%>>
                        <%= category.getName()%>
                    </option>
                    <% } %>
                </select>

                <label for="brandId">Thương hiệu:</label>
                <select name="brandId" required>
                    <% for (Brand brand : brands) {%>
                    <option value="<%= brand.getBrandId()%>" <%= (brand.getBrandId() == product.getBrandId()) ? "selected" : ""%>>
                        <%= brand.getName()%>
                    </option>
                    <% } %>
                </select>

                <label for="subBrandId">Sub-brand:</label>
                <select name="subBrandId" required>
                    <% for (SubBrand subBrand : subBrands) {%>
                    <option value="<%= subBrand.getSubBrandId()%>" <%= (subBrand.getSubBrandId() == product.getSubBrandId()) ? "selected" : ""%>>
                        <%= subBrand.getName()%>
                    </option>
                    <% } %>
                </select>

                <label for="catalogId">Catalog:</label>
                <select name="catalogId" required>
                    <% for (Catalog catalog : catalogs) {%>
                    <option value="<%= catalog.getCatalogId()%>" <%= (catalog.getCatalogId() == product.getCatalogId()) ? "selected" : ""%>>
                        <%= catalog.getName()%>
                    </option>
                    <% } %>
                </select>

                <div class="image-preview">
                    <label>Hình ảnh hiện tại:</label><br>
                    <% if (product.getImageData() != null) {%>
                    <img src="data:image/png;base64,<%= Base64.getEncoder().encodeToString(product.getImageData())%>" alt="Current Image">
                    <% } else { %>
                    Không có ảnh
                    <% } %>
                </div>

                <label for="imageData">Chọn ảnh mới (nếu có):</label>
                <input type="file" name="imageData">

                <button type="submit">Cập nhật</button>
            </form>

            <% if (request.getParameter("updateError") != null) { %>
            <div class="error-message">
                <p>Lỗi cập nhật sản phẩm!</p>
            </div>
            <% }%>
        </div>
    </body>
</html>
