package com.boulangerie.model.produit;

import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

import java.sql.Date;

public class VendeurCommission {
    @Primary(auto = true)
    private int id_vendeur_commission;
    @FK(Vendeur.class)
    private int id_vendeur;
    @FK(VenteProduit.class)
    private int id_vente;
    private double value;
    private Date date_vente;

    public int getId_vendeur_commission() {
        return id_vendeur_commission;
    }

    public void setId_vendeur_commission(int id_vendeur_commission) {
        this.id_vendeur_commission = id_vendeur_commission;
    }

    public int getId_vendeur() {
        return id_vendeur;
    }

    public void setId_vendeur(int id_vendeur) {
        this.id_vendeur = id_vendeur;
    }

    public int getId_vente() {
        return id_vente;
    }

    public void setId_vente(int id_vente) {
        this.id_vente = id_vente;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public Date getDate_vente() {
        return date_vente;
    }

    public void setDate_vente(Date date_vente) {
        this.date_vente = date_vente;
    }
}
