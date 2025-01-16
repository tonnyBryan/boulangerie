package com.boulangerie.model.produit;

import java.util.List;
import org.entityframework.tools.OneToMany;
import org.entityframework.tools.Primary;

public class Recette {
    @Primary(auto = true)
    private int id_recette;
    private double temps_preparation;
    @OneToMany(RecetteFille.class)
    private List<RecetteFille> recetteFille;

    public List<RecetteFille> getRecetteFille() {
        return recetteFille;
    }

    public void setRecetteFille(List<RecetteFille> recetteFille) {
        this.recetteFille = recetteFille;
    }

    public int getId_recette() {
        return id_recette;
    }

    public void setId_recette(int id_recette) {
        this.id_recette = id_recette;
    }

    public double getTemps_preparation() {
        return temps_preparation;
    }

    public void setTemps_preparation(double temps_preparation) {
        this.temps_preparation = temps_preparation;
    }
}

