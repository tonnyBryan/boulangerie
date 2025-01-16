package com.boulangerie.model.annexe;

import java.sql.Date;

import org.entityframework.tools.Primary;

public class MvtCaisse {
    @Primary(auto = true)
    private int id_mvt_caisse;
    private double entree;
    private double sortie;
    private Date date_action;
    private double nouveau_caisse;

    public int getId_mvt_caisse() {
        return id_mvt_caisse;
    }

    public void setId_mvt_caisse(int id_mvt_caisse) {
        this.id_mvt_caisse = id_mvt_caisse;
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

    public Date getDate_action() {
        return date_action;
    }

    public void setDate_action(Date date_action) {
        this.date_action = date_action;
    }

    public double getNouveau_caisse() {
        return nouveau_caisse;
    }

    public void setNouveau_caisse(double nouveau_caisse) {
        this.nouveau_caisse = nouveau_caisse;
    }
}
