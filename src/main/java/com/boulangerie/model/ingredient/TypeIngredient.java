package com.boulangerie.model.ingredient;

import org.entityframework.tools.Primary;

public class TypeIngredient {
    @Primary(auto = true)
    private int id_type_ingredient;
    private String designation;

    public int getId_type_ingredient() {
        return id_type_ingredient;
    }

    public void setId_type_ingredient(int id_type_ingredient) {
        this.id_type_ingredient = id_type_ingredient;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}
