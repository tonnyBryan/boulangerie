package com.boulangerie.model.produit;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

import java.sql.Date;

public class ChangementPrix {
    @Primary(auto = true)
    private int id_changement_prix;
    private double oldPrix;
    private double newPrix;
    private Date date_changement;
    @FK(ProduitCpl.class)
    @Col("id_saveur_produit")
    private ProduitCpl produitCpl;

    public int getId_changement_prix() {
        return id_changement_prix;
    }

    public void setId_changement_prix(int id_changement_prix) {
        this.id_changement_prix = id_changement_prix;
    }

    public double getOldPrix() {
        return oldPrix;
    }

    public void setOldPrix(double oldPrix) {
        this.oldPrix = oldPrix;
    }

    public double getNewPrix() {
        return newPrix;
    }

    public void setNewPrix(double newPrix) {
        this.newPrix = newPrix;
    }

    public Date getDate_changement() {
        return date_changement;
    }

    public void setDate_changement(Date date_changement) {
        this.date_changement = date_changement;
    }

    public ProduitCpl getProduitCpl() {
        return produitCpl;
    }

    public void setProduitCpl(ProduitCpl produitCpl) {
        this.produitCpl = produitCpl;
    }
}
