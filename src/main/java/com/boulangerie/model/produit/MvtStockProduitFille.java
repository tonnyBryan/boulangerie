package com.boulangerie.model.produit;

import java.sql.Date;

import org.entityframework.client.GenericEntity;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

import com.boulangerie.model.ingredient.Ingredient;
import com.boulangerie.model.ingredient.MvtStockIngredient;
import com.boulangerie.model.ingredient.MvtStockIngredientFille;
import org.entityframework.tools.Transient;

public class MvtStockProduitFille {
    @Primary(auto = true)
    private int id_mvt_stock_produit_fille;
    @FK(MvtStockProduit.class)
    private int id_mvt_stock_produit;
    private double entree;
    private double sortie;
    private double nouveau_quantite;
    private Date date_expiration;
    @FK(SaveurProduit.class)
    private int id_saveur_produit;
    @Transient
    private ProduitCpl produitCpl;

    public int getId_saveur_produit() {
        return id_saveur_produit;
    }

    public void setId_saveur_produit(int id_saveur_produit) {
        this.id_saveur_produit = id_saveur_produit;
    }

    public ProduitCpl getProduitCpl() {
        return produitCpl;
    }

    public void setProduitCpl(ProduitCpl produitCpl) {
        this.produitCpl = produitCpl;
    }

    public int getId_mvt_stock_produit() {
        return id_mvt_stock_produit;
    }

    public void setId_mvt_stock_produit(int id_mvt_stock_produit) {
        this.id_mvt_stock_produit = id_mvt_stock_produit;
    }

    public int getId_mvt_stock_produit_fille() {
        return id_mvt_stock_produit_fille;
    }

    public void setId_mvt_stock_produit_fille(int id_mvt_stock_produit_fille) {
        this.id_mvt_stock_produit_fille = id_mvt_stock_produit_fille;
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

    public Date getDate_expiration() {
        return date_expiration;
    }

    public void setDate_expiration(Date date_expiration) {
        this.date_expiration = date_expiration;
    }

    public void createAndPersistMvtStockIngredient(double req, GenericEntity ng) throws Exception {
        MvtStockIngredient mvtMere = new MvtStockIngredient();
        mvtMere.setDate_action(new Date(System.currentTimeMillis()));

        int id = (int) ng.save(mvtMere);
        mvtMere.setId_mvt_stock_ingredient(id);

        for (RecetteFille fille : getProduitCpl().getRecette().getRecetteFille()) {
            MvtStockIngredientFille mvtFille = new MvtStockIngredientFille();
            double sortie = fille.getQuantite_necessaire() * req;

            mvtFille.setEntree(0);
            mvtFille.setSortie(sortie);
            mvtFille.setId_ingredient(fille.getIngredient().getId_ingredient());
            mvtFille.setId_mvt_stock_ingredient(mvtMere.getId_mvt_stock_ingredient());

            double newQ = fille.getIngredient().getQuantite_en_stock() - sortie;
            mvtFille.setNouveau_quantite(newQ);

            ng.save(mvtFille);

            Ingredient i = fille.getIngredient();
            i.setQuantite_en_stock(newQ);
            ng.update(i);
        }
    }
}
