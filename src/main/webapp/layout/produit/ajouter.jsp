<%@ include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">ajouter</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <form action="<%= request.getContextPath() %>/produit?type=ajouter" method="post">
            <div class="card">
                <div class="card-header">
                    <h5>Cr&eacute;er un nouveau produit</h5>
                </div>
                <div class="card-body">
                    <!-- Section Informations générales -->
                    <div class="mb-4">
                        <div class="mb-3">
                            <label for="nom_produit" class="form-label">Nom du produit</label>
                            <input type="text" class="form-control" id="nom_produit" name="nom_produit" required>
                        </div>
                        <div class="mb-3">
                            <label for="type_produit" class="form-label">Type de produit</label>
                            <select class="form-select" id="type_produit" name="id_type_produit" required>
                                <option value="" disabled selected>Choisir un type</option>
                                <% 
                                    List<TypeProduit> types = (List<TypeProduit>) request.getAttribute("types");
                                    if (types != null) {
                                        for (TypeProduit type : types) { 
                                %>
                                    <option value="<%= type.getId_type_produit() %>"><%= type.getDesignation() %></option>
                                <% 
                                        }
                                    } 
                                %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="duree_vie" class="form-label">Dur&eacute;e de vie</label>
                            <input type="number" step="0.01" class="form-control" id="duree_vie" name="duree_vie" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="card" style="max-height: 300px; overflow-y: auto;">
                            <div class="card-header">
                                <h5>Saveur possible du produit</h5>
                            </div>
<%--                            <div class="card-body">--%>
<%--                                <div class="table-responsive">--%>
<%--                                    <table class="table">--%>
<%--                                        <thead>--%>
<%--                                            <tr>--%>
<%--                                                <th>Ingr&eacute;dient</th>--%>
<%--                                                <th>Quantit&eacute; requise</th>--%>
<%--                                            </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody>--%>
<%--                                            <% --%>
<%--                                                List<Ingredient> ingredients = (List<Ingredient>) request.getAttribute("ingredients");--%>
<%--                                                if (ingredients != null) {--%>
<%--                                                    for (Ingredient ingredient : ingredients) { --%>
<%--                                            %>--%>
<%--                                            <tr>--%>
<%--                                                <td>--%>
<%--                                                    <%= ingredient.getNom_ingredient().replace("é", "&eacute;").replace("è", "&egrave;").replace("à", "&agrave;") %>--%>
<%--                                                    <input type="hidden" name="ingredients[]" value="<%= ingredient.getId_ingredient() %>">--%>
<%--                                                </td>--%>
<%--                                                <td>--%>
<%--                                                    <input type="number" class="form-control" name="quantites[]" value="0" min="0" placeholder="Quantit&eacute; en grammes" required>--%>
<%--                                                </td>--%>
<%--                                            </tr>--%>
<%--                                            <% --%>
<%--                                                    }--%>
<%--                                                } --%>
<%--                                            %>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>

<%--                                </div>--%>
<%--                            </div>--%>


                        </div>
                        <div class="card" style="width: 18rem;">
                            <div class="card-header">
                                Liste des Saveurs
                            </div>
                            <ul class="list-group list-group-flush">
                                <%
                                    List<Saveur> saveurs = (List<Saveur>) request.getAttribute("saveurs");
                                    if (saveurs != null && !saveurs.isEmpty()) {
                                        for (Saveur saveur : saveurs) {
                                %>
                                <li class="list-group-item">
                                    <div class="form-check">
                                        <input
                                                class="form-check-input"
                                                type="checkbox"
                                                id="saveur_<%= saveur.getId_saveur() %>"
                                                name="saveurs[]"
                                                value="<%= saveur.getId_saveur() %>"
                                        >
                                        <label class="form-check-label" for="saveur_<%= saveur.getId_saveur() %>">
                                            <%= saveur.getDesignation() %>
                                        </label>
                                    </div>
                                </li>
                                <%
                                    }
                                } else {
                                %>
                                <li class="list-group-item">Aucune saveur disponible</li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>

                    <!-- Bouton de soumission -->
                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Cr&eacute;er le produit</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>

<%@ include file="/layout/include/footer.jsp" %>
