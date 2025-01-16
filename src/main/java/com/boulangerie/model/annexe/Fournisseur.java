package com.boulangerie.model.annexe;

import org.entityframework.tools.Primary;

public class Fournisseur {
    @Primary(auto = true)
    private int id_fournisseur;
    private String nom;
    private String contact;

    public int getId_fournisseur() {
        return id_fournisseur;
    }

    public void setId_fournisseur(int id_fournisseur) {
        this.id_fournisseur = id_fournisseur;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }
}

