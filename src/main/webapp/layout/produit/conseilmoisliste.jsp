<%@ include file="/layout/include/header.jsp" %>
<%
    Calendar cal = Calendar.getInstance();
    int moisActuel = cal.get(Calendar.MONTH) + 1;
    int anneeActuelle = cal.get(Calendar.YEAR);

    String[] mois = {
            "Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin",
            "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"
    };
%>


<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Conseil du mois</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <form action="<%= request.getContextPath() %>/produit?type=conseilmoisliste" method="post">
            <div class="card">
                <div class="card-header">
                    <h5>Choisir periode</h5>
                </div>
                <div class="card-body">
                    <!-- Section Informations générales -->
                    <div class="mb-4">
                        <div class="mb-3">
                            <label for="mois" class="form-label">Mois</label>
                            <select class="form-select" id="mois" name="mois" required>
                                <option value="" disabled>Choisir un mois</option>
                                <% for (int i = 0; i < mois.length; i++) { %>
                                <option value="<%= i + 1 %>" <%= (i + 1) == moisActuel ? "selected" : "" %>>
                                    <%= mois[i] %>
                                </option>
                                <% } %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="annee" class="form-label">Annee</label>
                            <input type="number" class="form-control" id="annee" name="annee" value="<%= anneeActuelle %>" required>
                        </div>
                    </div>
                    <!-- Bouton de soumission -->
                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Voir conseil</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="accordion accordion-flush" id="accordionFlushExample">
        <%
            List<ConseilMois> conseils = (List<ConseilMois>) request.getAttribute("conseils");

            if (conseils != null) {
                out.println("<h3>Conseil du " + request.getAttribute("moisInput") + " " + request.getAttribute("anneeInput") + "</h3>");
                for (ConseilMois c : conseils) {
                    ProduitCpl p = c.getProduit();
                    int idP = p.getId_saveur_produit();
                    String r = (p.getRecette() == null)? "<span class=\"badge bg-warning text-dark\"><i class=\"bi bi-exclamation-triangle me-1\"></i> Pas de recette</span>" : "";
                    String stock = (p.getQuantite_en_stock() == 0)? "<span class=\"badge bg-warning text-dark\"><i class=\"bi bi-exclamation-triangle me-1\" style=\"margin:0 !important;\"></i></span>" : "";
        %>

        <div class="accordion-item">
            <h2 class="accordion-header" id="flush-heading<%= idP %>">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse<%= idP %>" aria-expanded="false" aria-controls="flush-collapse<%= idP %>">
                    <div class="container-fluid">
                        <div class="row text-center w-100">
                            <div class="col-md-3 col-12 text-start">
                                <strong>Produit :</strong> <%= p.getNomCpl() %> <%= r %>
                            </div>
                            <div class="col-md-3 col-12 text-start">
                                <strong>Type :</strong> <%= p.getProduit().getTypeProduit().getDesignation() %>
                            </div>
                            <div class="col-md-3 col-12 text-start">
                                <strong>Prix :</strong> <%= p.getPrix_unitaire() %> Ar
                            </div>
                            <div class="col-md-3 col-12 text-start">
                                <strong>Stock :</strong> <%= p.getQuantite_en_stock() %> <%= stock %>
                            </div>
                        </div>
                    </div>
                </button>
            </h2>
            <div id="flush-collapse<%= idP %>" class="accordion-collapse collapse" aria-labelledby="flush-heading<%= idP %>" data-bs-parent="#accordionFlushExample">
                <div class="accordion-body">
                    <h6>Formules de fabrication :</h6>
                    <ul>
                        <%
                            Recette recette = p.getRecette();
                            if (recette != null) {
                                for (RecetteFille fille : recette.getRecetteFille()) {
                        %>
                        <li>
                            <strong><%= fille.getQuantite_necessaire() %></strong>
                            <%= fille.getIngredient().getUnite().getDesignation() %>
                            de <strong><%= fille.getIngredient().getNom_ingredient() %></strong>
                        </li>
                        <%
                                }
                            } else {
                                out.println("<p>Recette pas encore attribuee</p>");
                            }
                        %>
                    </ul>
                </div>
            </div>
        </div>


        <%
                }
            }
        %>
    </div>
</main>

<%@ include file="/layout/include/footer.jsp" %>
