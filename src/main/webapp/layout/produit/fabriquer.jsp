<%@ include file="/layout/include/header.jsp" %>

<main id="main" class="main" style="position: relative; height: -webkit-fill-available;">
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">app</a></li>
                <li class="breadcrumb-item">produit</li>
                <li class="breadcrumb-item active">fabriquer</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h5>Liste des produits &agrave; fabriquer</h5> 
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/produit?type=fabriquer" method="post">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Nom du produit</th>
                                    <th>Qtty</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    List<ProduitCpl> produits = (List<ProduitCpl>) request.getAttribute("produits");
                                    if (produits != null) {
                                        for (ProduitCpl produit : produits) {
                                            String recette = (produit.getRecette() == null)? "<span class=\"badge bg-warning text-dark\"><i class=\"bi bi-exclamation-triangle me-1\"></i> Pas de recette</span>" : "";
                                %>
                                    <tr>
                                        <td><%= produit.getNomCpl() %> <%= recette %></td>
                                        <td>
                                            <input type="number" class="form-control" name="quantites[]" placeholder="Quantit&eacute;" value="0" required> 
                                            <input type="hidden" name="produitId[]" value="<%= produit.getId_saveur_produit() %>">
                                        </td>
                                    </tr>
                                <% 
                                        }
                                    } 
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex">
                        <button type="submit" class="btn btn-primary">Fabriquer</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

</main>

<%@ include file="/layout/include/footer.jsp" %>
