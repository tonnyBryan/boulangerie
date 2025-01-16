package com.boulangerie.model.ingredient;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

public class DetailAchatIngredient {
    @Primary(auto = true)
    private int id_achat_ingredient;
    @FK(AchatIngredient.class)
    private int id_achat;
    @Col(name = "id_ingredient")
    @FK(Ingredient.class)
    private Ingredient ingredient;   
    private double quantite_achetee;
    private double prix_unitaire;

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }
    
    public int getId_achat() {
        return id_achat;
    }

    public void setId_achat(int id_achat) {
        this.id_achat = id_achat;
    }

    public int getId_achat_ingredient() {
        return id_achat_ingredient;
    }

    public void setId_achat_ingredient(int id_achat_ingredient) {
        this.id_achat_ingredient = id_achat_ingredient;
    }
    
    public double getQuantite_achetee() {
        return quantite_achetee;
    }

    public void setQuantite_achetee(double quantite_achetee) {
        this.quantite_achetee = quantite_achetee;
    }

    public double getPrix_unitaire() {
        return prix_unitaire;
    }

    public void setPrix_unitaire(double prix_unitaire) {
        this.prix_unitaire = prix_unitaire;
    }

    public MvtStockIngredientFille createMvtStockIngredientFille() throws Exception {
        MvtStockIngredientFille fille = new MvtStockIngredientFille();
        
        double newQ = getIngredient().getQuantite_en_stock() + getQuantite_achetee();
        fille.setEntree(getQuantite_achetee());
        fille.setSortie(0);
        fille.setId_ingredient(getIngredient().getId_ingredient());
        fille.setNouveau_quantite(newQ);
        return fille;
    }
}
