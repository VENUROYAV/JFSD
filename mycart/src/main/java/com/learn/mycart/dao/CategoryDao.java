package com.learn.mycart.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.learn.mycart.entities.Category;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save category to DB
    public int saveCategory(Category cat) {
        Transaction tx = null;
        int catId = 0; // Initialize catId
        try (Session session = this.factory.openSession()) {
            tx = session.beginTransaction();
            catId = (Integer) session.save(cat);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback(); // Rollback in case of an error
            }
            e.printStackTrace(); // Log the exception
        }
        return catId;
    }

    // Get all categories
    public List<Category> getCategories() {
        List<Category> list = new ArrayList<>(); // Initialize to avoid NullPointerException
        try (Session session = this.factory.openSession()) {
            Query<Category> query = session.createQuery("from Category", Category.class);
            list = query.list();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
        }
        return list;
    }

    // Get category by ID
    public Category getCategoryById(int cid) {
        Category cat = null;
        try (Session session = this.factory.openSession()) {
            cat = session.get(Category.class, cid);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
        }
        return cat;
    }
}
