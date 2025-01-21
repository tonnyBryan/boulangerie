package com.boulangerie.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

import com.boulangerie.model.produit.*;
import com.boulangerie.model.view.V_Client_Stat;
import org.entityframework.web.P;

import com.boulangerie.model.client.Client;
import com.boulangerie.model.ingredient.Ingredient;

public class ProduitService extends Service {
    public ProduitService() {
        super();
    }

    public List<TypeProduit> getTypeProduits() throws Exception {
        return getAll(TypeProduit.class);
    }

    public List<Ingredient> getIngredients() throws Exception {
        return new IngredientService(getContext()).getIngredients();
    }

    public TypeProduit getTypeProduit(int id) throws Exception {
        return getContext().findById(id, TypeProduit.class);
    }

    public List<Produit> getProduits() throws Exception {
        return getAll(Produit.class);
    }

    public double evaluatePrixProduit(Recette re) throws Exception {
        double total = 0.0;

        for (RecetteFille fille : re.getRecetteFille()) {
            total += fille.getIngredient().getPrix_unitaire() * fille.getQuantite_necessaire();
        }

        double pe = pourcent(10, total);
        return total + pe;
    }

    public Recette createRecette(String[] ingredients, String[] quantites) throws Exception {
        Recette recette = new Recette();
        recette.setTemps_preparation(0);

        int id = (int) getContext().save(recette);
        recette.setId_recette(id);

        int counter = 0;
        List<RecetteFille> filles = new ArrayList<>();
        if (ingredients != null && quantites != null) {
            for (int i = 0; i < ingredients.length; i++) {
                double quantite = Double.parseDouble(quantites[i]);
                if (quantite > 0) { 
                    counter++;
                    RecetteFille fille = new RecetteFille();
                    Ingredient ingredient = new IngredientService(getContext()).getIngredient(Integer.parseInt(ingredients[i]));

                    fille.setId_recette(recette.getId_recette());
                    fille.setIngredient(ingredient);
                    fille.setQuantite_necessaire(quantite);
                    getContext().save(fille);

                    filles.add(fille);
                }
            }
        } 

        if (counter == 0) {
            getContext().delete(recette);
            throw new Exception("Aucune ingredients selectionné");
        }

        recette.setRecetteFille(filles);
        return recette;
    }


    public int saveProduit(Produit p) throws Exception {
        return (int) getContext().save(p);
    }

    public Produit getProduit(int id) throws Exception {
        return getContext().findById(id, Produit.class);
    }

    public ProduitCpl getProduitCpl(int id) throws Exception {
        return getContext().findById(id, ProduitCpl.class);
    }
    public List<ProduitCpl> getAllProduitsCpl() throws Exception {
        return getAll(ProduitCpl.class);
    }

    public HashMap<Integer, Double> stock() throws Exception {
        List<ProduitCpl> produits = getAllProduitsCpl();

        HashMap<Integer, Double> stock = new HashMap<>();
        for (ProduitCpl produit : produits) {
            stock.put(produit.getId_saveur_produit(), produit.getQuantite_en_stock());
        }

        return stock;
    }

