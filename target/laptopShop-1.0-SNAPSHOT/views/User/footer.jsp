<%-- 
    Document   : footer
    Created on : Feb 14, 2025, 1:11:34 AM
    Author     : CE182250
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <div class="row">
            <!-- 🔹 Column 1: About Us -->
            <div class="col-md-4">
                <h5 class="fw-bold text-uppercase">About Us</h5>
                <p class="small">
                    Laptop Shop provides authentic laptops at the best prices with reliable warranty.
                    We are committed to delivering an excellent shopping experience for our customers!
                </p>
            </div>

            <!-- 🔹 Column 2: Google Map - Store Address -->
            <div class="col-md-4">
                <h5 class="fw-bold text-uppercase">Store Address</h5>
                <div class="map-container rounded overflow-hidden">
                    <iframe 
                        width="100%" 
                        height="200px" 
                        style="border:0;" 
                        allowfullscreen="" 
                        loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade"
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62757.11894879568!2d105.7225877!3d10.0108615!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0882139720a77%3A0x3916a227d0b95a64!2zVHLGsOG7nW5nIMSQ4bqhaSBow6BjIEZQVCBD4bqnbiBUaMO0!5e0!3m2!1sen!2s!4v1707759694772!5m2!1sen!2s">
                    </iframe>
                </div>
                <p class="mt-2 small"><i class="fas fa-map-marker-alt"></i> 123 Nguyen Van Cu, Ho Chi Minh City</p>
            </div>

            <!-- 🔹 Column 3: Contact & Social Media -->
            <div class="col-md-4">
                <h5 class="fw-bold text-uppercase">Contact</h5>
                <p class="small">
                    <i class="fas fa-phone-alt"></i> <strong>Hotline:</strong> 1800-1234 <br>
                    <i class="fas fa-envelope"></i> <strong>Email:</strong> support@laptopshop.com <br>
                    <i class="fas fa-clock"></i> <strong>Opening Hours:</strong> 08:00 - 22:00 (Mon - Sun)
                </p>

                <div class="social-icons mt-3">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
        </div>

        <!-- 🔹 Horizontal Divider -->
        <hr class="my-3 border-light">

        <!-- 🔹 Copyright -->
        <p class="mb-0 small">&copy; 2025 Laptop Shop. All rights reserved.</p>
        <p class="mb-0 small">Designed by <strong>MinhQuang</strong></p>
    </div>
</footer>
<style>
    /* 🔹 Adjust section spacing */
footer .container {
    max-width: 1100px;
}

/* 🔹 Adjust headings */
footer h5 {
    font-size: 16px;
    margin-bottom: 12px;
}

/* 🔹 Adjust text in footer */
footer p {
    font-size: 14px;
    line-height: 1.6;
}

/* 🔹 Adjust social media icons */
footer .social-icons a {
    font-size: 18px;
    transition: 0.3s;
}

footer .social-icons a:hover {
    color: #f8b400;
}

/* 🔹 Adjust Google Map */
footer .map-container iframe {
    border-radius: 10px;
}

</style>
<!-- Bootstrap & FontAwesome -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>