<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelAdmin.ProductSpecification, modelAdmin.ProductVariant" %>

<jsp:useBean id="specification" type="modelAdmin.ProductSpecification" scope="request"/>
<jsp:useBean id="variant" type="modelAdmin.ProductVariant" scope="request"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật sản phẩm</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2, h3 { color: #333; }
        form { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; }
        label { font-weight: bold; }
        input, textarea { width: 100%; padding: 8px; margin: 5px 0; border: 1px solid #ccc; border-radius: 5px; }
        button { background-color: #28a745; color: white; padding: 10px; border: none; cursor: pointer; }
        button:hover { background-color: #218838; }
    </style>
</head>
<body>

    <h2>Cập nhật sản phẩm</h2>
    
<form action="updateProduct" method="post">
    <input type="hidden" name="productId" value="<%= request.getAttribute("productId") %>">

        <h3>Thông số kỹ thuật</h3>
        <label>CPU:</label>
        <input type="text" name="cpu" value="${specification.cpu}">
        
        <label>RAM:</label>
        <input type="text" name="ram" value="${specification.ram}">
        
        <label>Lưu trữ:</label>
        <input type="text" name="storage" value="${specification.storage}">
        
        <label>Độ phân giải:</label>
        <input type="text" name="resolution" value="${specification.resolution}">
        
        <label>Card đồ họa:</label>
        <input type="text" name="graphics" value="${specification.graphics}">
        
        <label>Cổng kết nối:</label>
        <input type="text" name="ports" value="${specification.ports}">
        
        <label>Kết nối không dây:</label>
        <input type="text" name="wireless" value="${specification.wireless}">
        
        <label>Camera:</label>
        <input type="text" name="camera" value="${specification.camera}">
        
        <label>Pin:</label>
        <input type="text" name="battery" value="${specification.battery}">
        
        <label>Kích thước:</label>
        <input type="text" name="dimensions" value="${specification.dimensions}">
        
        <label>Trọng lượng:</label>
        <input type="text" name="weight" value="${specification.weight}">
        
        <label>Bàn phím:</label>
        <input type="text" name="keyboard" value="${specification.keyboard}">
        
        <label>Chất liệu:</label>
        <input type="text" name="material" value="${specification.material}">
        
        <label>Bảo hành:</label>
        <input type="text" name="warranty" value="${specification.warranty}">
        
        <label>Hệ điều hành:</label>
        <input type="text" name="os" value="${specification.os}">
        
        <label>Tình trạng:</label>
        <input type="text" name="condition" value="${specification.condition}">
        
        <label>Tần số quét:</label>
        <input type="text" name="refreshRate" value="${specification.refreshRate}">

        <h3>Biến thể sản phẩm</h3>
        <label>Giá:</label>
        <input type="number" name="price" step="0.01" value="${String.format('%.2f', variant.price)}">

        
        <label>Tồn kho:</label>
        <input type="number" name="stock" value="${variant.stock}">
        
        <br><br>
        <button type="submit">Cập nhật</button>
    </form>

</body>
</html>
