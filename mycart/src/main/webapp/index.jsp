<%@ page import="com.learn.mycart.helper.Helper" %>
<%@ page import="com.learn.mycart.dao.CategoryDao" %>
<%@ page import="com.learn.mycart.dao.ProductDao" %>
<%@ page import="com.learn.mycart.helper.FactoryProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> <!-- Importing ArrayList -->
<%@ page import="com.learn.mycart.entities.*" %>
<html>
<head>
    <title>Farming Portal</title>
    <%@ include file="components/common_css_js.jsp" %>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>

    <%
        String cat = request.getParameter("category");
        List<Product> list = new ArrayList<>(); // Initialize list

        // Create ProductDao instance
        ProductDao dao = new ProductDao(FactoryProvider.getFactory());

        // Fetch products based on category
        if (cat == null || cat.trim().equals("all")) {
            list = dao.getAllProducts(); // Fetch all products
        } else {
            try {
                int cid = Integer.parseInt(cat.trim());
                list = dao.getAllProductsById(cid); // Fetch products by category ID
            } catch (NumberFormatException e) {
                // Handle invalid category ID
                e.printStackTrace(); // Log the error
                list = new ArrayList<>(); // Return an empty list
            }
        }

        // Fetch categories
        CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
        List<Category> clist = cdao.getCategories();
        if (clist == null) {
            clist = new ArrayList<>(); // Initialize to avoid NullPointerException
        }
    %>

    <div class="row ml-2">
        <!-- Show categories -->
        <div class="col-md-2">
            <div class="list-group mt-4">
                <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>
                <%
                    for (Category c : clist) {
                %>
                    <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action">
                        <%= c.getCategoryTitle() %>
                    </a>
                <%
                    }
                %>
            </div>
        </div>
        
        <!-- Show products -->
        <div class="col-md-10">
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="card-columns">
                        <!-- Traversing products -->
                        <%
                        if (list != null && !list.isEmpty()) { // Check if list is not null or empty
                            for (Product p : list) {
                        %>
                            <div class="card">
                                <div class="container text-center">
                                    <img alt="Product Image" style="max-height:200px; max-width:100px; width:auto;" 
                                         src="img/products/<%= p.getpPhoto() %>" class="card-img-top m-2">
                                </div>
                                <div class="card-body"> <!-- Corrected to card-body -->
                                    <h5 class="card-title ml-2"><%= p.getpName() %></h5>
                                    <p class="card-text ml-2"><%= Helper.get10Words(p.getpDesc()) %></p>
                                </div>
                                <div class="card-footer text-center">
                                    <button class="btn custom-bg text-white" 
                                            onclick="add_to_cart(<%= p.getPid() %>, '<%= p.getpName() %>', '<%= p.getPriceAfterApplyDiscount() %>')">
                                        Add to Cart
                                    </button>
                                    <button class="btn btn-outline-success">
                                        &#8377; <%= p.getPriceAfterApplyDiscount() %>/- 
                                        <span class="text-secondary discount-label">
                                            &#8377;<%= p.getpPrice() %> <%= p.getpDiscount() %>%
                                        </span>
                                    </button>
                                </div>
                            </div>
                        <%
                            } // End of product for loop
                        } else {
                        %>
                            <h3>No items in this category</h3>
                        <%
                        }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="components/common_modals.jsp" %>
</body>
</html>
