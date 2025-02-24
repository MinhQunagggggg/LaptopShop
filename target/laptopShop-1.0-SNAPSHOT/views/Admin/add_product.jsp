<%@page import="modelAdmin.Category"%>
<%@page import="modelAdmin.Brand"%>
<%@page import="modelAdmin.Brand"%>
<%@page import="modelAdmin.SubBrand"%>
<%@page import="modelAdmin.Catalog"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<div class="container mt-4">
    <form action="add-product" method="post" enctype="multipart/form-data" class="border p-4 rounded shadow-sm bg-light">
        <h2 class="mb-4">Thêm sản phẩm</h2>
        
        <div class="mb-3">
            <label class="form-label">Tên sản phẩm:</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Mô tả:</label>
            <textarea name="description" class="form-control"></textarea>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Danh mục:</label>
            <select name="category_id" class="form-select">
                <option value="">-- Chọn danh mục --</option>
                <% for (Category c : new DAOAdmin.CategoryDAO().getAllCategoriesMNgoc()) {%>
                <option value="<%= c.getCategoryId()%>"><%= c.getName()%></option>
                <% } %>
            </select>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Thương hiệu:</label>
            <select name="brand_id" class="form-select">
                <option value="">-- Chọn thương hiệu --</option>
                <% for (Brand b : new DAOAdmin.BrandDAO().getAllBrandsMNgoc()) {%>
                <option value="<%= b.getBrandId()%>"><%= b.getName()%></option>
                <% } %>
            </select>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Sub-Brand:</label>
            <select name="subbrand_id" class="form-select">
                <option value="">-- Chọn sub-brand --</option>
                <% for (SubBrand sb : new DAOAdmin.SubBrandDAO().getAllSubBrandsMNgoc()) {%>
                <option value="<%= sb.getSubBrandId()%>"><%= sb.getName()%></option>
                <% } %>
            </select>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Danh mục Catalog:</label>
            <select name="catalog_id" id="catalogSelect" class="form-select" onchange="toggleCatalogForms()">
                <option value="">-- Chọn catalog --</option>
                <% for (Catalog cat : new DAOAdmin.CatalogDAO().getAllCatalogsMNgoc()) {%>
                <option value="<%= cat.getCatalogId()%>"><%= cat.getName()%></option>
                <% }%>
            </select>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Hình ảnh:</label>
            <input type="file" name="image_data" class="form-control" accept="image/*" required>
        </div>
        
        <!-- Form Laptop -->
        <div id="laptopSpecsForm" class="catalog-form" style="display:none;">
        <h3>Thông số Laptop</h3>
        <label>CPU:</label> <input type="text" name="cpu"><br>
        <label>RAM:</label> <input type="text" name="ram"><br>
        <label>Ổ cứng:</label> <input type="text" name="storage"><br>
        <label>Độ phân giải:</label> <input type="text" name="resolution"><br>
        <label>Card đồ họa:</label> <input type="text" name="graphics"><br>
        <label>Cổng kết nối:</label> <input type="text" name="ports"><br>
        <label>Không dây:</label> <input type="text" name="wireless"><br>
        <label>Camera:</label> <input type="text" name="camera"><br>
        <label>Pin:</label> <input type="text" name="battery"><br>
        <label>Kích thước:</label> <input type="text" name="dimensions"><br>
        <label>Trọng lượng:</label> <input type="text" name="weight"><br>
        <label>Bàn phím:</label> <input type="text" name="keyboard"><br>
        <label>Chất liệu:</label> <input type="text" name="material"><br>
        <label>Bảo hành:</label> <input type="text" name="warranty"><br>
        <label>Hệ điều hành:</label> <input type="text" name="os"><br>
        <label>Tình trạng:</label> <input type="text" name="condition"><br>
        <label>Tần số quét:</label> <input type="text" name="refresh_rate"><br>
    </div>


    <!-- Form Monitor -->
    <div id="monitorSpecsForm" class="catalog-form" style="display:none;">
        <h3>Thông số Monitor</h3>
        <label>Model:</label> <input type="text" name="model"><br>
        <label>Kích thước (inch):</label> <input type="number" name="size" step="0.1"><br>
        <label>Loại tấm nền:</label> <input type="text" name="panel_type"><br>
        <label>Độ phân giải:</label> <input type="text" name="resolution"><br>
        <label>Bit depth:</label> <input type="text" name="bit_depth"><br>
        <label>Color Gamut:</label> <input type="text" name="color_gamut"><br>
        <label>Độ sáng (nits):</label> <input type="number" name="brightness"><br>
        <label>Tần số quét (Hz):</label> <input type="number" name="refresh_rate"><br>
        <label>HDR:</label> <input type="text" name="hdr"><br>
        <label>Cổng kết nối:</label> <input type="text" name="ports"><br>

        <!-- Checkbox Audio Out -->
        <label>Có Audio Out?</label> 
        <input type="hidden" name="audio_out" value="off"> <!-- Nếu không chọn, sẽ gửi 'off' -->
        <input type="checkbox" name="audio_out" value="on"><br>

        <label>Phím chức năng:</label> <input type="text" name="function_keys"><br>
        <label>Trọng lượng (kg):</label> <input type="number" name="weight" step="0.1"><br>
        <label>Kích thước:</label> <input type="text" name="dimensions"><br>
        <label>Màu sắc:</label> <input type="text" name="color"><br>
    </div>

    <!-- Form Mouse -->
    <div id="mouseSpecsForm" class="catalog-form" style="display:none;">
        <h3>Thông số Chuột</h3>
        <label>Hãng sản xuất:</label> <input type="text" name="brand"><br>
        <label>Bảo hành (tháng):</label> <input type="number" name="warranty_months"><br>
        <label>Loại kết nối:</label> <input type="text" name="connection_type"><br>
        <label>Có dây:</label> <input type="checkbox" name="wired"><br>
        <label>DPI:</label> <input type="number" name="dpi"><br>
        <label>Loại switch:</label> <input type="text" name="switch_type"><br>
        <label>Đèn LED:</label> <input type="text" name="mouse_led"><br>
        <label>Màu sắc:</label> <input type="text" name="color"><br>
        <label>Kích thước:</label> <input type="text" name="dimensions"><br>
        <label>Trọng lượng (g):</label> <input type="number" name="weight" step="0.01"><br>
    </div>

    <!-- Form Keyboard -->
    <div id="keyboardSpecsForm" class="catalog-form" style="display:none;">
        <h3>Thông số Bàn Phím</h3>

        <label>Thương hiệu:</label> 
        <input type="text" name="brand"><br>

        <label>Loại kết nối:</label> 
        <input type="text" name="connection_type"><br>

        <label>Có phải bàn phím cơ?</label> 
        <select name="mechanical">
            <option value="true">Có</option>
            <option value="false">Không</option>
        </select><br>

        <label>Loại switch:</label> 
        <input type="text" name="switch_type"><br>

        <label>Có đèn RGB?</label> 
        <select name="rgb">
            <option value="true">Có</option>
            <option value="false">Không</option>
        </select><br>

        <label>Bố cục bàn phím:</label> 
        <input type="text" name="layout"><br>

        <label>Kích thước:</label> 
        <input type="text" name="dimensions"><br>

        <label>Trọng lượng (g):</label> 
        <input type="number" name="weight" step="0.01"><br>

        <label>Bảo hành (tháng):</label> 
        <input type="number" name="warranty_months"><br>
    </div>

    <!-- Form Headphone -->
    <div id="headphoneSpecsForm" class="catalog-form" style="display:none;">
        <h3>Thông số Tai nghe</h3>
        <label>Loại tai nghe:</label> <input type="text" name="headphone_type"><br>
        <label>Kết nối:</label> <input type="text" name="connection_type"><br>
        <label>Độ nhạy (dB):</label> <input type="number" name="sensitivity"><br>
        <label>Trở kháng (Ohm):</label> <input type="number" name="impedance"><br>
        <label>Dải tần số (Hz):</label> <input type="text" name="frequency_response"><br>
        <label>Micro:</label> <input type="text" name="microphone"><br>
        <label>Bảo hành (tháng):</label> <input type="number" name="warranty_months"><br>
    </div>


    <!-- Form ProductVariant -->
    <div id="productVariantForm">
        <h3>Thông tin biến thể sản phẩm</h3>
        <label>Giá:</label> <input type="number" name="price" step="0.01" required><br>
        <label>Số lượng:</label> <input type="number" name="stock" required><br>
    </div>

    <input type="submit" value="Thêm sản phẩm">
</form>

<script>
    function toggleCatalogForms() {
        var catalogSelect = document.getElementById("catalogSelect");
        var selectedCatalog = catalogSelect.options[catalogSelect.selectedIndex].text;

        var forms = document.getElementsByClassName("catalog-form");
        for (var i = 0; i < forms.length; i++) {
            forms[i].style.display = "none";
        }

        if (selectedCatalog === "Monitor") {
            document.getElementById("monitorSpecsForm").style.display = "block";
        } else if (selectedCatalog === "Laptop") {
            document.getElementById("laptopSpecsForm").style.display = "block";
        } else if (selectedCatalog === "Mouse") {
            document.getElementById("mouseSpecsForm").style.display = "block";
        } else if (selectedCatalog === "Keyboard") {
            document.getElementById("keyboardSpecsForm").style.display = "block";
        } else if (selectedCatalog === "Headphones") {
            document.getElementById("headphoneSpecsForm").style.display = "block";
        }
    }
</script>