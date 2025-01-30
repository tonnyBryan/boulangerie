package com.boulangerie.model.client;

import org.entityframework.tools.Primary;

public class Genre {
    @Primary(auto = true)
    private int id_genre;

    private String designation;

    public int getId_genre() {
        return id_genre;
    }

    public void setId_genre(int id_genre) {
        this.id_genre = id_genre;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}
