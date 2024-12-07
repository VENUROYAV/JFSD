package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public List<Product> getAllProducts() {
        Session session = null;
        List<Product> productList = null;
        try {
            session = factory.openSession();
            productList = session.createQuery("from Product", Product.class).list();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return productList;
    }

    public List<Product> getAllProductsById(int categoryId) {
        Session session = null;
        List<Product> productList = null;
        try {
            session = factory.openSession();
            // HQL query to fetch products based on category ID
            Query<Product> query = session.createQuery("from Product p where p.category.categoryId = :cid", Product.class);
            query.setParameter("cid", categoryId);
            productList = query.list();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return productList;
    }

    public void saveProduct(Product p) {
        Session session = null;
        try {
            session = factory.openSession();
            session.beginTransaction();
            session.save(p); // Save the product
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            if (session.getTransaction() != null) {
                session.getTransaction().rollback(); // Rollback in case of an error
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    

    // Other methods...
}
