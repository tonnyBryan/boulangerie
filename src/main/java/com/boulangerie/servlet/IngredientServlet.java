package com.boulangerie.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.boulangerie.model.ingredient.Ingredient;
import com.boulangerie.model.ingredient.TypeIngredient;
import com.boulangerie.model.ingredient.Unite;
import com.boulangerie.service.IngredientService;
import com.boulangerie.service.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ingredient")
public class IngredientServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Service.analyseAttribute(request, response);

        String type = request.getParameter("type");

        if (type.equalsIgnoreCase("ajouter")) {
            try (IngredientService service = new IngredientService()) {
                List<TypeIngredient> typeIngredients = service.getAllTypeIngredient();
                List<Unite> unites = service.getAllUnite();
                
                request.setAttribute("types", typeIngredients);
                request.setAttribute("unites", unites);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/ingredient/ajouter.jsp").forward(request, response);
        } else if (type.equalsIgnoreCase("acheter")) {
            try (IngredientService service = new IngredientService()){
                List<Ingredient> ingredients = service.getIngredients();
                request.setAttribute("ingredients", ingredients);
            } catch(Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/ingredient/acheter.jsp").forward(request, response);
        } else if (type.equalsIgnoreCase("stock")) {
            try (IngredientService service = new IngredientService()){
                List<Ingredient> ingredients = service.getIngredients();
                request.setAttribute("ingredients", ingredients);
            } catch(Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/ingredient/stock.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tp = request.getParameter("type");

        if (tp.equalsIgnoreCase("ajouter")) {
            request.setAttribute("titre", "Ajout ingredient");

            String nom = request.getParameter("nom");
            String idTypeIngredient = request.getParameter("id_type_ingredient");
            String prixUnitaire = request.getParameter("prix_unitaire");
            String idUnite = request.getParameter("id_unite");
        
            try (IngredientService service = new IngredientService()) {
                TypeIngredient type = service.findTypeIngredient(Integer.parseInt(idTypeIngredient));
                Unite unite = service.findUnite(Integer.parseInt(idUnite));

                Ingredient ingredient = new Ingredient();
                ingredient.setNom_ingredient(nom);
                ingredient.setPrix_unitaire(Double.parseDouble(prixUnitaire));
                ingredient.setTypeIngredient(type);
                ingredient.setUnite(unite);
                
                service.saveIngredient(ingredient);
                request.setAttribute("success", "Ingredient inseree");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
        }
        
        else if (tp.equalsIgnoreCase("acheter")) {

            request.setAttribute("titre", "Achat ingredient");
            Map<String, String[]> parameterMap = request.getParameterMap();
            try (IngredientService service = new IngredientService()) {
                service.beginTransaction();

                service.acheter(parameterMap, request, response, service);
                
                service.commit();
                service.endTransaction();
                request.setAttribute("success", "Ingredient acheté correctement");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            }
            request.getRequestDispatcher("/layout/result.jsp").forward(request, response);
        }
    }
}
