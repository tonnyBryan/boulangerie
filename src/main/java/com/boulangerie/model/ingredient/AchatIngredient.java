package com.boulangerie.model.ingredient;

import java.sql.Date;
import java.util.List;

import org.entityframework.client.GenericEntity;
import org.entityframework.tools.Col;
import org.entityframework.tools.FK;
import org.entityframework.tools.OneToMany;
import org.entityframework.tools.Primary;

import com.boulangerie.model.annexe.Fournisseur;

public class AchatIngredient {
    @Primary(auto = true)
    private int id_achat;
    @Col("id_fournisseur")
    @FK(Fournisseur.class)
    private Fournisseur fournisseur;
    private Date date_achat;
    private double total;
    @OneToMany(DetailAchatIngredient.class)
    private List<DetailAchatIngredient> details;

    public List<DetailAchatIngredient> getDetails() {
        return details;
    }

    public void setDetails(List<DetailAchatIngredient> details) {
        this.details = details;
    }

    public int getId_achat() {
        return id_achat;
    }

    public void setId_achat(int id_achat) {
        this.id_achat = id_achat;
    }

    public Fournisseur getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(Fournisseur fournisseur) {
        this.fournisseur = fournisseur;
    }

    public Date getDate_achat() {
        return date_achat;
    }

    public void setDate_achat(Date date_achat) {
        this.date_achat = date_achat;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void createMvtStock(GenericEntity ng) throws Exception {
        MvtStockIngredient mvt = new MvtStockIngredient();
        mvt.setDate_action(getDate_achat());

        int id = (int) ng.save(mvt);
        mvt.setId_mvt_stock_ingredient(id);

        for (DetailAchatIngredient detail : getDetails()) {
            MvtStockIngredientFille fille = detail.createMvtStockIngredientFille();
            fille.setId_mvt_stock_ingredient(mvt.getId_mvt_stock_ingredient());
            ng.save(fille);
            detail.getIngredient().setQuantite_en_stock(fille.getNouveau_quantite());
            ng.update(detail.getIngredient());

            ng.save(detail);
        }
        ng.update(this);
    }   
}
