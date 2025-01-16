package com.boulangerie.model.ingredient;

import org.entityframework.tools.Primary;

public class Unite {
    @Primary(auto = true)
    private int id_unite;
    private String designation;

    public int getId_unite() {
        return id_unite;
    }

    public void setId_unite(int id_unite) {
        this.id_unite = id_unite;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}

