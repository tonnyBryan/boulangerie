<%@ include file="/layout/include/header.jsp" %>
<%
    List<Ingredient> ingredients = (List<Ingredient>) request.getAttribute("ingredients");
%>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item active">ingredient</li>
                <li class="breadcrumb-item active">acheter</li>
            </ol>
        </nav>
    </div>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header">
                <h4 class="mb-0">Acheter des ingr&eacute;dients</h4>
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/ingredient?type=acheter" method="POST">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Ingr&eacute;dient</th>
                                    <th>Prix</th>
                                    <th>Quantit&eacute;</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (ingredients != null && !ingredients.isEmpty()) {
                                        for (Ingredient ingredient : ingredients) {
                                %>
                                    <tr>
                                        <td>
                                            <%= ingredient.getNom_ingredient() %>
                                            <input type="hidden" name="ingredientId" value="<%= ingredient.getId_ingredient() %>">
                                        </td>
                                        <td>
                                            <%= ingredient.getPrix_unitaire() %>
                                        </td>
                                        <td>
                                            <input type="number" name="quantite_<%= ingredient.getId_ingredient() %>" class="form-control" value="0" min="0">
                                        </td>
                                    </tr>
                                <%
                                        }
                                    } else {
                                %>
                                    <tr>
                                        <td colspan="3" class="text-center">Aucun ingr&eacute;dient disponible.</td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-success">Envoyer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<%@ include file="/layout/include/footer.jsp" %>
