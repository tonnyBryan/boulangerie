package com.boulangerie.model.produit;

import java.sql.Date;
import java.util.List;

import com.boulangerie.service.ProduitService;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.OneToMany;
import org.entityframework.tools.Primary;

import com.boulangerie.model.client.Client;

public class VenteProduit {
    @Primary(auto = true)
    private int id_vente;
    @Col("id_client")
    @FK(Client.class)
    private Client client;
    @FK(Vendeur.class)
    @Col("id_vendeur")
    private Vendeur vendeur;
    private Date date_vente;
    private double total;
    @OneToMany(DetailVenteProduit.class)
    private List<DetailVenteProduit> details;

    public Vendeur getVendeur() {
        return vendeur;
    }

    public void setVendeur(Vendeur vendeur) {
        this.vendeur = vendeur;
    }

    public List<DetailVenteProduit> getDetails() {
        return details;
    }

    public void setDetails(List<DetailVenteProduit> details) {
        this.details = details;
    }

    public int getId_vente() {
        return id_vente;
    }

    public void setId_vente(int id_vente) {
        this.id_vente = id_vente;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Date getDate_vente() {
        return date_vente;
    }

    public void setDate_vente(Date date_vente) {
        this.date_vente = date_vente;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getCommission() {
        return ProduitService.calculatePercentage(5, getTotal());
    }
}
