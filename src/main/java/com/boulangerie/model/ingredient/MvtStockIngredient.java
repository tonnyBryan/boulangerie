package com.boulangerie.model.ingredient;

import java.sql.Date;
import java.util.List;

import org.entityframework.tools.OneToMany;
import org.entityframework.tools.Primary;

public class MvtStockIngredient {
    @Primary(auto = true)
    private int id_mvt_stock_ingredient;
    private Date date_action;
    @OneToMany(MvtStockIngredientFille.class)
    private List<MvtStockIngredientFille> filles;

    public List<MvtStockIngredientFille> getFilles() {
        return filles;
    }

    public void setFilles(List<MvtStockIngredientFille> filles) {
        this.filles = filles;
    }

    public int getId_mvt_stock_ingredient() {
        return id_mvt_stock_ingredient;
    }

    public void setId_mvt_stock_ingredient(int id_mvt_stock_ingredient) {
        this.id_mvt_stock_ingredient = id_mvt_stock_ingredient;
    }

    public Date getDate_action() {
        return date_action;
    }

    public void setDate_action(Date date_action) {
        this.date_action = date_action;
    }

    
}
