package com.boulangerie.model.produit;

import java.sql.Date;
import java.util.List;

import org.entityframework.tools.OneToMany;
import org.entityframework.tools.Primary;

public class FabricationProduit {
    @Primary(auto = true)
    private int id_fabrication_produit;
    private Date date_action;
    @OneToMany(FabricationProduitFille.class)
    private List<FabricationProduitFille> fille;

    public List<FabricationProduitFille> getFille() {
        return fille;
    }

    public void setFille(List<FabricationProduitFille> fille) {
        this.fille = fille;
    }

    public int getId_fabrication_produit() {
        return id_fabrication_produit;
    }

    public void setId_fabrication_produit(int id_fabrication_produit) {
        this.id_fabrication_produit = id_fabrication_produit;
    }

    public Date getDate_action() {
        return date_action;
    }

    public void setDate_action(Date date_action) {
        this.date_action = date_action;
    }
}
