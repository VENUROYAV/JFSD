<%@ page import="com.learn.mycart.dao.ProductDao" %>
<%@ page import="com.learn.mycart.helper.FactoryProvider" %>
<%@ page import="com.learn.mycart.entities.Product" %>
<%@ page import="com.learn.mycart.entities.Category" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.Part" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.UUID" %>

<%
    // Get form data
    String pName = request.getParameter("pName");
    String pDesc = request.getParameter("pDesc");
    String pPhoto = request.getParameter("pPhoto");
    int pPrice = Integer.parseInt(request.getParameter("pPrice"));
    int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
    int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

    // Get the file part for the photo
    Part photoPart = request.getPart("pPhoto");
    String fileName = UUID.randomUUID() + "_" + photoPart.getSubmittedFileName(); // Create a unique filename
    String uploadPath = application.getRealPath("/") + "img/products/" + fileName;
    photoPart.write(uploadPath); // Save the file

    // Create a Product object
    Product product = new Product(pName, pDesc, fileName, pPrice, pDiscount, pQuantity, null); // Set category later

    // Save the product
    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
    dao.saveProduct(product); // Save the product

    // Redirect or display success message
    response.sendRedirect("add_product.jsp?success=Product added successfully");
%>
