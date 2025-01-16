package com.boulangerie.model.produit;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

import com.boulangerie.model.ingredient.Ingredient;

public class RecetteFille {
    @Primary(auto = true)
    private int id_recette_fille;
    @FK(Recette.class)
    private int id_recette;  
    @Col(name = "id_ingredient")
    @FK(Ingredient.class)
    private Ingredient ingredient;  
    private double quantite_necessaire;

    public double getQuantite_necessaire() {
        return quantite_necessaire;
    }

    public void setQuantite_necessaire(double quantite_necessaire) {
        this.quantite_necessaire = quantite_necessaire;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }

    public int getId_recette() {
        return id_recette;
    }

    public void setId_recette(int id_recette) {
        this.id_recette = id_recette;
    }

    public int getId_recette_fille() {
        return id_recette_fille;
    }

    public void setId_recette_fille(int id_recette_fille) {
        this.id_recette_fille = id_recette_fille;
    }
}
