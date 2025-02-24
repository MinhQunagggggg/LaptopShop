package ControllerAdmin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import DAOAdmin.ProductDAO;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId")); 

            boolean isDeleted = productDAO.deleteProductMNgoc(productId);

            if (isDeleted) {
                response.sendRedirect("list-products");
            } else {
                response.sendRedirect("productList.jsp?error=Failed to delete product");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("productList.jsp?error=Invalid product ID");
        }
    }
}
