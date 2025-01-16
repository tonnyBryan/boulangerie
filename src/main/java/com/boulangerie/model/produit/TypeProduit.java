package com.boulangerie.model.produit;

import org.entityframework.tools.Primary;

public class TypeProduit {
    @Primary(auto = true)
    private int id_type_produit;
    private String designation;

    public int getId_type_produit() {
        return id_type_produit;
    }

    public void setId_type_produit(int id_type_produit) {
        this.id_type_produit = id_type_produit;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}


