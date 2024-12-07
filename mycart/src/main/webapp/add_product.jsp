<%@ page import="com.learn.mycart.dao.ProductDao" %>
<%@ page import="com.learn.mycart.helper.FactoryProvider" %>
<%@ page import="com.learn.mycart.entities.Product" %>
<%@ page import="com.learn.mycart.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.learn.mycart.dao.CategoryDao" %>

<html>
<head>
    <title>Add Product</title>
    <%@ include file="components/common_css_js.jsp" %>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>

    <h2>Add New Product</h2>

    <form action="save_product.jsp" method="post" enctype="multipart/form-data">
        <div>
            <label>Product Name:</label>
            <input type="text" name="pName" required />
        </div>
        <div>
            <label>Product Description:</label>
            <textarea name="pDesc" required></textarea>
        </div>
        <div>
            <label>Product Photo:</label>
            <input type="file" name="pPhoto" required />
        </div>
        <div>
            <label>Product Price:</label>
            <input type="number" name="pPrice" required />
        </div>
        <div>
            <label>Product Discount (%):</label>
            <input type="number" name="pDiscount" />
        </div>
        <div>
            <label>Product Quantity:</label>
            <input type="number" name="pQuantity" required />
        </div>
        <div>
            <label>Category:</label>
            <select name="categoryId" required>
                <%
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                    for (Category category : clist) {
                %>
                    <option value="<%= category.getCategoryId() %>"><%= category.getCategoryTitle() %></option>
                <%
                    }
                %>
            </select>
        </div>
        <div>
            <input type="submit" value="Add Product" />
        </div>
    </form>

    <%@ include file="components/common_modals.jsp" %>
</body>
</html>
