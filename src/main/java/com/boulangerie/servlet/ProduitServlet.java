package com.boulangerie.servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.Month;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.boulangerie.model.client.Client;
import com.boulangerie.model.ingredient.Ingredient;
import com.boulangerie.model.produit.*;
import com.boulangerie.model.view.V_Client_Stat;
import com.boulangerie.service.ProduitService;
import com.boulangerie.service.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.entityframework.tools.RowResult;

@WebServlet("/produit")
public class ProduitServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Service.analyseAttribute(request, response);
   
        String type = request.getParameter("type");

        if (type.equalsIgnoreCase("ajouter")) {
            try (ProduitService service = new ProduitService()) {
                List<TypeProduit> types = service.getTypeProduits();
                List<Saveur> saveurs = service.getAllSaveur();
                request.setAttribute("saveurs", saveurs);
                request.setAttribute("types", types);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }  
            request.getRequestDispatcher("/layout/produit/ajouter.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("fabriquer")) {
            try (ProduitService service = new ProduitService()) {
                List<ProduitCpl> produits = service.getAllProduitsCpl();
                request.setAttribute("produits", produits);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            } 
            request.getRequestDispatcher("/layout/produit/fabriquer.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("listeFab")) {
            try (ProduitService service = new ProduitService()) {
                List<FabricationProduit> liste = service.getListeFabrication();
                request.setAttribute("fabrications", liste);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/listeFab.jsp").forward(request, response);

        }

        else if (type.equalsIgnoreCase("stock")) {
            try (ProduitService service = new ProduitService()) {
                List<ProduitCpl> produits = service.getAllProduitsCpl();
                request.setAttribute("produits", produits);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/stock.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("vendre")) {
            try (ProduitService service = new ProduitService()) {
                List<Client> clients = service.getClients();
                List<ProduitCpl> produits = service.getAllProduitsCpl();
                request.setAttribute("produits", produits);
                request.setAttribute("clients", clients);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/vendre.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("listeVente")) {
            try (ProduitService service = new ProduitService()) {
                List<VenteProduit> ventes = service.getVentes();
                request.setAttribute("ventes", ventes);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/listeVente.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("listespec")) {
            try (ProduitService service = new ProduitService()) {
                List<Ingredient> listi = service.getIngredients();
                List<TypeProduit> types = service.getTypeProduits();

                request.setAttribute("ingredients", listi);
                request.setAttribute("types", types);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/listespec.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("produire")) {
            try (ProduitService service = new ProduitService()) {
                List<ProduitCpl> produits = service.getAllProduitsCpl();
                request.setAttribute("produits", produits);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/produire.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("rechercheVente")) {
            try (ProduitService service = new ProduitService()) {
                List<TypeProduit> prords = service.getTypeProduits();
                List<Saveur> savs = service.getAllSaveur();
                request.setAttribute("types", prords);
                request.setAttribute("saveurs", savs);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/rechercheVente.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("attribuerRecette")) {
            try (ProduitService service = new ProduitService()) {
                List<Ingredient> ingredients = service.getIngredients();
                List<ProduitCpl> produitCpls = service.getAllProduitsCpl();

                request.setAttribute("ingredients", ingredients);
                request.setAttribute("produits", produitCpls);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/attribuerRecette.jsp").forward(request, response);
        } else if (type.equalsIgnoreCase("conseilmoisinsert")) {
            try (ProduitService service = new ProduitService()) {
                List<ProduitCpl> produits = service.getAllProduitsCpl();
                request.setAttribute("produits", produits);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/conseilmoisinsert.jsp").forward(request, response);
        } else if (type.equalsIgnoreCase("conseilmoisliste")) {
            request.getRequestDispatcher("/layout/produit/conseilmoisliste.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("client")) {
            try (ProduitService service = new ProduitService()) {
                List<VenteProduit> ventes = null;
                if (request.getParameter("date") != null)
                {
                    Date date = Date.valueOf(request.getParameter("date"));
                    ventes = service.getVentesByDate(date);
                    request.setAttribute("dateInput", date);
                } else {
                    ventes = service.getVentesToday();
                }
                List<Client> clients = service.extractUniqueClients(ventes);
                request.setAttribute("ventes", ventes);
                request.setAttribute("clients", clients);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/client.jsp").forward(request, response);
        } else if (type.equalsIgnoreCase("clientstat")) {
            try (ProduitService service = new ProduitService()) {
                List<V_Client_Stat> stats = service.getClientStats();
                request.setAttribute("stats", stats);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/clientstat.jsp").forward(request, response);
        } else if (type.equalsIgnoreCase("template")) {
            try (ProduitService service = new ProduitService()) {

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/template.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");

        if (type.equalsIgnoreCase("ajouter")) {
            
            String nomProduit = request.getParameter("nom_produit");
            String typeProduitId = request.getParameter("id_type_produit");
            String dureeVie = request.getParameter("duree_vie");
            String[] saveurIds = request.getParameterValues("saveurs[]");


            try (ProduitService service = new ProduitService()) {
                service.beginTransaction();

                Produit produit = new Produit();
                produit.setDuree_vie(Integer.parseInt(dureeVie));
                produit.setNom_produit(nomProduit);
                produit.setTypeProduit(service.getTypeProduit(Integer.parseInt(typeProduitId)));

                List<SaveurProduit> saveurProduits = new ArrayList<>();
                for (String sId : saveurIds) {
                    SaveurProduit sp = new SaveurProduit();
                    sp.setSaveur(service.getContext().findById(Integer.parseInt(sId), Saveur.class));
                    saveurProduits.add(sp);
                }

                produit.setSaveurs(saveurProduits);
                service.getContext().deepSave(produit);

                service.commit();
                service.endTransaction();
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            
            request.setAttribute("titre", "Ajout Produit");
            request.setAttribute("success", "Produit ajoute correctement");
            request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
        }
        
        else if (type.equalsIgnoreCase("fabriquer")) {
            String[] quantites = request.getParameterValues("quantites[]");
            String[] produitIds = request.getParameterValues("produitId[]");

            try (ProduitService service = new ProduitService()) {
                service.beginTransaction();

                Object[] retour = service.fabriquer(produitIds, quantites);

                if ((boolean) retour[0] == true) {
                    request.setAttribute("titre", "Fabrication Produit réussi");
                    String decList = service.buildDeductionIngredientList((HashMap<Integer, Double>) retour[1]);
                    request.setAttribute("success", decList);

                    service.commit();
                    service.endTransaction();
                    request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
                }
                else {
                    String recList = service.buildRecommandationIngredientList((HashMap<Integer, Double>) retour[1]);
                    request.setAttribute("titre", "Stock insuffisant");
                    request.setAttribute("error", recList);
                    request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
                request.setAttribute("titre", "Error");
                request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
            }            
        }

        else if (type.equalsIgnoreCase("vendre")) {
            String[] quantites = request.getParameterValues("quantites[]");
            String[] produitIds = request.getParameterValues("produitId[]");
            String[] saveurIds = request.getParameterValues("saveurs[]"); // Récupération des saveurs sélectionnées

            String idClient = request.getParameter("clientId");
            try (ProduitService service = new ProduitService()) {
                service.beginTransaction();

                Client client = service.getClient(Integer.parseInt(idClient));
                Object[] retour = service.vendre(produitIds, quantites, client, saveurIds);

                if ((boolean) retour[0] == true) {
                    request.setAttribute("titre", "Vente de Produit réussi");
                    String decList = service.buildDeductionProduitList((HashMap<Integer, Double>) retour[1]);
                    request.setAttribute("success", decList);

                    service.commit();
                    service.endTransaction();
                    request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
                }
                else {
                    String recList = service.buildRecommandationProduitList((HashMap<Integer, Double>) retour[1]);
                    request.setAttribute("titre", "Stock insuffisant");
                    request.setAttribute("error", recList);
                    request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
                request.setAttribute("titre", "Error");
                request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
            }
        }

        else if (type.equalsIgnoreCase("listespec")) {
            try (ProduitService service = new ProduitService()){
                int id =  Integer.parseInt(request.getParameter("id_ingredient"));
                int idType = Integer.parseInt(request.getParameter("id_type"));
                List<FabricationProduit> listfp = service.getSelonIngredient(id, idType);
                List<TypeProduit> types = service.getTypeProduits();
                List<Ingredient> listi = service.getIngredients();
                request.setAttribute("ingredients", listi);
                request.setAttribute("fabrications", listfp);
                request.setAttribute("types", types);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/listespec.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("produire")) {
            request.setAttribute("tittre", "Production de produit");
            try (ProduitService service = new ProduitService()){
                service.beginTransaction();

                String[] ids = new String[] {request.getParameter("id_produit")};
                String[] qts = new String[] {request.getParameter("quantite")};

                Object[] retour = service.fabriquer(ids, qts);

                if ((boolean) retour[0] == true) {
                    String decList = service.buildDeductionIngredientList((HashMap<Integer, Double>) retour[1]);
                    request.setAttribute("success", decList);

                    service.commit();
                    service.endTransaction();
                    request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
                }
                else {
                    String recList = service.buildRecommandationIngredientList((HashMap<Integer, Double>) retour[1]);
                    request.setAttribute("error", recList);
                    request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("rechercheVente")) {
            try (ProduitService service = new ProduitService()) {
                int idtype =  Integer.parseInt(request.getParameter("id_type"));
                int idSaveur = Integer.parseInt(request.getParameter("id_saveur"));
                List<TypeProduit> prords = service.getTypeProduits();
                List<Saveur> savs = service.getAllSaveur();
                request.setAttribute("types", prords);
                request.setAttribute("saveurs", savs);
                List<VenteProduit> ventes = service.rechercher(idtype, idSaveur);

                request.setAttribute("ventes", ventes);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/produit/rechercheVente.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("attribuerRecette")) {
            request.setAttribute("titre", "Attribution Recette");
            try (ProduitService service = new ProduitService()) {
                service.beginTransaction();

                String[] ingredients = request.getParameterValues("ingredients[]");
                String[] quantites = request.getParameterValues("quantites[]");
                int idProduitCpl =  Integer.parseInt(request.getParameter("id_produit"));

                ProduitCpl produitCpl = service.getProduitCpl(idProduitCpl);
                if (produitCpl.getRecette() != null) {
                    throw new Exception("Produit " + produitCpl.getNomCpl() + " a deja une recette");
                }
                Recette recette = service.createRecette(ingredients, quantites);
                produitCpl.setRecette(recette);
                produitCpl.setPrix_unitaire(service.evaluatePrixProduit(recette));
                service.getContext().update(produitCpl);

                service.commit();
                service.endTransaction();
                request.setAttribute("success", "Attribution effectuee correctement");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("conseilmoisinsert")) {
            request.setAttribute("titre", "Insertion Conseil Mois");

            try (ProduitService service = new ProduitService()) {
                String idProduit = request.getParameter("id_produit");
                String dateDebut = request.getParameter("date_debut");
                String dateFin = request.getParameter("date_fin");

                java.sql.Date sqlDateDebut = java.sql.Date.valueOf(dateDebut);
                java.sql.Date sqlDateFin = java.sql.Date.valueOf(dateFin);

                if (sqlDateDebut.after(sqlDateFin)) {
                    throw new Exception("La date de début ne peut pas être supérieure à la date de fin.");
                }

                ProduitCpl produitCpl = service.getProduitCpl(Integer.parseInt(idProduit));

                ConseilMois cm = new ConseilMois();
                cm.setProduit(produitCpl);
                cm.setDate_debut(sqlDateDebut);
                cm.setDate_fin(sqlDateFin);

                service.getContext().save(cm);
                request.setAttribute("success", "Insertion reussi");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
        }

        else if (type.equalsIgnoreCase("conseilmoisliste")) {
            try (ProduitService service = new ProduitService()) {
                String moisStr = request.getParameter("mois");
                String anneeStr = request.getParameter("annee");

                int mois = Integer.parseInt(moisStr);
                int annee = Integer.parseInt(anneeStr);

                List<ConseilMois> allConseils = service.getContext().findAll(ConseilMois.class);
                List<ConseilMois> conseils = service.conseilDuMois(allConseils, mois, annee);

                request.setAttribute("moisInput", Month.of(mois).name());
                request.setAttribute("anneeInput", annee);
                request.setAttribute("conseils", conseils);
                request.getRequestDispatcher("/layout/produit/conseilmoisliste.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
        }
    }
}
