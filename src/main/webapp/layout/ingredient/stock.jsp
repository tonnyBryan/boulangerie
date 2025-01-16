<%@ include file="/layout/include/header.jsp" %>

<%
    List<Ingredient> ingredients = (List<Ingredient>) request.getAttribute("ingredients");
%>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">ingredient</li>
                <li class="breadcrumb-item active">stock</li>
            </ol>
        </nav>
    </div>

    <div class="card">
        <div class="card-header">
            <h4 class="mb-0">Liste ingredients avec stocks</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Ingr&eacute;dient</th>
                            <th>Prix</th>
                            <th>Type</th>
                            <th>Quantit&eacute;</th>
                            <th>Unite</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (ingredients != null && !ingredients.isEmpty()) {
                                for (Ingredient ingredient : ingredients) {
                        %>
                            <tr class="<%= (ingredient.getQuantite_en_stock() == 0.0) ? "table-danger" : "" %>">
                                <td>
                                    <%= ingredient.getNom_ingredient() %>
                                </td>
                                <td>
                                    <%= ingredient.getPrix_unitaire() %>
                                </td>
                                <td>
                                    <%= ingredient.getTypeIngredient().getDesignation() %>
                                </td>
                                <td>
                                    <%= ingredient.getQuantite_en_stock() %>
                                </td>
                                <td>
                                    <%= ingredient.getUnite().getDesignation() %>
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
        </div>
    </div>


</main>
<%@ include file="/layout/include/footer.jsp" %>