    public Object[] fabriquer(String[] produitIds, String[] quantites) throws Exception {
        FabricationProduit fabrication = new FabricationProduit();
        fabrication.setDate_action(new Date(System.currentTimeMillis()));

        int id = (int)getContext().save(fabrication);
        fabrication.setId_fabrication_produit(id);

        MvtStockProduit mvtMere = new MvtStockProduit();
        mvtMere.setId_fabrication(fabrication.getId_fabrication_produit());
        mvtMere.setDate_action(fabrication.getDate_action());

        int idMvtMere = (int) getContext().save(mvtMere);
        mvtMere.setId_mvt_stock_produit(idMvtMere);
        
        HashMap<Integer, Double> stock = new IngredientService(getContext()).stock();
        HashMap<Integer , Double> recommandation = new HashMap<>();
        HashMap<Integer , Double> deduction = new HashMap<>();

        boolean success = true;
        int counter = 0;
        for (int i = 0; i < quantites.length; i++) {
            int produitId = Integer.parseInt(produitIds[i]);
            double quantiteAFabrique = Double.parseDouble(quantites[i]);

            ProduitCpl produit = getProduitCpl(produitId);

            if (quantiteAFabrique == 0) {
                continue;
            } else if (quantiteAFabrique < 0) {
                throw new Exception("Quantite (" + quantiteAFabrique + ") pour le produit " + produit.getProduit().getNom_produit() + "(" + produit.getSaveur().getDesignation() + ") non valide!!!");
            }

            boolean produitSuccess = true;
            if (produit.getRecette() == null) {
                throw new Exception("Impossible de fabriquer le produit : " + produit.getNomCpl() + " n'as pas de recette");
            }
            for (RecetteFille fille : produit.getRecette().getRecetteFille()) {
                double necessaire = fille.getQuantite_necessaire() * quantiteAFabrique;
                int id_ingredient = fille.getIngredient().getId_ingredient();


                double enStock = stock.get(id_ingredient);

                if (enStock < necessaire) {
                    produitSuccess = false;
                    success = false;
                    double reste = necessaire - enStock;
                    recommandation.put(id_ingredient, recommandation.getOrDefault(id_ingredient, 0.0) + reste);   
                    stock.put(id_ingredient, 0.0);
                }

                else if (enStock >= necessaire) {
                    stock.put(id_ingredient, enStock - necessaire);
                    deduction.put(id_ingredient, deduction.getOrDefault(id_ingredient, 0.0) + necessaire);
                }
            }

            counter++;
            if (produitSuccess) {
                FabricationProduitFille fille = new FabricationProduitFille();
                fille.setId_fabrication_produit(fabrication.getId_fabrication_produit());
                fille.setQuantite_fabrique(quantiteAFabrique);
                fille.setProduitCpl(produit);
                getContext().save(fille);

                MvtStockProduitFille mvtFille = fille.createMvtStockProduitFille();
                mvtFille.setId_mvt_stock_produit(mvtMere.getId_mvt_stock_produit());
                mvtFille.setProduitCpl(produit);

                getContext().save(mvtFille);
                mvtFille.createAndPersistMvtStockIngredient(quantiteAFabrique, getContext());

                produit.setQuantite_en_stock(produit.getQuantite_en_stock() + quantiteAFabrique);
                getContext().update(produit);
            }
        }

        if (counter == 0) {
            throw new Exception("Aucune produit selectionée");
        }
        else if (success) {
            return new Object[]{true, deduction};
        } else {
            getContext().rollBack();
            return new Object[]{false, recommandation};
        }
    }

    private String buildList(
        HashMap<Integer, Double> rec,
        String title,
        boolean isIngredient,
        boolean isRecommandation) throws Exception {

        StringBuilder result = new StringBuilder();
        result.append("<h3>").append(title).append("</h3>");
        result.append("<ul>");
        
        for (Map.Entry<Integer, Double> entry : rec.entrySet()) {
            String litexte;
            if (isIngredient) {
                Ingredient i = new IngredientService(getContext()).getIngredient(entry.getKey());
                double value = entry.getValue();
                litexte = value + " " + i.getUnite().getDesignation() + " de " + i.getNom_ingredient();
            } else {
                ProduitCpl p = getProduitCpl(entry.getKey());
                double value = entry.getValue();
                litexte = value + " quantité de " + p.getNomCpl();
            }
            
            result.append("<li>").append(litexte).append("</li>");
        }
        
        result.append("</ul>");
        return result.toString();
    }

    public String buildRecommandationIngredientList(HashMap<Integer, Double> rec) throws Exception {
        return buildList(rec, "Pour réussir votre fabrication, il vous faut :", true, true);
    }
    
    public String buildDeductionIngredientList(HashMap<Integer, Double> rec) throws Exception {
        return buildList(rec, "Votre stock d'ingrédients est déduit de :", true, false);
    }
    
    public String buildRecommandationProduitList(HashMap<Integer, Double> rec) throws Exception {
        return buildList(rec, "Pour réussir votre commande, il vous faut :", false, true);
    }
    
    public String buildDeductionProduitList(HashMap<Integer, Double> rec) throws Exception {
        return buildList(rec, "Votre stock de produits est déduit de :", false, false);
    }
    
    public double pourcent(double per , double value) throws Exception {
        return (per * value) / 100;
    }

    public List<FabricationProduit> getListeFabrication() throws Exception {
        return getContext().findWhen(FabricationProduit.class, "order by id_fabrication_produit desc");
    }

