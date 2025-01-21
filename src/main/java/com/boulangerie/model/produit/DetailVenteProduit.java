package com.boulangerie.model.produit;

import com.boulangerie.model.ingredient.TypeIngredient;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

public class DetailVenteProduit {
    @Primary(auto = true)
    private int id_detail_vente;
    @FK(VenteProduit.class)
    private int id_vente;
    @Col("id_saveur_produit")
    @FK(ProduitCpl.class)
    private ProduitCpl produit_vendu;
    private double quantite_vendue;
    private double prix_unitaire;

    public ProduitCpl getProduit_vendu() {
        return produit_vendu;
    }

    public void setProduit_vendu(ProduitCpl produit_vendu) {
        this.produit_vendu = produit_vendu;
    }

    public int getId_vente() {
        return id_vente;
    }

    public void setId_vente(int id_vente) {
        this.id_vente = id_vente;
    }


    public int getId_detail_vente() {
        return id_detail_vente;
    }

    public void setId_detail_vente(int id_detail_vente) {
        this.id_detail_vente = id_detail_vente;
    }

    public double getQuantite_vendue() {
        return quantite_vendue;
    }

    public void setQuantite_vendue(double quantite_vendue) {
        this.quantite_vendue = quantite_vendue;
    }

    public double getPrix_unitaire() {
        return prix_unitaire;
    }

    public void setPrix_unitaire(double prix_unitaire) {
        this.prix_unitaire = prix_unitaire;
    }

    public MvtStockProduitFille createMvtStockProduitFille() {
        MvtStockProduitFille fille = new MvtStockProduitFille();
        fille.setEntree(0.0);
        fille.setSortie(getQuantite_vendue());
        fille.setId_saveur_produit(getProduit_vendu().getId_saveur_produit());
        fille.setNouveau_quantite(getProduit_vendu().getQuantite_en_stock() - getQuantite_vendue());
        return fille;
    }
}
