package com.boulangerie.model.produit;

import org.entityframework.tools.Primary;

public class Saveur {
    @Primary(auto = true)
    private int id_saveur;
    private String designation;

    public int getId_saveur() {
        return id_saveur;
    }

    public void setId_saveur(int id_saveur) {
        this.id_saveur = id_saveur;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}
