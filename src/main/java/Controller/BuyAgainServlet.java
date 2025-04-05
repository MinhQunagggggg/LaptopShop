package Controller;

import DAO.CartDAO;
import DAO.OrderDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.User;

@WebServlet(name = "BuyAgainServlet", urlPatterns = {"/BuyAgain"})
public class BuyAgainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is logged in
        if (user == null) {
            System.out.println("❌ User not logged in.");
            response.sendRedirect("Login");
            return;
        }

        int userId = user.getId();
        int orderId;

        // Parse order_id from the request
        try {
            orderId = Integer.parseInt(request.getParameter("order_id"));
        } catch (NumberFormatException e) {
            System.out.println("❌ Invalid order ID: " + request.getParameter("order_id"));
            response.sendRedirect("ViewOrder");
            return;
        }

        // Fetch all items in the order
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orderItems = orderDAO.getOrderItemsByOrderId(orderId);

        if (orderItems == null || orderItems.isEmpty()) {
            System.out.println("❌ No items found for order ID: " + orderId);
            response.sendRedirect("ViewOrder");
            return;
        }

        // Add each item to the cart
        CartDAO cartDAO = new CartDAO();
        for (Order item : orderItems) {
            int variantId = item.getVariantId();
            String ram = item.getRam();
            double price = item.getPrice();
            int quantity = item.getQuantity();
            int productId = item.getProduct_id(); // Use the fetched product_id

            System.out.println("🛒 Adding to cart: Product ID = " + productId + ", Variant ID = " + variantId + 
                             ", RAM = " + ram + ", Price = " + price + ", Quantity = " + quantity);

            // Add the item to the cart
            cartDAO.addToCart(userId, variantId, ram, price, quantity); // product_id is handled internally by addToCart
        }

        // Update cart size in session
        int cartSize = cartDAO.getCartSize(userId);
        session.setAttribute("cartSize", cartSize);

        // Redirect to cart page
        response.sendRedirect("Cart");
    }
}