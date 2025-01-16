package com.boulangerie.model.produit;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

public class SaveurProduit {
    @Primary(auto = true)
    private int id_saveur_produit;
    @FK(Produit.class)
    private int id_produit;
    @Col(name = "id_saveur")
    @FK(Saveur.class)
    private Saveur saveur;
    @Col(zeroNull = true)
    @FK(Recette.class)
    private int id_recette;
    private double prix_unitaire;
    private double quantite_en_stock;

    public double getPrix_unitaire() {
        return prix_unitaire;
    }

    public void setPrix_unitaire(double prix_unitaire) {
        this.prix_unitaire = prix_unitaire;
    }

    public int getId_recette() {
        return id_recette;
    }

    public void setId_recette(int id_recette) {
        this.id_recette = id_recette;
    }

    public double getQuantite_en_stock() {
        return quantite_en_stock;
    }

    public void setQuantite_en_stock(double quantite_en_stock) {
        this.quantite_en_stock = quantite_en_stock;
    }

    public int getId_saveur_produit() {
        return id_saveur_produit;
    }

    public void setId_saveur_produit(int id_saveur_produit) {
        this.id_saveur_produit = id_saveur_produit;
    }

    public int getId_produit() {
        return id_produit;
    }

    public void setId_produit(int id_produit) {
        this.id_produit = id_produit;
    }

    public Saveur getSaveur() {
        return saveur;
    }

    public void setSaveur(Saveur saveur) {
        this.saveur = saveur;
    }
}