    public List<Client> getClients() throws Exception {
        return getAll(Client.class);
    }

    public Client getClient(int id) throws Exception {
        return getContext().findById(id, Client.class);
    }

    public Object[] vendre(String[] produitIds, String[] quantites, Client client, String[] saveurIds) throws Exception {
        VenteProduit vente = new VenteProduit();
        vente.setClient(client);
        vente.setDate_vente(new Date(System.currentTimeMillis()));
        vente.setTotal(0.0);

        int idVente = (int) getContext().save(vente);
        vente.setId_vente(idVente);

        MvtStockProduit mvtStock = new MvtStockProduit();
        mvtStock.setId_vente_produit(vente.getId_vente());
        mvtStock.setDate_action(vente.getDate_vente());

        int idMvtMere = (int) getContext().save(mvtStock);
        mvtStock.setId_mvt_stock_produit(idMvtMere);

        HashMap<Integer , Double> recommandation = new HashMap<>();
        HashMap<Integer , Double> deduction = new HashMap<>();
        
        double total = 0.0;
        boolean success = true;
        for (int i = 0; i < quantites.length; i++) {
            int produitId = Integer.parseInt(produitIds[i]);
            double quantiteAVendre = Double.parseDouble(quantites[i]);

            ProduitCpl produit = getProduitCpl(produitId);
            int idProduit = produit.getId_saveur_produit();

            if (quantiteAVendre == 0) {
                continue;
            } else if (quantiteAVendre < 0) {
                throw new Exception("Quantité invalide pour le produit " + produit.getNomCpl());
            } else if (quantiteAVendre > produit.getQuantite_en_stock()) {
                success = false;
                recommandation.put(idProduit, recommandation.getOrDefault(idProduit, 0.0) + quantiteAVendre - produit.getQuantite_en_stock());
                continue;
            }

            deduction.put(idProduit, deduction.getOrDefault(idProduit, 0.0) + quantiteAVendre);
            DetailVenteProduit detail = new DetailVenteProduit();
            detail.setId_vente(vente.getId_vente());
            detail.setPrix_unitaire(produit.getPrix_unitaire());
            detail.setProduit_vendu(produit);
            detail.setQuantite_vendue(quantiteAVendre);

            getContext().save(detail);

            total += produit.getPrix_unitaire() * quantiteAVendre;

            MvtStockProduitFille fille = detail.createMvtStockProduitFille();
            fille.setId_mvt_stock_produit(mvtStock.getId_mvt_stock_produit());
            
            getContext().save(fille);

            produit.setQuantite_en_stock(produit.getQuantite_en_stock() - quantiteAVendre);
            getContext().update(produit);
        }

        if (success && total == 0.0) {
            throw new Exception("Aucune produit selectionné");
        }

        if (success) {
            vente.setTotal(total);
            getContext().update(vente);
            return new Object[]{true, deduction};
        } else {
            getContext().rollBack();
            return new Object[]{false, recommandation};
        }
    }

    public List<VenteProduit> getVentes() throws Exception {
        return getContext().findWhen(VenteProduit.class, "order by id_vente desc");
    }

    public List<FabricationProduit> getSelonIngredient(int id, int type) throws Exception{
        List<FabricationProduit> listfp = getContext().findAll(FabricationProduit.class);
        List<FabricationProduit> result = new ArrayList<>();

        for (FabricationProduit fp : listfp) {
            Iterator<FabricationProduitFille> iterator = fp.getFille().iterator();
            boolean shouldBreakOuterLoop = false;

            while (iterator.hasNext()) {
                FabricationProduitFille fille = iterator.next();
                ProduitCpl cs = fille.getProduitCpl();
                Produit p = cs.getProduit();

                if (p.getTypeProduit().getId_type_produit() != type) {
                    iterator.remove();
                    continue;
                }

                for (RecetteFille rFille : cs.getRecette().getRecetteFille()) {
                    if (rFille.getIngredient().getId_ingredient() == id) {
                        result.add(fp);
                        shouldBreakOuterLoop = true;
                        break;
                    }
                }

                if (shouldBreakOuterLoop) {
                    break;
                }
            }
        }
        return result;
    } 


