package com.boulangerie.model.ingredient;

import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

public class MvtStockIngredientFille {
    @Primary(auto = true)
    private int id_mvt_stock_ingredient_fille;
    @FK(MvtStockIngredient.class)
    private int id_mvt_stock_ingredient;
    private double entree;
    private double sortie;
    private double nouveau_quantite;
    @FK(Ingredient.class)
    private int id_ingredient;

    public int getId_ingredient() {
        return id_ingredient;
    }

    public void setId_ingredient(int id_ingredient) {
        this.id_ingredient = id_ingredient;
    }

    public int getId_mvt_stock_ingredient_fille() {
        return id_mvt_stock_ingredient_fille;
    }

    public void setId_mvt_stock_ingredient_fille(int id_mvt_stock_ingredient_fille) {
        this.id_mvt_stock_ingredient_fille = id_mvt_stock_ingredient_fille;
    }

    public int getId_mvt_stock_ingredient() {
        return id_mvt_stock_ingredient;
    }

    public void setId_mvt_stock_ingredient(int id_mvt_stock_ingredient) {
        this.id_mvt_stock_ingredient = id_mvt_stock_ingredient;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public double getNouveau_quantite() {
        return nouveau_quantite;
    }

    public void setNouveau_quantite(double nouveau_quantite) {
        this.nouveau_quantite = nouveau_quantite;
    }
}

