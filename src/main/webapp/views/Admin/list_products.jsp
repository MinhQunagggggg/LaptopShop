<%@page import="modelAdmin.ProductAdmin"%>
<%@page import="modelAdmin.Category"%>
<%@page import="modelAdmin.Brand"%>
<%@page import="DAOAdmin.BrandDAO"%>
<%@page import="DAOAdmin.CategoryDAO"%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="productDAO" class="DAOAdmin.ProductDAO" scope="request"/>
<%
    List<Category> categories = new CategoryDAO().getAllCategoriesMNgoc();
    List<Brand> brands = new BrandDAO().getAllBrandsMNgoc();

   
    Map<Integer, String> categoryMap = new HashMap<>();
    for (Category c : categories) {
        categoryMap.put(c.getCategoryId(), c.getName());
    }

    Map<Integer, String> brandMap = new HashMap<>();
    for (Brand b : brands) {
        brandMap.put(b.getBrandId(), b.getName());
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                height: 100vh;
                background-color: #343a40;
                color: white;
                padding-top: 20px;
                position: fixed;
                width: 250px;
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                padding: 10px;
                display: block;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            .content {
                margin-left: 260px;
                padding: 20px;
            }
            .table img {
                max-width: 70px;
                height: auto;
                border-radius: 8px;
                border: 1px solid #ddd;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4 class="text-center">Dashboard</h4>
            <a href="#">Quản lý sản phẩm</a>
            <ul class="list-unstyled ps-3">
                <li><a href="/add-product">Thêm sản phẩm</a></li>
                <li><a href="/list-products">Danh sách sản phẩm</a></li>
            </ul>
        </div>

        <div class="content">
            <h2 class="text-center mb-4 text-secondary">📋 Danh Sách Sản Phẩm</h2>
            <table class="table table-bordered table-hover">
                <thead>
                    <tr class="text-center">
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Mô tả</th>
                        <th>Danh mục</th>
                        <th>Thương hiệu</th>
                        <th>Hình ảnh</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<ProductAdmin> productList = (List<ProductAdmin>) request.getAttribute("productList");
                        if (productList != null && !productList.isEmpty()) {
                            for (ProductAdmin product : productList) {%>
                    <tr class="align-middle">
                        <td class="text-center"><%= product.getProductId()%></td>
                        <td><%= product.getName()%></td>
                        <td><%= product.getDescription()%></td>
                        <td class="text-center"><%= categoryMap.get(product.getCategoryId())%></td>
                        <td class="text-center"><%= brandMap.get(product.getBrandId())%></td>
                        <td class="text-center">
                            <% if (product.getImageData() != null) {%>
                            <img src="imageServlet?productId=<%= product.getProductId()%>" alt="Ảnh sản phẩm">
                            <% } else { %>
                            <span class="empty-message">Không có ảnh</span>
                            <% }%>
                        </td>
                        <td class="text-center">
                            <a href="EditProductServlet?productId=<%= product.getProductId()%>" class="btn btn-warning">✏ Sửa</a>
                            <a href="delete-product?productId=<%= product.getProductId()%>" class="btn btn-danger"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">🗑 Xóa</a>
                            <a href="${pageContext.request.contextPath}/updateProduct?productId=<%= product.getProductId()%>" 
                               class="btn btn-info">🔄 Cập nhật chi tiết</a>
                        </td>
                    </tr>
                    <%  }
                } else { %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">Không có sản phẩm nào.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
