package com.boulangerie.model.ingredient;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

public class Ingredient {
    @Primary(auto = true)
    private int id_ingredient;
    private String nom_ingredient;
    @Col(name = "id_type_ingredient")
    @FK(TypeIngredient.class)
    private TypeIngredient typeIngredient;  
    private double quantite_en_stock;
    private double prix_unitaire;
    @Col(name = "id_unite")
    @FK(Unite.class)
    private Unite unite; 

    public int getId_ingredient() {
        return id_ingredient;
    }

    public void setId_ingredient(int id_ingredient) {
        this.id_ingredient = id_ingredient;
    }

    public String getNom_ingredient() {
        return nom_ingredient;
    }

    public void setNom_ingredient(String nom_ingredient) {
        this.nom_ingredient = nom_ingredient;
    }

    public TypeIngredient getTypeIngredient() {
        return typeIngredient;
    }

    public void setTypeIngredient(TypeIngredient typeIngredient) {
        this.typeIngredient = typeIngredient;
    }

    public double getQuantite_en_stock() {
        return quantite_en_stock;
    }

    public void setQuantite_en_stock(double quantite_en_stock) {
        this.quantite_en_stock = quantite_en_stock;
    }

    public double getPrix_unitaire() {
        return prix_unitaire;
    }

    public void setPrix_unitaire(double prix_unitaire) {
        this.prix_unitaire = prix_unitaire;
    }

    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }
}
