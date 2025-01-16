package com.boulangerie.model.produit;

import java.sql.Date;
import java.util.Calendar;

import com.boulangerie.model.ingredient.TypeIngredient;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

public class FabricationProduitFille {
    @Primary(auto = true)
    private int id_fabrication_produit_fille;

    @FK(FabricationProduit.class)
    private int id_fabrication_produit;
    private double quantite_fabrique;
    @Col(name = "id_saveur_produit")
    @FK(ProduitCpl.class)
    private ProduitCpl produitCpl;

    public ProduitCpl getProduitCpl() {
        return produitCpl;
    }

    public void setProduitCpl(ProduitCpl produitCpl) {
        this.produitCpl = produitCpl;
    }

    public int getId_fabrication_produit_fille() {
        return id_fabrication_produit_fille;
    }

    public void setId_fabrication_produit_fille(int id_fabrication_produit_fille) {
        this.id_fabrication_produit_fille = id_fabrication_produit_fille;
    }

    public int getId_fabrication_produit() {
        return id_fabrication_produit;
    }

    public void setId_fabrication_produit(int id_fabrication_produit) {
        this.id_fabrication_produit = id_fabrication_produit;
    }


    public double getQuantite_fabrique() {
        return quantite_fabrique;
    }

    public void setQuantite_fabrique(double quantite_fabrique) {
        this.quantite_fabrique = quantite_fabrique;
    }

    public static Date ajouterJours(int jour) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR, jour);
        return new Date(calendar.getTimeInMillis());
    }

    public MvtStockProduitFille createMvtStockProduitFille() {
        MvtStockProduitFille fille = new MvtStockProduitFille();
        fille.setDate_expiration(ajouterJours((int) getProduitCpl().getProduit().getDuree_vie()));
        fille.setEntree(getQuantite_fabrique());
        fille.setSortie(0.0);
        fille.setId_saveur_produit(getProduitCpl().getId_saveur_produit());
        fille.setNouveau_quantite(getProduitCpl().getQuantite_en_stock() + getQuantite_fabrique());

        return fille;
    }
}
