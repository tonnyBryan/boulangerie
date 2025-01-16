package com.boulangerie.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.entityframework.client.GenericEntity;
import org.entityframework.tools.RowResult;

import com.boulangerie.model.annexe.Fournisseur;
import com.boulangerie.model.ingredient.AchatIngredient;
import com.boulangerie.model.ingredient.DetailAchatIngredient;
import com.boulangerie.model.ingredient.Ingredient;
import com.boulangerie.model.ingredient.TypeIngredient;
import com.boulangerie.model.ingredient.Unite;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class IngredientService extends Service {
    public IngredientService() {
        super();
    }

    public IngredientService(GenericEntity ng) {
        super(ng);
    }

    public List<Fournisseur> getFournisseurs() throws Exception {
        return getAll(Fournisseur.class);
    }

    public List<TypeIngredient> getAllTypeIngredient() throws Exception {
        return getAll(TypeIngredient.class);
    }

    public List<Unite> getAllUnite() throws Exception {
        return getAll(Unite.class);
    }

    public TypeIngredient findTypeIngredient(int id) throws Exception {
        return getContext().findById(id, TypeIngredient.class);
    }

    public Unite findUnite(int id) throws Exception {
        return getContext().findById(id, Unite.class);
    }

    public void saveIngredient(Ingredient e) throws Exception {
        getContext().save(e);
    }

    public List<Ingredient> getIngredients() throws Exception {
        return getAll(Ingredient.class);
    }

    public HashMap<Integer, Double> stock() throws Exception {
        List<Ingredient> ingredients = getIngredients();

        HashMap<Integer, Double> stock = new HashMap<>();
        for (Ingredient ingredient : ingredients) {
            stock.put(ingredient.getId_ingredient(), ingredient.getQuantite_en_stock());
        }

        return stock;
    }

    public Ingredient getIngredient(int id) throws Exception {
        return getContext().findById(id, Ingredient.class);
    }

    public AchatIngredient createAchatIngredient() throws Exception {
        AchatIngredient a = new AchatIngredient();
        a.setFournisseur(GenericEntity.first(getFournisseurs()));
        a.setDate_achat(new Date(System.currentTimeMillis()));
        a.setTotal(0);
        
        int id = (int) getContext().save(a);
        a.setId_achat(id);

        return a;
    }

    public void validerAchatIngredients(AchatIngredient achat) throws Exception {
        achat.createMvtStock(getContext());
    }

    public void acheter(Map<String, String[]> parameterMap, HttpServletRequest request, HttpServletResponse response, IngredientService service) throws Exception {
        AchatIngredient achat = createAchatIngredient();

        List<DetailAchatIngredient> details = new ArrayList<>();

        double total = 0.0;
        for (String paramName : parameterMap.keySet()) {
            if (paramName.startsWith("quantite_")) {
                String ingredientId = paramName.substring("quantite_".length());
                int quantite = Integer.parseInt(request.getParameter(paramName));
                
                if (quantite > 0) {
                    Ingredient ingredient = service.getIngredient(Integer.parseInt(ingredientId));
                    
                    DetailAchatIngredient detail = new DetailAchatIngredient();
                    detail.setId_achat(achat.getId_achat());
                    detail.setIngredient(ingredient);
                    detail.setPrix_unitaire(ingredient.getPrix_unitaire());
                    detail.setQuantite_achetee(quantite);
                    
                    details.add(detail);
                    total += ingredient.getPrix_unitaire() * quantite;
                }
            }
        }    

        if (total == 0) {
            getContext().delete(achat);
        } else {
            achat.setDetails(details);
            achat.setTotal(total);
            validerAchatIngredients(achat);
        }
    }
}
