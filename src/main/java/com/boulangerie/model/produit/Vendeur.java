package com.boulangerie.model.produit;

import org.entityframework.tools.Primary;

public class Vendeur {
    @Primary(auto = true)
    private int id_vendeur;
    private String nom;

    public int getId_vendeur() {
        return id_vendeur;
    }

    public void setId_vendeur(int id_vendeur) {
        this.id_vendeur = id_vendeur;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