    public List<Saveur> getAllSaveur() throws Exception {
        return getAll(Saveur.class);
    }

//    public List<VenteProduit> rechercher(int idType, int idSaveur) throws  Exception {
//        List<VenteProduit> vtes = getVentes();
//        List<VenteProduit> result = new ArrayList<>();
//        for (VenteProduit vp : vtes) {
//            for (DetailVenteProduit dv : vp.getDetails()) {
//                if (dv.getProduit_vendu().getProduit().getTypeProduit().getId_type_produit() == idType && dv.getProduit_vendu().getSaveur().getId_saveur() == idSaveur) {
//                    result.add(vp);
//                    break;
//                }
//            }
//        }
//        return  result;
//    }

    public List<VenteProduit> rechercher(int idType, int idSaveur) throws Exception {
        List<VenteProduit> vtes = getVentes();
        List<VenteProduit> result = new ArrayList<>();

        for (VenteProduit vp : vtes) {
            Iterator<DetailVenteProduit> iterator = vp.getDetails().iterator();
            while (iterator.hasNext()) {
                DetailVenteProduit dv = iterator.next();
                if (dv.getProduit_vendu().getProduit().getTypeProduit().getId_type_produit() != idType
                        || dv.getProduit_vendu().getSaveur().getId_saveur() != idSaveur) {
                    iterator.remove();
                }
            }
            if (!vp.getDetails().isEmpty()) {
                result.add(vp);
            }
        }
        return result;
    }

    public List<ConseilMois> conseilDuMois(List<ConseilMois> conseils, int mois, int annee) {
        List<ConseilMois> result = new ArrayList<>();
        Calendar cal = Calendar.getInstance();

        for (ConseilMois conseil : conseils) {
            // Récupérer les mois et années de date_debut et date_fin
            cal.setTime(conseil.getDate_debut());
            int debutMois = cal.get(Calendar.MONTH) + 1; // Mois commence à 0
            int debutAnnee = cal.get(Calendar.YEAR);

            cal.setTime(conseil.getDate_fin());
            int finMois = cal.get(Calendar.MONTH) + 1;
            int finAnnee = cal.get(Calendar.YEAR);

            // Vérifier si le mois et l'année donnés sont dans l'intervalle [date_debut, date_fin]
            if ((debutAnnee < annee || (debutAnnee == annee && debutMois <= mois)) &&
                    (finAnnee > annee || (finAnnee == annee && finMois >= mois))) {
                result.add(conseil);
            }
        }
        return result;
    }

    public List<VenteProduit> getVentesToday() throws Exception {
        List<VenteProduit> ventes = getVentes();
        List<VenteProduit> todayVente = new ArrayList<>();

        LocalDate today = LocalDate.now();
        Date todayDate = Date.valueOf(today);

        for (VenteProduit v : ventes) {
            if (v.getDate_vente().equals(todayDate)) {
                todayVente.add(v);
            }
        }

        return todayVente;
    }

    public List<VenteProduit> getVentesByDate(Date targetDate) throws Exception {
        List<VenteProduit> ventes = getVentes();
        List<VenteProduit> filteredVentes = new ArrayList<>();

        for (VenteProduit v : ventes) {
            if (v.getDate_vente().equals(targetDate)) {
                filteredVentes.add(v);
            }
        }

        return filteredVentes;
    }


    public List<Client> extractUniqueClients(List<VenteProduit> ventes) {
        List<Client> uniqueClients = new ArrayList<>();

        for (VenteProduit vente : ventes) {
            if (vente.getClient() != null) {
                Client client = vente.getClient();
                // Vérifier si le client est déjà dans la liste
                if (!isClientAlreadyAdded(uniqueClients, client)) {
                    uniqueClients.add(client); // Ajouter le client unique
                }
            }
        }

        return uniqueClients;
    }

    // Fonction auxiliaire pour vérifier si le client est déjà dans la liste
    private boolean isClientAlreadyAdded(List<Client> clients, Client clientToCheck) {
        for (Client client : clients) {
            if (client.getId_client() == clientToCheck.getId_client()) { // Comparer les IDs des clients
                return true; // Le client est déjà dans la liste
            }
        }
        return false; // Le client n'est pas encore dans la liste
    }

    public List<V_Client_Stat> getClientStats() throws Exception {
        return getAll(V_Client_Stat.class);
    }

}
