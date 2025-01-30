package com.boulangerie.model.produit;

import com.boulangerie.model.client.Genre;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.Primary;

public class Vendeur {
    @Primary(auto = true)
    private int id_vendeur;
    private String nom;
    @FK(Genre.class)
    @Col("id_genre")
    private Genre genre;

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public int getId_vendeur() {
        return id_vendeur;
    }

    public void setId_vendeur(int id_vendeur) {
        this.id_vendeur = id_vendeur;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
