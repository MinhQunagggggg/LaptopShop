<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelAdmin.Keyboard" %>
<%@ page import="modelAdmin.ProductVariant" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    Keyboard keyboard = (Keyboard) request.getAttribute("keyboard");
    ProductVariant variant = (ProductVariant) request.getAttribute("variant");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật bàn phím</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .form-label { font-weight: 600; }
        .btn-submit { background-color: #2c7be5; color: white; }
        .btn-submit:hover { background-color: #2567c9; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="container form-container">
        <h2 class="text-center mb-4">Cập nhật thông tin bàn phím</h2>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="updateKeyboard" method="post">
            <input type="hidden" name="productId" value="<%= keyboard.getProductId() %>">
            
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Thương hiệu</label>
                    <select class="form-control" name="brand" required>
                        <option value="<%= keyboard.getBrand() != null ? keyboard.getBrand() : "" %>" selected><%= keyboard.getBrand() != null ? keyboard.getBrand() : "Chọn thương hiệu" %></option>
                        <option value="Logitech">Logitech</option>
                        <option value="Razer">Razer</option>
                        <option value="Corsair">Corsair</option>
                        <option value="SteelSeries">SteelSeries</option>
                        <option value="Keychron">Keychron</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Thời gian bảo hành (tháng)</label>
                    <input type="number" class="form-control" name="warrantyMonths" value="<%= keyboard.getWarrantyMonths() %>" required>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Loại bàn phím</label>
                    <select class="form-control" name="type" required>
                        <option value="<%= keyboard.getType() != null ? keyboard.getType() : "" %>" selected><%= keyboard.getType() != null ? keyboard.getType() : "Chọn loại bàn phím" %></option>
                        <option value="Mechanical">Mechanical</option>
                        <option value="Membrane">Membrane</option>
                        <option value="Hybrid">Hybrid</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Kiểu kết nối</label>
                    <select class="form-control" name="connectionType" required>
                        <option value="<%= keyboard.getConnectionType() != null ? keyboard.getConnectionType() : "" %>" selected><%= keyboard.getConnectionType() != null ? keyboard.getConnectionType() : "Chọn kiểu kết nối" %></option>
                        <option value="USB">USB</option>
                        <option value="Bluetooth">Bluetooth</option>
                        <option value="2.4GHz Wireless">2.4GHz Wireless</option>
                        <option value="USB + Wireless">USB + Wireless</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Có dây</label>
                    <select class="form-control" name="wired">
                        <option value="true" <%= keyboard.isWired() ? "selected" : "" %>>Có</option>
                        <option value="false" <%= !keyboard.isWired() ? "selected" : "" %>>Không</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Chất liệu keycap</label>
                    <select class="form-control" name="keycapMaterial">
                        <option value="<%= keyboard.getKeycapMaterial() != null ? keyboard.getKeycapMaterial() : "" %>" selected><%= keyboard.getKeycapMaterial() != null ? keyboard.getKeycapMaterial() : "Chọn chất liệu" %></option>
                        <option value="ABS">ABS</option>
                        <option value="PBT">PBT</option>
                        <option value="POM">POM</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Loại switch</label>
                    <select class="form-control" name="switchType">
                        <option value="<%= keyboard.getSwitchType() != null ? keyboard.getSwitchType() : "" %>" selected><%= keyboard.getSwitchType() != null ? keyboard.getSwitchType() : "Chọn loại switch" %></option>
                        <option value="Cherry MX Red">Cherry MX Red</option>
                        <option value="Cherry MX Blue">Cherry MX Blue</option>
                        <option value="Cherry MX Brown">Cherry MX Brown</option>
                        <option value="Gateron Red">Gateron Red</option>
                        <option value="Kailh Box White">Kailh Box White</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Màu sắc</label>
                    <select class="form-control" name="color" required>
                        <option value="<%= keyboard.getColor() != null ? keyboard.getColor() : "" %>" selected><%= keyboard.getColor() != null ? keyboard.getColor() : "Chọn màu sắc" %></option>
                        <option value="Đen">Đen</option>
                        <option value="Trắng">Trắng</option>
                        <option value="Xám">Xám</option>
                        <option value="Đỏ">Đỏ</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Màu LED</label>
                    <select class="form-control" name="ledColor">
                        <option value="<%= keyboard.getLedColor() != null ? keyboard.getLedColor() : "" %>" selected><%= keyboard.getLedColor() != null ? keyboard.getLedColor() : "Chọn màu LED" %></option>
                        <option value="Không">Không</option>
                        <option value="Đơn sắc">Đơn sắc</option>
                        <option value="RGB">RGB</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Kích thước (WxHxD)</label>
                    <select class="form-control" name="dimensions">
                        <option value="<%= keyboard.getDimensions() != null ? keyboard.getDimensions() : "" %>" selected><%= keyboard.getDimensions() != null ? keyboard.getDimensions() : "Chọn kích thước" %></option>
                        <option value="435 x 130 x 35 mm">435 x 130 x 35 mm</option>
                        <option value="360 x 130 x 35 mm">360 x 130 x 35 mm</option>
                        <option value="300 x 100 x 30 mm">300 x 100 x 30 mm</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Trọng lượng (kg)</label>
                    <input type="number" step="0.01" class="form-control" name="weight" value="<%= keyboard.getWeight() %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Dung lượng pin (mAh)</label>
                    <input type="number" class="form-control" name="batteryCapacity" value="<%= keyboard.getBatteryCapacity() %>">
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Profile keycap</label>
                    <select class="form-control" name="keycapProfile">
                        <option value="<%= keyboard.getKeycapProfile() != null ? keyboard.getKeycapProfile() : "" %>" selected><%= keyboard.getKeycapProfile() != null ? keyboard.getKeycapProfile() : "Chọn profile" %></option>
                        <option value="OEM">OEM</option>
                        <option value="Cherry">Cherry</option>
                        <option value="DSA">DSA</option>
                        <option value="SA">SA</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Giá (VND)</label>
                    <input type="number" step="0.01" class="form-control" name="price" value="<%= variant.getPrice() %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Tồn kho</label>
                    <input type="number" class="form-control" name="stock" value="<%= variant.getStock() %>">
                </div>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-submit px-5">Cập nhật</button>
                <a href="list-products" class="btn btn-secondary px-5">Hủy</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>