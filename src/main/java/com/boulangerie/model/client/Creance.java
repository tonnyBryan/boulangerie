package com.boulangerie.model.client;

import java.sql.Date;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;

public class Creance {
    private int id_creance;
    @FK(Client.class)
    @Col(name = "id_client")
    private Client client;
    private double montant_du;
    private Date date_echeance;
    private int id_vente;
    private String statut;

    public int getId_creance() {
        return id_creance;
    }

    public void setId_creance(int id_creance) {
        this.id_creance = id_creance;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public double getMontant_du() {
        return montant_du;
    }

    public void setMontant_du(double montant_du) {
        this.montant_du = montant_du;
    }

    public Date getDate_echeance() {
        return date_echeance;
    }

    public void setDate_echeance(Date date_echeance) {
        this.date_echeance = date_echeance;
    }

    public int getId_vente() {
        return id_vente;
    }

    public void setId_vente(int id_vente) {
        this.id_vente = id_vente;
    }


    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
}
