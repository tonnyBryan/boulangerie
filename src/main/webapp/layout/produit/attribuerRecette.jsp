<%@ include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">Attribuer Recette</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <form action="<%= request.getContextPath() %>/produit?type=attribuerRecette" method="post">
            <div class="card">
                <div class="card-header">
                    <h5>Attribuer Recette produit</h5>
                </div>
                <div class="card-body">
                    <div class="mb-4">
                        <div class="mb-3">
                            <label for="produit" class="form-label">Choisir un produit</label>
                            <select class="form-select" id="produit" name="id_produit" required>
                                <option value="" disabled selected>Choisir un type</option>
                                <%
                                    List<ProduitCpl> produits = (List<ProduitCpl>) request.getAttribute("produits");
                                    if (produits != null) {
                                        for (ProduitCpl produit : produits) {
                                %>
                                <option value="<%= produit.getId_saveur_produit() %>"><%= produit.getNomCpl() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="card" style="max-height: 300px; overflow-y: auto;">
                            <div class="card-header">
                                <h5>Recette</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Ingr&eacute;dient</th>
                                                <th>Quantit&eacute; requise</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Ingredient> ingredients = (List<Ingredient>) request.getAttribute("ingredients");
                                                if (ingredients != null) {
                                                    for (Ingredient ingredient : ingredients) {
                                            %>
                                            <tr>
                                                <td>
                                                    <%= ingredient.getNom_ingredient().replace("é", "&eacute;").replace("è", "&egrave;").replace("à", "&agrave;") %>
                                                    <input type="hidden" name="ingredients[]" value="<%= ingredient.getId_ingredient() %>">
                                                </td>
                                                <td>
                                                    <input type="number" class="form-control" name="quantites[]" value="0" min="0" placeholder="Quantit&eacute; en grammes" required>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Attribuer</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>
<%@ include file="/layout/include/footer.jsp" %>
