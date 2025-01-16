package com.boulangerie.model.annexe;

import org.entityframework.tools.Primary;

public class Global {
    @Primary(auto = true)
    private int id_global;
    private String nom_company;
    private double caisse_actuel;

    public int getId_global() {
        return id_global;
    }

    public void setId_global(int id_global) {
        this.id_global = id_global;
    }

    public String getNom_company() {
        return nom_company;
    }

    public void setNom_company(String nom_company) {
        this.nom_company = nom_company;
    }

    public double getCaisse_actuel() {
        return caisse_actuel;
    }

    public void setCaisse_actuel(double caisse_actuel) {
        this.caisse_actuel = caisse_actuel;
    }
}

