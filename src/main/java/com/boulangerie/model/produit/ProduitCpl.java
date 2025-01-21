package com.boulangerie.model.produit;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Table;

@Table("saveurproduit")
public class ProduitCpl extends SaveurProduit {
    @Col("id_produit")
    @FK(Produit.class)
    private Produit produit;

    @Col("id_recette")
    @FK(Recette.class)
    private Recette recette;

    public Recette getRecette() {
        return recette;
    }

    public void setRecette(Recette recette) {
        this.recette = recette;
    }

    public Produit getProduit() {
        return produit;
    }

    public void setProduit(Produit produit) {
        this.produit = produit;
    }

    public String getNomCpl() {
        return getProduit().getNom_produit() + " (" + getSaveur().getDesignation() + ")";
    }
}
