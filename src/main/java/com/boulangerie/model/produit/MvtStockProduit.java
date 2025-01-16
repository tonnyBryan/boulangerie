package com.boulangerie.model.produit;

import java.sql.Date;
import java.util.List;

import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.OneToMany;
import org.entityframework.tools.Primary;

public class MvtStockProduit {
    @Primary(auto = true)
    private int id_mvt_stock_produit;
    private Date date_action;
    @Col(zeroNull = true)
    @FK(VenteProduit.class)
    private int id_vente_produit; 
    @Col(zeroNull = true)
    @FK(FabricationProduit.class)
    private int id_fabrication; 
    @OneToMany(MvtStockProduitFille.class)
    private List<MvtStockProduitFille> mvtStockProduitFilles;

    public List<MvtStockProduitFille> getMvtStockProduitFilles() {
        return mvtStockProduitFilles;
    }

    public void setMvtStockProduitFilles(List<MvtStockProduitFille> mvtStockProduitFilles) {
        this.mvtStockProduitFilles = mvtStockProduitFilles;
    }

    public int getId_fabrication() {
        return id_fabrication;
    }

    public void setId_fabrication(int id_fabrication) {
        this.id_fabrication = id_fabrication;
    }

    public int getId_vente_produit() {
        return id_vente_produit;
    }

    public void setId_vente_produit(int id_vente_produit) {
        this.id_vente_produit = id_vente_produit;
    }

    public int getId_mvt_stock_produit() {
        return id_mvt_stock_produit;
    }

    public void setId_mvt_stock_produit(int id_mvt_stock_produit) {
        this.id_mvt_stock_produit = id_mvt_stock_produit;
    }

    public Date getDate_action() {
        return date_action;
    }

    public void setDate_action(Date date_action) {
        this.date_action = date_action;
    }
}
