package com.boulangerie.model.produit;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

import java.sql.Date;

public class ConseilMois {
    @Primary(auto = true)
    private int id_conseil_mois;
    @FK(ProduitCpl.class)
    @Col("id_saveur_produit")
    private ProduitCpl produit;
    private Date date_debut;
    private Date date_fin;

    public int getId_conseil_mois() {
        return id_conseil_mois;
    }

    public void setId_conseil_mois(int id_conseil_mois) {
        this.id_conseil_mois = id_conseil_mois;
    }

    public ProduitCpl getProduit() {
        return produit;
    }

    public void setProduit(ProduitCpl produit) {
        this.produit = produit;
    }

    public Date getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(Date date_debut) {
        this.date_debut = date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }
}
