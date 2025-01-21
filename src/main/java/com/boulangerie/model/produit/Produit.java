package com.boulangerie.model.produit;

import org.entityframework.tools.*;

import java.util.List;

public class Produit {
    @Primary(auto = true)
    private int id_produit;
    private String nom_produit;
    @Col("id_type_produit")
    @FK(TypeProduit.class)
    private TypeProduit typeProduit;
    private double duree_vie;
    @OneToMany(SaveurProduit.class)
    private List<SaveurProduit> saveurs;
    public List<SaveurProduit> getSaveurs() {
        return saveurs;
    }
    public void setSaveurs(List<SaveurProduit> saveurs) {
        this.saveurs = saveurs;
    }

    public int getId_produit() {
        return id_produit;
    }

    public void setId_produit(int id_produit) {
        this.id_produit = id_produit;
    }

    public String getNom_produit() {
        return nom_produit;
    }

    public void setNom_produit(String nom_produit) {
        this.nom_produit = nom_produit;
    }

    public TypeProduit getTypeProduit() {
        return typeProduit;
    }

    public void setTypeProduit(TypeProduit typeProduit) {
        this.typeProduit = typeProduit;
    }

    public double getDuree_vie() {
        return duree_vie;
    }

    public void setDuree_vie(double duree_vie) {
        this.duree_vie = duree_vie;
    }
}
