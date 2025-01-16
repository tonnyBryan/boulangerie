<%@ include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">app</li>
                <li class="breadcrumb-item">ingredient</li>
                <li class="breadcrumb-item active">ajouter</li>
            </ol>
        </nav>
    </div>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Ajouter un ingredient</h5>

            <form action="<%= request.getContextPath() %>/ingredient?type=ajouter" method="POST" class="row g-3">
                
                <div class="col-12">
                    <div class="form-group">
                        <label for="nom">Nom de l'ingredient</label>
                        <input type="text" class="form-control" id="nom" name="nom" required>
                    </div>
                </div>

                <div class="col-12">
                    <div class="form-group">
                        <label for="id_type_ingredient">Type d'ingredient</label>
                        <select class="form-control" id="id_type_ingredient" name="id_type_ingredient" required>
                            <option value="">Selectionner un type</option>
                            <%
                                List<TypeIngredient> types = (List<TypeIngredient>) request.getAttribute("types");
                                if (types != null) {
                                    for (TypeIngredient type : types) {
                                        out.println("<option value=\"" + type.getId_type_ingredient() + "\">" + type.getDesignation() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="col-12">
                    <div class="form-group">
                        <label for="prix_unitaire">Prix unitaire</label>
                        <input type="number" step="0.01" class="form-control" id="prix_unitaire" name="prix_unitaire" required>
                    </div>
                </div>

                <div class="col-12">
                    <div class="form-group">
                        <label for="id_unite">Unite</label>
                        <select class="form-control" id="id_unite" name="id_unite" required>
                            <option value="">Selectionner une unite</option>
                            <%
                                List<Unite> unites = (List<Unite>) request.getAttribute("unites");
                                if (unites != null) {
                                    for (Unite unite : unites) {
                                        out.println("<option value=\"" + unite.getId_unite() + "\">" + unite.getDesignation() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Bouton de soumission -->
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </div>
            </form>
        </div>
    </div>

</main>

<%@ include file="/layout/include/footer.jsp" %>
