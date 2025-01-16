package com.boulangerie.model.client;

import org.entityframework.tools.Primary;

public class Client {
    @Primary(auto = true)
    private int id_client;
    private String nom;
    private String contact;

    public int getId_client() {
        return id_client;
    }

    public void setId_client(int id_client) {
        this.id_client = id_client;
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
