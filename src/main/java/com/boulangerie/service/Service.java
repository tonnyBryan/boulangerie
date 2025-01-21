package com.boulangerie.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import org.entityframework.client.GenericEntity;
import com.boulangerie.dao.DataSource;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Service implements AutoCloseable {
    private final GenericEntity ng;

    public Service() {
        try {
            this.ng = new GenericEntity(DataSource.getConnection());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Error("Connection a la base de donnée echoué", e);
        }
    }

    public static String l3(double value) {
        return String.format("%.3f", value);
    }

    public Service(GenericEntity ng) {
        this.ng = ng;    
    }

    public static void analyseAttribute(HttpServletRequest request, HttpServletResponse response) {
        if (request.getAttribute("error") != null) {
            request.setAttribute("error", (String) request.getAttribute("error"));
        }

        if (request.getAttribute("success") != null) {
            request.setAttribute("success", (String) request.getAttribute("success"));
        }
    }

    public GenericEntity getContext() {
        return this.ng;
    }

    @Override
    public void close() throws Exception {
        getContext().close();
    }


    public void beginTransaction() throws Exception {
        getContext().beginTransaction();
        getContext().setLogged(true);        
    }

    public void endTransaction() throws Exception {
        getContext().endTransaction();
    }

    public Connection getConnection() {
        return getContext().getConnection();
    }

    public void commit() throws SQLException {
        getContext().commit();
    }

    public void rollBack() throws SQLException {
        getContext().rollback();
    }

    public <T> List<T> getAll(Class<T> tClass) throws Exception {
        return getContext().findAll(tClass);
    }

}
