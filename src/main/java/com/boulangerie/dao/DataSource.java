package com.boulangerie.dao;

import java.sql.Connection;

import org.entityframework.dev.Driver;

public abstract class DataSource {
    public static Connection getConnection() throws Exception {
        return Driver.getPGConnection("postgres", "postgres", "boulangerie");
    }
}
